import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  StripeService._();
  static final StripeService instance = StripeService._();

  // Initiate the payment process
  Future<void> makePayment(
      double totalPrice, Function onSuccess, Function onFailure) async {
    try {
      // Create a payment intent on the server
      String? paymentIntentClientSecret = await _createPaymentIntent(
        totalPrice,
        "egp",
      );
      if (paymentIntentClientSecret == null) return;

      // Initialize the payment sheet with the client secret
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentClientSecret,
            merchantDisplayName: "Eventure"),
      );

      // Display the payment sheet and process the payment
      await _processPayment(onFailure);

      onSuccess();
    } catch (e) {
      print(e);
    }
  }

  Future<String?> _createPaymentIntent(
      double totalPrice, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "amount": _baseCurrency(totalPrice),
        "currency": currency
      };
      var response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer ${dotenv.env["STRIPE_SK"]}",
            "Content-Type": "application/x-www-form-urlencoded",
          },
        ),
      );
      if (response.data != null) {
        // print(response.data);
        return response.data["client_secret"];
      }
      return null;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> _processPayment(Function onFailure) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      await Stripe.instance.confirmPaymentSheetPayment();
    } on StripeException catch (e) {
      // Catch Stripe exceptions
      if (e.error.code == FailureCode.Canceled) {
        print("Payment canceled by the user");
      } else {
        onFailure();
        print("Payment error: ${e.error.localizedMessage}");
      }
    } catch (e) {
      // Other errors in payment processing
      print(e);
    }
  }

  String _baseCurrency(double amount) {
    final baseCurrency = amount * 100;
    return baseCurrency.toInt().toString();
  }
}

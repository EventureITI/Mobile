import 'package:eventure/models/event.dart';
import 'package:eventure/screens/payment_screens/fail_screen.dart';
import 'package:eventure/screens/payment_screens/success_screen.dart';
import 'package:eventure/services/stripe_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class GetTicketScreen extends StatefulWidget {
  GetTicketScreen({super.key});

  @override
  _GetTicketScreenState createState() => _GetTicketScreenState();
}

class _GetTicketScreenState extends State<GetTicketScreen> {
  Event event = Get.arguments;
  int numberOfTickets = 1;
  late double totalPrice = double.parse(event.price);

  handlePaymentSuccess() {
    Get.off(() => PaymentSuccessScreen(), arguments: {
      "event": event,
      "numberOfTickets": numberOfTickets,
      "totalPrice": totalPrice,
    });
  }

  handlePaymentFailure() {
    Get.off(() => PaymentFailScreen());
  }

  void updateTicketCount(int change) {
    setState(() {
      numberOfTickets += change;
      if (numberOfTickets < 1) numberOfTickets = 1;
      totalPrice = double.parse(event.price) * numberOfTickets;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get a Ticket',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            )),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              "Select Ticket",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(0xFF292929),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "${event.startTime} - ${event.endTime}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF858585),
                    ),
                  ),
                  Text(
                    event.fullEventDate,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF858585),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${event.price} EGP",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => updateTicketCount(-1),
                            child: SvgPicture.asset(
                              "assets/icons/cart_minus.svg",
                              width: 24,
                              height: 24,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "$numberOfTickets",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => updateTicketCount(1),
                            child: SvgPicture.asset(
                              "assets/icons/cart_plus.svg",
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Payment Method",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(0xFF292929), // Background color
                borderRadius: BorderRadius.circular(16), // Border radius
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Stripe",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white, // Text color for contrast
                    ),
                  ),
                  SizedBox(width: 20),
                  SvgPicture.asset(
                    "assets/icons/stripe.svg",
                    width: 24,
                    height: 24,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Color(0xFF292929),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total price\n${totalPrice.toString()} EGP",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFF4FE0D2),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                StripeService.instance.makePayment(
                  totalPrice,
                  handlePaymentSuccess,
                  handlePaymentFailure,
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    "assets/icons/ticket_fill.svg",
                    width: 16,
                    height: 16,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Pay Now",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white, // Text color
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

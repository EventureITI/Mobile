import 'package:eventure/screens/payment_screens/fail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF151515),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Main Image Section
              Column(
                children: [
                  SizedBox(height: 100),
                  SvgPicture.asset(
                    "assets/images/Illustration_success.svg",
                    width: 300,
                    height: 225,
                  ),
                  SizedBox(height: 32),
                  Text(
                    "Payment Successful",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Your event ticket has been booked and is available in your profile",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF949494),
                    ),
                  ),
                  SizedBox(height: 32),
                  Container(
                    width: double.infinity,
                    height: 48,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                PaymentFailScreen(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF4FE0D2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Color(0xFF4FE0D2),
                              width: 1,
                            )),
                      ),
                      child: Text(
                        'View My Tickets',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    // margin: EdgeInsets.only(top: 16),
                    width: double.infinity,
                    height: 48,
                    child: TextButton(
                      onPressed: () {
                        //! TODO
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0x801F1F1F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: Color(0xFF4FE0D2),
                            width: 1,
                          ),
                        ),
                      ),
                      child: Text(
                        'Back to Event',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

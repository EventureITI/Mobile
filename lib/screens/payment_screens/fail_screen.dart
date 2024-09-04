import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentFailScreen extends StatelessWidget {
  const PaymentFailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
                    "assets/images/Illustration_fail.svg",
                    width: 300,
                    height: 225,
                  ),
                  SizedBox(height: 32),
                  Text(
                    "Something Went Wrong",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "We couldn't process your payment. Please try again or contact support for assistance",
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
                        ///
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

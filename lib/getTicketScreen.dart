import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GetTicketScreen extends StatelessWidget {
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
            // the back button
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
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
                color: Color(0xFF292929), // Background color
                borderRadius: BorderRadius.circular(16), // Border radius
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ismailia Art Festival 2024, ITI Ismailia",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white, // Text color for contrast
                    ),
                  ),
                  Text(
                    "07:00 PM - 10:00 PM",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF858585), // Text color for contrast
                    ),
                  ),
                  Text(
                    "Saturday, Sep 14",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF858585), // Text color for contrast
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "600 EGP",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white, // Text color for contrast
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/prime_minus.svg",
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "1",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white, // Text color for contrast
                            ),
                          ),
                          SizedBox(width: 4),
                          SvgPicture.asset(
                            "assets/ic_round-plus.svg",
                            width: 24,
                            height: 24,
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
              color: Color(0xFF292929),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total price\n600.00 EGP",
                    style: TextStyle(
                      color: Colors.white, // Text color to match the design
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xFF4FE0D2), // Background color
                      padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 8), // Padding inside the button
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(16), // Rounded corners
                      ),
                    ),
                    onPressed: () {
                      // Handle button press
                    },
                    child: Row(
                      mainAxisSize:
                          MainAxisSize.min, // To keep the button size compact
                      children: [
                        SvgPicture.asset(
                          "assets/Icon-pain.svg",
                          width: 16,
                          height: 16,
                        ),
                        SizedBox(width: 8), // Space between icon and text
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
            )
          ],
        ),
      ),
    );
  }
}

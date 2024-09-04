import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 320,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/kinglear.jfif"),
                        fit: BoxFit.cover),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 320,
                  color: Colors.black.withOpacity(0.25),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width,
                  height: 320,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Color(0xFF151515),
                        Color(0x00000000),
                      ],
                      stops: [0.0, 0.30],
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "King Lear",
                      style: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "King Lear decides to distribute his property among his three daughters, and because his youngest daughter refuses to fawn over him, he casts her off. While distributing the property, he stipulates that he reside with each of his daughters for a certain period, but his two older daughters decide to seize everything and expel their father.",
                    style: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff858585),
                        height: 1.2),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Hours",
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "September 14, 2024 - 07:00PM - 10:00PM",
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff858585),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Location",
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Cairo Show, The Marquee Theater, New Cairo 1, Cairo Governorate ",
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff858585),
                    ),
                    textAlign: TextAlign.left,
                  )
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
              "Price\n600.00 EGP",
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
              onPressed: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    "assets/Icon-pain.svg",
                    width: 16,
                    height: 16,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Book Now",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
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

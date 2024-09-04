import 'package:eventure/screens/contact_screen.dart';
import 'package:eventure/screens/profile_screens/user_tickets_screen.dart';
import 'package:eventure/utils/text_colors.dart';
import 'package:eventure/widgets/custom_text.dart';
import 'package:eventure/widgets/profile_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: bgColor,
        child: Column(
          children: <Widget>[
            CustomText(
              text: "Profile",
              color: Colors.white,
              size: 22,
            ),
            SizedBox(
              height: 32,
            ),
            SvgPicture.asset(
              "assets/icons/avatar_placeholder.svg",
              height: 96,
              width: 96,
            ),
            SizedBox(
              height: 16,
            ),
            CustomText(
              text: "User Name",
              color: Colors.white,
              size: 25,
            ),
            SizedBox(
              height: 32,
            ),
            ProfileOption(
                optionIcon: "assets/icons/ticket_outline.svg",
                optionText: "Your Tickets",
                nextScreen: UserTicketsScreen()),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: inpBg,
            ),
            ProfileOption(
                optionIcon: "assets/icons/acc.svg",
                optionText: "Edit Profile",
                nextScreen: UserTicketsScreen()),
            ProfileOption(
                optionIcon: "assets/icons/contact.svg",
                optionText: "Contact Us",
                nextScreen: ContactScreen()),
            ProfileOption(
                optionIcon: "assets/icons/logout.svg",
                optionText: "Log Out",
                nextScreen: UserTicketsScreen()),
          ],
        ),
      ),
    );
  }
}

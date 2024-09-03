import 'package:eventure/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileOption extends StatelessWidget {
  String? optionIcon;
  String? optionText;
  ProfileOption({super.key,required this.optionIcon,required this.optionText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        margin: EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: [
                  SvgPicture.asset("$optionIcon"),
                  SizedBox(width: 8,),
                  CustomText(text: "$optionText", color: Colors.white,),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_sharp, size: 15, color: Colors.white,)
          ],
        ),
      ),
    );
  }
}
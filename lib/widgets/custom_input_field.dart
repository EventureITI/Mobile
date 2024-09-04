import 'package:eventure/utils/text_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class CustomInputfield extends StatelessWidget {
  TextInputType? inpType;
  String? label;
  bool? scure;
  Widget? suffixIcn;
  String? hint;
  CustomInputfield(
      {super.key,
      this.hint,
      this.label,
      this.scure,
      this.suffixIcn,
      this.inpType});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$label',
          style: TextStyle(
            color: titleColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        TextFormField(
          keyboardType: inpType,
          obscureText: scure!,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              filled: true,
              fillColor: inpBg,
              hintText: hint,
              hintStyle: TextStyle(color: hintColor, fontSize: 14),
              suffixIcon: suffixIcn,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: btnColor),
                  borderRadius: BorderRadius.circular(15))),
        ),
      ],
    );
  }
}

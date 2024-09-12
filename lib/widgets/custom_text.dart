import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final Color? color;
  final FontWeight? ftWeight;
  final double? size;
  const CustomText(
      {super.key, required this.text, this.color, this.ftWeight, this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      style: TextStyle(
        color: color ?? Color(0xff13B8A8),
        fontSize: size ?? 16,
        fontWeight: ftWeight ?? FontWeight.w500,
      ),
    );
  }
}

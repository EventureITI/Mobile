import 'package:flutter/material.dart';

Widget customFormField(
    String label, String hint, TextEditingController controller,
    {int maxLines = 1, String? Function(String?)? validator}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.0),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0x1F1F1F80)),
              borderRadius: BorderRadius.circular(10.0),
            ),
            filled: true,
            fillColor: Color(0xFF333333),
          ),
        ),
      ],
    ),
  );
}

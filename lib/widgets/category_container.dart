import 'package:flutter/material.dart';

class CategoryContainer extends StatefulWidget {
  final String catName;
  final Color? activeClr;

  const CategoryContainer({super.key, required this.catName, this.activeClr});

  @override
  State<CategoryContainer> createState() => _CategoryContainerState();
}

class _CategoryContainerState extends State<CategoryContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.symmetric(horizontal: 16),
      // width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: widget.activeClr ?? Color(0x33C9C9C9),
      ),
      child: Center(child: Text(widget.catName)),
    );
  }
}

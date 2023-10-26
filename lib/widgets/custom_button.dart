import 'package:flutter/material.dart';

import '../constants/styles/color_styles.dart';
import '../constants/styles/text_styles.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final String text;
  void Function()? onTap;
  CustomButton({
    super.key,
    this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: ShapeDecoration(
          color: MyColors.defaultColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: MyTextStyle.style22,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../constants/styles/color_styles.dart';
import '../constants/styles/text_styles.dart';

Padding buildTotalPrice({required String price}) {
  return Padding(
    padding: const EdgeInsets.only(
      bottom: 16,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Total',
          textAlign: TextAlign.center,
          style: MyTextStyle.style24,
        ),
        Text(
          '\$$price',
          textAlign: TextAlign.center,
          style: MyTextStyle.style24,
        )
      ],
    ),
  );
}

Padding myDivider() {
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 14,
    ),
    child: Container(
      width: 320,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 2,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: MyColors.secondaryColor,
          ),
        ),
      ),
    ),
  );
}

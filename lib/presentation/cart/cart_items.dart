import 'package:flutter/material.dart';

import '../../constants/styles/text_styles.dart';

Padding buildDetailsPay({required String text, required String price}) {
  return Padding(
    padding: const EdgeInsets.only(
      bottom: 3,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
          style: MyTextStyle.style18,
        ),
        Text(
          '\$$price',
          textAlign: TextAlign.center,
          style: MyTextStyle.style18,
        )
      ],
    ),
  );
}

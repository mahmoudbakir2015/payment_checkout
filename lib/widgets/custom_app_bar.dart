import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../constants/styles/text_styles.dart';

AppBar customAppBar(
    {required String title,
    bool isNotCart = true,
    required BuildContext context}) {
  return AppBar(
    iconTheme: const IconThemeData(color: Colors.black),
    elevation: 0,
    backgroundColor: Colors.transparent,
    centerTitle: true,
    leading: GestureDetector(
      onTap: () {
        if (isNotCart == true) {
          Navigator.pop(context);
        }
      },
      child: Center(
        child: SvgPicture.asset(
          'assets/images/arrow_back.svg',
        ),
      ),
    ),
    title: Text(
      title,
      textAlign: TextAlign.center,
      style: MyTextStyle.style25,
    ),
  );
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

Widget appRichText(String title, String subTitle,
    {void Function() onTap, Color titleColor, Color subTitleColor, TextDecoration decoration}) {
  return RichText(
    // Controls visual overflow
    overflow: TextOverflow.clip,
    textAlign: TextAlign.center,
    maxLines: 1,
    text: TextSpan(
      text: title,
      style:
          TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: titleColor ?? blackColor),
      children: <TextSpan>[
        TextSpan(
            text: subTitle,
            recognizer: TapGestureRecognizer()..onTap = onTap,
            style: TextStyle(
              color: subTitleColor ?? appColor,
              decoration: decoration,
            )),
      ],
    ),
  );
}

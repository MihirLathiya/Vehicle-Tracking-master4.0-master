import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicletracking/utils/app_colors.dart';

class AppFillButton extends StatelessWidget {
  final double height;
  final double width;
  final String title;
  final Color buttonColor;
  final double radius;
  final double fontSize;
  final void Function() onTap;
  const AppFillButton(
      {Key key,
      this.width,
      this.height,
      this.buttonColor,
      this.radius,
      this.fontSize,
      this.title,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fHeight = 60.0;
    var fWidth = Get.width;
    return SizedBox(
      height: height ?? fHeight,
      width: width ?? fWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(radius ?? 30.0),
            ),
          ),
          // shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
        onPressed: onTap,
        child: Text(
          title,
          style:
              TextStyle(fontSize: fontSize ?? 18.0, fontWeight: FontWeight.w600, color: whiteColor),
        ),
      ),
    );
  }
}

class AppBorderButton extends StatelessWidget {
  final double height;
  final double width;
  final String title;
  final Color buttonColor;
  final double radius;
  final double fontSize;
  final void Function() onTap;
  const AppBorderButton(
      {Key key,
      this.width,
      this.height,
      this.buttonColor,
      this.radius,
      this.title,
      this.fontSize,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fHeight = 60.0;
    var fWidth = Get.width;
    return SizedBox(
      height: height ?? fHeight,
      width: width ?? fWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: whiteColor,
          side: BorderSide(color: buttonColor ?? appColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(radius ?? 30.0),
            ),
          ),
          elevation: 0.0,
          // shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
        onPressed: onTap,
        child: Text(
          title,
          style: TextStyle(
              fontSize: fontSize ?? 18.0,
              fontWeight: FontWeight.w600,
              color: buttonColor ?? appColor),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vehicletracking/utils/app_colors.dart';

class AppTextField extends StatelessWidget {
  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final String initialValue;
  final int errorMaxLines;
  final int maxLines;
  final int maxLength;
  final bool enabled;
  final bool autofocus;
  final bool obscureText;
  final Color filledColor;
  final Color cursorColor;
  final Color borderColor;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final FocusNode focusNode;
  final TextStyle style;
  final TextStyle textStyle;
  final TextStyle hintStyle;
  final TextStyle labelStyle;
  final TextAlign textAlign;
  final TextEditingController controller;
  final List<TextInputFormatter> inputFormatters;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final GestureTapCallback onTap;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onFieldSubmitted;
  final BorderRadius borderRadius;
  const AppTextField(
      {Key key,
      this.fieldKey,
      this.hintText,
      this.labelText,
      this.helperText,
      this.borderRadius,
      this.initialValue,
      this.errorMaxLines,
      this.maxLines,
      this.maxLength,
      this.enabled,
      this.autofocus = false,
      this.obscureText = false,
      this.filledColor,
      this.cursorColor,
      this.borderColor,
      this.prefixIcon,
      this.suffixIcon,
      this.focusNode,
      this.style,
      this.textStyle,
      this.hintStyle,
      this.labelStyle,
      this.textAlign = TextAlign.left,
      this.controller,
      this.inputFormatters,
      this.textInputAction,
      this.keyboardType,
      this.textCapitalization = TextCapitalization.none,
      this.onTap,
      this.onSaved,
      this.validator,
      this.onChanged,
      this.onFieldSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: fieldKey,
      controller: controller,
      focusNode: focusNode,
      maxLines: obscureText ? 1 : maxLines,
      initialValue: initialValue,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      obscureText: obscureText,
      enabled: enabled,
      validator: validator,
      maxLength: maxLength,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      onTap: onTap,
      onSaved: onSaved,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      autocorrect: true,
      autofocus: autofocus,
      textAlign: textAlign,
      cursorColor: greyColor,
      cursorHeight: 20,
      style: textStyle,
      // AppTextStyle.normalSemiBold14.copyWith(color: textBlackColor),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        // contentPadding:
        //     const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: borderColor ?? appColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: appColor),
          borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(4.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: borderGreyColor),
          borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(4.0)),
        ),
        border: textFieldBorderDecoration,
        // errorMaxLines: 5,
        fillColor: filledColor ?? whiteColor.withOpacity(0.7),
        filled: true,
        hintStyle: hintStyle,
        labelStyle: labelStyle ?? TextStyle(color: greyColor.withOpacity(.7)),
        // AppTextStyle.normalRegular16.copyWith(color: textGreyColor),
        hintText: hintText,
        suffixIcon: suffixIcon,
        labelText: labelText,
        helperText: helperText,
      ),
    );
  }
}

OutlineInputBorder textFieldBorderDecoration = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10.0),
  borderSide: BorderSide(
    color: greyColor.withOpacity(0.4),
  ),
);

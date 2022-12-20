// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vehicletracking/utils/app_colors.dart';
import 'package:vehicletracking/utils/validators.dart';

Widget newTextFormFiled(
    {final String labelText,
    final TextEditingController controller,
    List<TextInputFormatter> inputFormatter,
    int maxLength,
    borderColor}) {
  return TextFormField(
    controller: controller,
    inputFormatters: inputFormatter,
    maxLength: maxLength,
    decoration: InputDecoration(
      labelText: labelText,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor ?? borderGreyColor),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: appColor),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

class EmailWidget extends StatelessWidget {
  const EmailWidget(
      {Key key,
      this.fieldKey,
      this.hintText,
      this.style,
      this.controller,
      this.textInputAction,
      this.keyboardType,
      this.enabled,
      this.focusNode,
      this.borderSide})
      : super(key: key);
  final Key fieldKey;
  final String hintText;
  final TextStyle style;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool enabled;
  final BorderSide borderSide;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return textFormField(
      fieldKey: fieldKey,
      hintText: hintText,
      hintStyle: const TextStyle(color: whiteColor),
      style: const TextStyle(color: whiteColor),
      enabled: enabled,
      focusNode: focusNode,
      controller: controller,
      cursorColor: whiteColor,
      textInputAction: textInputAction,
      filledColor: blackColor,
      keyboardType: TextInputType.emailAddress,
      border: borderSide,
      focusBorder: borderSide,
      enabledBorder: borderSide,
      validator: (value) => Validators.validateEmail(value.trim()),
    );
  }
}

// ignore: must_be_immutable
class PasswordWidget extends StatefulWidget {
  PasswordWidget({
    Key key,
    this.fieldKey,
    this.hintText,
    this.validator,
    this.controller,
    this.focusNode,
    this.textInputAction,
    this.showsuffixIcon,
    this.borderSide,
  }) : super(key: key);

  final Key fieldKey;
  final String hintText;
  final FormFieldValidator<String> validator;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final BorderSide borderSide;
  bool showsuffixIcon = true;

  @override
  _PasswordWidgetState createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return textFormField(
      fieldKey: widget.fieldKey,
      hintText: widget.hintText,
      hintStyle: const TextStyle(color: whiteColor),
      style: const TextStyle(color: whiteColor),
      filledColor: blackColor,
      border: widget.borderSide,
      focusBorder: widget.borderSide,
      enabledBorder: widget.borderSide,
      focusNode: widget.focusNode,
      controller: widget.controller,
      textInputAction: widget.textInputAction,
      cursorColor: whiteColor,
      obscureText: _obscureText,
      validator: widget.validator ?? (value) => Validators.validatePassword(value.trim()),
      suffixIcon: widget.showsuffixIcon == true
          ? GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: greyColor,
              ),
            )
          : const SizedBox(),
    );
  }
}

class NumberWidget extends StatelessWidget {
  const NumberWidget({
    this.fieldKey,
    this.hintText,
    this.validator,
    this.controller,
    this.maxLength,
    this.focusNode,
    this.autofocus,
    this.style,
    this.textInputAction,
    this.textAlign = TextAlign.left,
    this.inputFormatters,
    this.keyboardType,
    this.fillColor,
  });

  final Key fieldKey;
  final String hintText;
  final List<TextInputFormatter> inputFormatters;
  final FormFieldValidator<String> validator;
  final TextEditingController controller;
  final int maxLength;
  final FocusNode focusNode;
  final bool autofocus;
  final TextStyle style;
  final TextInputAction textInputAction;
  final TextAlign textAlign;
  final TextInputType keyboardType;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return textFormField(
      keyboardType: keyboardType,
      fieldKey: fieldKey,
      hintText: hintText,
      focusNode: focusNode,
      controller: controller,
      style: style,
      filledColor: fillColor,
      validator: validator,
      textAlign: textAlign,
      maxLength: maxLength,
      textInputAction: textInputAction,
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp('[a-zA-Z]'))],
    );
  }
}

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.validator,
    this.prefixIcon,
    this.controller,
    this.focusNode,
    this.maxLines,
    this.maxLength,
    this.suffixIcon,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.textInputAction,
    this.keyboardType,
    this.filledColor,
    this.hintStyle,
    this.style,
    this.focusBorder,
    this.border,
    this.enabledBorder,
    this.cursorColor,
    this.textAlign = TextAlign.left,
  });

  final Key fieldKey;
  final String hintText;
  final String labelText;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final ValueChanged<String> onChanged;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final TextEditingController controller;
  final FocusNode focusNode;
  final GestureTapCallback onTap;
  final int maxLines;
  final int maxLength;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final TextAlign textAlign;
  final Color filledColor;
  final Color cursorColor;
  final TextStyle style;
  final TextStyle hintStyle;
  final BorderSide focusBorder;
  final BorderSide border;
  final BorderSide enabledBorder;

  @override
  Widget build(BuildContext context) {
    return textFormField(
      fieldKey: fieldKey,
      focusNode: focusNode,
      hintText: hintText,
      filledColor: filledColor,
      style: style,
      hintStyle: hintStyle,
      controller: controller,
      cursorColor: cursorColor ?? whiteColor,
      keyboardType: keyboardType,
      validator: validator,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      maxLength: maxLength,
      maxLines: maxLines,
      textInputAction: textInputAction,
      textAlign: textAlign,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      focusBorder: focusBorder,
      border: border,
      enabledBorder: enabledBorder,
    );
  }
}

class TextAreaWidget extends StatelessWidget {
  const TextAreaWidget({
    this.fieldKey,
    this.hintText,
    this.validator,
    this.controller,
    this.focusNode,
    this.maxLines,
    this.maxLength,
    this.filledColor,
  });

  final Key fieldKey;
  final int maxLines;
  final int maxLength;
  final String hintText;
  final Color filledColor;
  final FormFieldValidator<String> validator;

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return textFormField(
      keyboardType: TextInputType.text,
      focusNode: focusNode,
      fieldKey: fieldKey,
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      hintText: hintText,
      filledColor: filledColor,
    );
  }
}

// ignore: must_be_immutable
class SearchBar extends StatelessWidget {
  final Function(String) onChanged;
  TextEditingController controller;

  SearchBar({
    this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextFormFieldWidget(
        hintText: "Search",
        cursorColor: greyColor,
        border: BorderSide(color: greyColor.withOpacity(0.50)),
        focusBorder: BorderSide(color: greyColor.withOpacity(0.50)),
        enabledBorder: BorderSide(color: greyColor.withOpacity(0.50)),
        filledColor: whiteColor,
        hintStyle: const TextStyle(
          fontSize: 15,
          color: greyColor,
        ),
        controller: controller,
        onChanged: onChanged,
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: greyColor,
          size: 20,
        ),
      ),
    );
  }
}

TextFormField textFormField({
  final Key fieldKey,
  final String hintText,
  final String labelText,
  final String helperText,
  final String initialValue,
  final int errorMaxLines,
  final int maxLines,
  final int maxLength,
  final bool enabled,
  final bool autofocus = false,
  final bool obscureText,
  final Color filledColor,
  final Color cursorColor,
  final prefixIcon,
  final Widget suffixIcon,
  final FocusNode focusNode,
  final TextStyle style,
  final TextStyle hintStyle,
  final TextAlign textAlign = TextAlign.left,
  final TextEditingController controller,
  final List<TextInputFormatter> inputFormatters,
  final TextInputAction textInputAction,
  final TextInputType keyboardType,
  final TextCapitalization textCapitalization = TextCapitalization.none,
  final GestureTapCallback onTap,
  final FormFieldSetter<String> onSaved,
  final FormFieldValidator<String> validator,
  final ValueChanged<String> onChanged,
  final ValueChanged<String> onFieldSubmitted,
  final BorderSide focusBorder,
  final BorderSide enabledBorder,
  final BorderSide border,
}) {
  return TextFormField(
    key: fieldKey,
    controller: controller,
    focusNode: focusNode,
    maxLines: maxLines ?? 1,
    initialValue: initialValue,
    keyboardType: keyboardType,
    textCapitalization: textCapitalization,
    obscureText: obscureText ?? false,
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
    cursorColor: cursorColor ?? blackColor,
    cursorHeight: 20,
    style: style,
    decoration: InputDecoration(
      prefixIcon: prefixIcon,
      contentPadding: const EdgeInsets.fromLTRB(26, 16, 0, 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: border ?? BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: enabledBorder ?? const BorderSide(color: borderGreyColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: focusBorder ?? const BorderSide(color: appColor),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: appColor),
      ),
      errorMaxLines: 5,
      fillColor: filledColor,
      filled: true,
      hintStyle: hintStyle,
      hintText: hintText,
      counterText: "",
      suffixIcon: suffixIcon,
      labelText: labelText,
      helperText: helperText,
    ),
  );
}

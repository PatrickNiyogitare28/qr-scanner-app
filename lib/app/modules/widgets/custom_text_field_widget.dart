import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scan_app/app/common/utils/exports.dart';
import 'package:scan_app/app/common/utils/validators.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String? labelText, hintText;
  final String? initialValue, prefixText, suffixText;
  final Widget? prefixIcon, suffixIcon;
  final TextInputType keyboardType;
  final FormFieldValidator<String?>? validator;
  final TextEditingController? controller;
  final ValueChanged<String?>? onChanged, onSaved;
  final int? maxLength, maxLines;
  final int minLines;
  final bool readOnly, addHint, enabled;
  final bool? isDense;
  final Function()? onTap;
  final InputBorder? border;
  final AutovalidateMode autovalidateMode;
  final BoxConstraints? suffixIconConstraints;
  final EdgeInsets? prefixIconPadding;
  final Color? fillColor;

  const CustomTextFieldWidget({
    Key? key,
    this.labelText,
    this.hintText,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.validator = Validators.validateEmpty,
    this.onChanged,
    this.onSaved,
    this.maxLength,
    this.maxLines,
    this.minLines = 1,
    this.initialValue,
    this.readOnly = false,
    this.onTap,
    this.border,
    this.enabled = true,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.addHint = false,
    this.suffixIconConstraints,
    this.prefixText,
    this.suffixText,
    this.isDense,
    this.prefixIconPadding,
    this.fillColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle.regularStyle.copyWith(
      color: AppColors.mineShaft,
      fontSize: Dimens.fontSize15,
    );
     final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30), // Adjust the border radius as needed
      borderSide: BorderSide(color: AppColors.lightSilver), // Set the border color here
    );

    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      initialValue: initialValue,
      keyboardType: keyboardType,
      autovalidateMode: autovalidateMode,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      minLines: minLines,
      maxLines: maxLines,
      onSaved: onSaved,
      enabled: enabled,
      inputFormatters: maxLength == null
          ? null
          : [
              LengthLimitingTextInputFormatter(maxLength),
              if (keyboardType == TextInputType.number)
                FilteringTextInputFormatter.digitsOnly,
            ],
      decoration: InputDecoration(
        fillColor: fillColor,
        filled: fillColor != null,
        isDense: isDense,
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        // alignLabelWithHint: maxLines == null,
        labelText: addHint
            ? null
            : ((controller?.text != null || !readOnly) ? labelText : null),
        // hintText: hintText,
        labelStyle: const TextStyle(color: AppColors.lightSilver),
        prefixIconConstraints: BoxConstraints(
          maxHeight: 40.h,
          maxWidth: 40.w,
        ),
        prefixIcon: prefixIcon == null
            ? null
            : Padding(
                padding: prefixIconPadding ?? EdgeInsets.only(right: 10.w),
                child: prefixIcon,
              ),
        prefixText: prefixText,
        suffixText: suffixText,
        prefixStyle: textStyle,
        suffixStyle: textStyle,
        suffixIcon: suffixIcon == null
            ? null
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: suffixIcon,
              ),
        suffixIconConstraints: suffixIconConstraints ??
            BoxConstraints(
              maxHeight: 40.h,
              maxWidth: 40.w,
            ),
      ),
    );
  }
}

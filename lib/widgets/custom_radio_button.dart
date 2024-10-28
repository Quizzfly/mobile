import 'package:flutter/material.dart';
import '../core/app_export.dart';

extension CustomRadioButtonStyleHelper on CustomRadioButton {
  static BoxDecoration get outlineBlueGray => BoxDecoration(
        color: theme.colorScheme.onErrorContainer,
        borderRadius: BorderRadius.circular(10.h),
        border: Border.all(
          color: appTheme.blueGray10002,
          width: 0.h,
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.blueGray10002.withOpacity(0.25),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(4, 4),
          ),
        ],
      );

  static BoxDecoration customStyle({
    required Color backgroundColor,
    required Color borderColor,
    double borderWidth = 1,
    double borderRadius = 10,
    List<BoxShadow>? shadows,
  }) {
    return BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(borderRadius.h),
      border: Border.all(
        color: borderColor,
        width: borderWidth.h,
      ),
      boxShadow: shadows,
    );
  }
}

class CustomRadioButton extends StatelessWidget {
  CustomRadioButton({
    Key? key,
    required this.onChange,
    this.decoration,
    this.alignment,
    this.isRightCheck,
    this.iconSize,
    this.value,
    this.groupValue,
    this.text,
    this.width,
    this.padding,
    this.textStyle,
    this.overflow,
    this.textAlignment,
    this.backgroundColor,
    this.gradient,
    this.height,
    this.unselectedColor,
    this.isExpandedText = false,
  }) : super(key: key);

  final BoxDecoration? decoration;
  final Alignment? alignment;
  final bool? isRightCheck;
  final double? iconSize;
  final String? value;
  final String? groupValue;
  final Function(String?) onChange;
  final String? text;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final TextOverflow? overflow;
  final TextAlign? textAlignment;
  final bool isExpandedText;
  final Gradient? gradient;
  final Color? backgroundColor;
  final double? height;
  final Color? unselectedColor;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildRadioButtonWidget,
          )
        : buildRadioButtonWidget;
  }

  Widget get buildRadioButtonWidget => GestureDetector(
        onTap: () {
          onChange(value);
        },
        child: Container(
          decoration: decoration,
          width: width ?? double.infinity,
          padding: padding,
          height: height,
          child: (isRightCheck ?? false) ? rightSideRadio : leftSideRadio,
        ),
      );

  Widget get leftSideRadio => Row(
        children: [
          radioWidget,
          SizedBox(
            width: text != null && text!.isNotEmpty ? 8 : 0,
          ),
          Expanded(
            child: textWidget,
          ),
        ],
      );

  Widget get rightSideRadio => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: textWidget,
          ),
          SizedBox(
            width: text != null && text!.isNotEmpty ? 8 : 0,
          ),
          radioWidget,
        ],
      );

  Widget get textWidget => Text(
        text ?? "",
        textAlign: textAlignment ?? TextAlign.start,
        overflow: overflow,
        style: textStyle ?? CustomTextStyles.bodyMediumGraphik,
      );

  Widget get radioWidget => SizedBox(
        height: iconSize ?? 20.h,
        width: iconSize ?? 20.h,
        child: Radio<String>(
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          value: value ?? "",
          groupValue: groupValue,
          activeColor: theme.colorScheme.primary,
          fillColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return theme.colorScheme.primary;
              }
              return unselectedColor ?? appTheme.blueGray100; // Màu mặc định khi không được chọn
            },
          ),
          onChanged: (value) {
            onChange(value);
          },
        ),
      );
}

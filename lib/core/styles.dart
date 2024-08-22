import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Styles {
  /// App Settings

  //Color
  static Color get colorPrimary => Color(0xFF05101C);

  static Color get colorSecondry => Color(0xFFDD623A);

  static Color get colorIconActive => Color(0xFF05101C);

  static Color get colorDivider => Color(0xFF05101C);

  static Color get colorIconInActive => Color(0xFF363636);

  static Color get colorBackground => Color(0xFF2D2D2D);

  static Color get colorBackgroundNavBar => Color(0xFFFFFFFF);

  static Color get colorShadow => Color(0x0000000);

  static Color get colorBackgroundAppBar => Color(0xFFFFFFFF);

  static Color get colorGradientStart => Color(0xFF435A73);

  static Color get colorGradientEnd => Color(0xFF182A3E);

  static Color get colorReplay => Color(0xFFAACFF1);

  static Color get colorBackgroundGradientStart => Color(0xFF05101C);

  static Color get colorBackgroundGradientEnd => Color(0xFF040f1c);

  static Color get colorStoryGradientStart => Color(0x4C425973);

  static Color get colorStoryGradientEnd => Color(0x4C172A3E);

  static Color get colorTextInactive => Color(0xFF05101C);

  static Color get colorBackArrowIcon => Color(0xFF7662B3);

  static Color get colorTextTitle => Color(0xFF363636);

  static Color get colorStorygradient1 => Color(0xFFFFED001A);

  static Color get colorStorygradient2 => Color(0xFF00A75D1A);

  static Color get colorStorygradient3 => Color(0xFF009FE31A);

  static Color get colorTextDialogDangerTitle => Color(0xFFF2994A);

  static Color get colorTextTextField => Color(0xFF4F4F4F);

  static Color get colorBackgroundContanier => Color(0xFFFFFFFF);

  static Color get colorBackgroundWithIconContanier => Color(0xFFF1F1F1);

  static Color get colorBorderTextField => Color(0xFFE0E0E0);

  static Color get colorTextWhite => Color(0xFFFFFFFF);

  static Color get colorTextError => Color(0xFFEB5757);

  /// font
  static const FontFamily = 'Alexandria';
  static const FontFamilyBlack = 'Alexandria';
  static const FontFamilyBold = 'Alexandria';
  static const FontFamilySemiBold = 'Alexandria';
  static const FontFamilyLight = 'Alexandria';
  static const FontFamilyMedium = 'Alexandria';
  static const FontFamilyRegular = 'Alexandria';

  /// font
  // static const FontFamilyArb = 'ArbFONTS';
  // static const FontFamilyBoldArb = 'ArbFONTS';
  // static const FontFamilyLightArb = 'ArbFONTS';
  // static const FontFamilyRegularArb = 'ArbFONTS';
  static const FontFamilyArb = 'SarmadyVF';
  static const FontFamilyBoldArb = 'SarmadyVF';
  static const FontFamilyLightArb = 'SarmadyVF';
  static const FontFamilyRegularArb = 'SarmadyVF';

  static double fontSizeCustom(double size) => size;

  static TextStyle get fontStyle => TextStyle(fontFamily: FontFamily);

  static TextStyle get fontW500Style =>
      TextStyle(fontFamily: FontFamily, color: colorTextTitle);

  static TextStyle get fontW300Style =>
      TextStyle(fontFamily: FontFamily, color: colorTextTitle);

  static StrutStyle get structStyle => StrutStyle(fontFamily: FontFamily);

  static BoxDecoration tilesDecoration = BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(10.r),
      ),
      border: Border.all(color: Color(0xFFAFCEEB).withOpacity(0.09)),
      boxShadow: [
        BoxShadow(
          blurRadius: 10,
          spreadRadius: 0,
          offset: Offset(0, 5), // changes position of shadow
        )
      ],
      color: Colors.white);

  static TextStyle w700TextStyle() => fontStyle.copyWith(
      fontSize: 10.sp,
      fontWeight: FontWeight.w700,
      height: 1.2,
      overflow: TextOverflow.fade,
      // fontFamily: !isArb ? FontFamilyBoldArb : Styles.FontFamily,
      fontFamily: FontFamilyBoldArb,
      color: colorTextTitle);

  static TextStyle w400TextStyle() => fontStyle.copyWith(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      fontFamily: FontFamilyRegularArb,
      height: 1.2,
      overflow: TextOverflow.fade,
      color: colorTextTitle);

  static TextStyle w300TextStyle() => fontStyle.copyWith(
      fontSize: 10.sp,
      fontWeight: FontWeight.w300,
      height: 1.2,
      overflow: TextOverflow.fade,
      fontFamily: FontFamilyLightArb,
      color: colorTextTitle);

  static TextStyle w600TextStyle() => fontStyle.copyWith(
      fontSize: 10.sp,
      fontWeight: FontWeight.w600,
      height: 1.2,
      overflow: TextOverflow.fade,
      fontFamily: FontFamilyBoldArb,
      color: colorTextTitle);

  static TextStyle w500TextStyle() => fontStyle.copyWith(
      fontSize: 10.sp,
      height: 1.2,
      overflow: TextOverflow.fade,
      fontWeight: FontWeight.w500,
      color: colorTextTitle);

  static BoxDecoration coloredRoundedDecoration(
          {double radius = 5,
          Color borderColor = const Color(0xFF488B89),
          Color color = const Color(0xFFFFFFFF),
          List<BoxShadow> boxShadow = const []}) =>
      BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
          border: Border.all(color: borderColor),
          color: color,
          boxShadow: boxShadow);

  static BoxDecoration gradientRoundedDecoration(
          {double radius = 5,
          Color borderColor = const Color(0xFF488B89),
          Color color = const Color(0xFFFFFFFF),
          List<Color>? gradientColor,
          BorderRadiusGeometry? customBorder,
          AlignmentGeometry? alignmentGeometryBegin,
          AlignmentGeometry? alignmentGeometryEnd,
          List<BoxShadow> boxShadow = const []}) =>
      BoxDecoration(
          borderRadius: customBorder ??
              BorderRadius.all(
                Radius.circular(radius),
              ),
          gradient: LinearGradient(
            colors: gradientColor ?? [colorGradientStart, colorGradientEnd],
            begin: alignmentGeometryBegin ?? Alignment(0.5, 1),
            end: alignmentGeometryEnd ?? Alignment(0.5, 1),
          ),
          boxShadow: boxShadow);

  static TextStyle formInputTextStyle = fontStyle.copyWith(
      fontWeight: FontWeight.w200, fontFamily: Styles.FontFamily);
  static InputDecoration formInputDecoration = InputDecoration(
      border: InputBorder.none, filled: true, fillColor: Colors.white);

  static InputDecoration borderedRoundedFieldDecoration({double radius = 40}) =>
      formInputDecoration.copyWith(
          border: roundedOutlineInputBorder(radius: radius),
          focusedBorder: roundedOutlineInputBorder(radius: radius),
          enabledBorder: roundedOutlineInputBorder(radius: radius),
          errorBorder: roundedOutlineInputBorder(radius: radius)
              .copyWith(borderSide: BorderSide(color: Colors.red)),
          focusedErrorBorder: roundedOutlineInputBorder(radius: radius)
              .copyWith(borderSide: BorderSide(color: Colors.red)),
          disabledBorder: roundedOutlineInputBorder(radius: radius),
          contentPadding: EdgeInsets.all(10),
          filled: true,
          fillColor: Colors.white);

  static InputBorder roundedTransparentBorder({double radius = 40}) =>
      OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: 2.0),
        borderRadius: BorderRadius.circular(radius),
      );

  static InputBorder roundedOutlineInputBorder({double radius = 40}) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          color: Styles.colorPrimary,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(radius),
      );
}

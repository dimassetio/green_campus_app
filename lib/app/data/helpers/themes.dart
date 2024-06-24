import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color mainColor = Color(0XFF1DB954);
Color lightColor = Color(0XFFCCFCCB);
Color secondBg = Color(0XFFF4FFF7);

Color secondaryColor = Color(0XFFEDF880);
Color bgColor = Color(0XFFF5F5F5);
Color bgColorDark = Color(0XFF1E1E1E);
Color bgColorDark2 = Color(0XFF2C2C2C);
// Color bgColor = Color(0XFFF2F8FF);
Color textColor = Color(0XFF333333);
Color textColorDark = Color(0XFFF5F5F5);
Color secondTextColor = Color(0XFF888888);
Color clrGrey = Color(0XFFD9D9D9);
Color clr_white = Color(0XFFFFFFFF);
Color clrSoftRed = Color(0XFFFF6C6C);

ThemeData mainTheme = ThemeData.from(
    colorScheme: ColorScheme(
  brightness: Brightness.light,
  primary: mainColor,
  onPrimary: clr_white,
  secondary: secondaryColor,
  onSecondary: textColor,
  error: Colors.red[600]!,
  onError: clr_white,
  background: bgColor,
  onBackground: textColor,
  surface: clr_white,
  onSurface: textColor,
)).copyWith(
    textTheme: GoogleFonts.poppinsTextTheme().apply(bodyColor: textColor),
    dividerColor: clrGrey);

ThemeData darkTheme = ThemeData.from(
    colorScheme: ColorScheme(
  brightness: Brightness.dark,
  primary: mainColor,
  onPrimary: clr_white,
  secondary: secondaryColor,
  onSecondary: textColor,
  error: Colors.red[600]!,
  onError: clr_white,
  background: bgColorDark,
  onBackground: textColorDark,
  surface: bgColorDark2,
  onSurface: textColorDark,
)).copyWith(
    primaryColorDark: mainColor,
    primaryColor: mainColor,
    textTheme: GoogleFonts.poppinsTextTheme().apply(bodyColor: textColorDark),
    dividerColor: clrGrey);
// ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: mainColor));

ThemeData theme(context) => Theme.of(context);
TextTheme textTheme(context) => Theme.of(context).textTheme;
Color primaryColor(context) => theme(context).primaryColor;

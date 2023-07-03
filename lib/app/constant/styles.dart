import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

const Color backgroundColor1 = Color(0XFFFFFFFF);
const Color backgroundColor2 = Color(0XFFF8F8F8);
const Color titleColor = Color(0XFF1E3833);
const Color buttonColor1 = Color(0XFF53998B);
const Color buttonColor2 = Color(0XFFFFCB24);
const Color grey50 = Color(0XFFF1F1F1);
const Color grey100 = Color(0XFFE1E1E1);
const Color grey400 = Color(0XFF919191);
const Color grey500 = Color(0XFF717171);
const Color grey900 = Color(0XFF1F1F1F);
const Color errColor = Colors.red;
const Color succColor = Colors.green;
double heightDevice = Get.height;
double widthDevice = Get.width;

const Color dark = Color(0XFF1E3833);
const Color backBar = Color(0XFFDDDDDD);

// final myTextTheme = TextTheme(
//     //Large Title 34px
//     subtitle1: GoogleFonts.jost(
//       fontSize: 26.sp,
//       fontWeight: FontWeight.bold,
//       letterSpacing: 0.15,
//     ),

//     // Heading 1 30px
//     headline1: GoogleFonts.jost(
//       fontSize: 23.sp,
//       fontWeight: FontWeight.bold,
//       letterSpacing: -1.5,
//     ),

//     //Heading 2 28px
//     headline2: GoogleFonts.jost(
//       fontSize: 21.sp,
//       fontWeight: FontWeight.w600,
//     ),

//     //Heading 3 22px
//     headline3: GoogleFonts.jost(
//       fontSize: 17.sp,
//       fontWeight: FontWeight.w600,
//     ),

//     //Body 17px reguler
//     headline4: GoogleFonts.jost(
//       fontSize: 13.sp,
//       fontWeight: FontWeight.normal,
//     ),

//     //Body 20px reguler
//     bodyText1: GoogleFonts.jost(
//       fontSize: 15.sp,
//       letterSpacing: 0.5,
//     ),

//     //Body 15px reguler
//     bodyText2: GoogleFonts.jost(
//       fontSize: 11.sp,
//       fontWeight: FontWeight.w400,
//     ),

//     //Body 17px semibold
//     button: GoogleFonts.jost(
//       fontSize: 13.sp,
//       fontWeight: FontWeight.w600,
//     ),

//     //Caption 12px reguler
//     caption: GoogleFonts.jost(
//       fontSize: 9.sp,
//       letterSpacing: 0.4,
//     ),

//     //Small 10px
//     overline: GoogleFonts.jost(
//       fontSize: 8.sp,
//     ));

final myTextTheme = TextTheme(
    //Large Title 34px
    titleMedium: GoogleFonts.jost(
      fontSize: 26.sp,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.15,
    ),

    // Heading 1 30px
    displayLarge: GoogleFonts.jost(
      fontSize: 23.sp,
      fontWeight: FontWeight.bold,
      letterSpacing: -1.5,
    ),

    //Heading 2 28px
    displayMedium: GoogleFonts.jost(
      fontSize: 21.sp,
      fontWeight: FontWeight.w600,
    ),

    //Heading 3 22px
    displaySmall: GoogleFonts.jost(
      fontSize: 17.sp,
      fontWeight: FontWeight.w600,
    ),

    //Body 17px reguler
    headlineMedium: GoogleFonts.jost(
      fontSize: 13.sp,
      fontWeight: FontWeight.normal,
    ),

    //Body 20px reguler
    bodyLarge: GoogleFonts.jost(
      fontSize: 15.sp,
      letterSpacing: 0.5,
    ),

    //Body 15px reguler
    bodyMedium: GoogleFonts.jost(
      fontSize: 11.sp,
      fontWeight: FontWeight.w400,
    ),

    //Body 17px semibold
    labelLarge: GoogleFonts.jost(
      fontSize: 13.sp,
      fontWeight: FontWeight.w600,
    ),

    //Caption 12px reguler
    bodySmall: GoogleFonts.jost(
      fontSize: 9.sp,
      letterSpacing: 0.4,
    ),

    //Small 10px
    labelSmall: GoogleFonts.jost(
      fontSize: 8.sp,
    ));

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// text style
final TextStyle kHeadingLarge =
    GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w700);
final TextStyle kHeading5 =
    GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w400);
final TextStyle kHeading6 = GoogleFonts.poppins(
    fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15);
final TextStyle kHeading7 = GoogleFonts.poppins(
    fontSize: 17, fontWeight: FontWeight.w500, letterSpacing: 0.15);
final TextStyle kSubtitle = GoogleFonts.poppins(
    fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15);
final TextStyle kBodyText = GoogleFonts.poppins(
    fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.25);
final TextStyle kBodyTextGrey = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w300,
    letterSpacing: 0.25,
    color: Colors.grey.shade700);

// text theme
final kTextTheme = TextTheme(
  headlineMedium: kHeading5,
  headlineSmall: kHeading6,
  titleSmall: kSubtitle,
  bodyLarge: kBodyText,
);
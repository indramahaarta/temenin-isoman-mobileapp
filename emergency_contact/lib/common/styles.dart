import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFFE91E63);
const Color secondaryColor = Color(0xFFA7C7E7);
const Color darkPrimaryColor = Color(0xFF000000);
const Color darkSecondaryColor = Color(0xFF202A44);

final TextTheme myTextTheme = TextTheme(
  headline1: GoogleFonts.oswald(
    fontSize: 92,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
    color: Colors.white,
  ),
  headline2: GoogleFonts.oswald(
    fontSize: 57,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
    color: Colors.white,
  ),
  headline3: GoogleFonts.oswald(
    fontSize: 46,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  ),
  headline4: GoogleFonts.oswald(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: Colors.white,
  ),
  headline5: GoogleFonts.oswald(
    fontSize: 23,
    fontWeight: FontWeight.w400,
  ),
  headline6: GoogleFonts.oswald(
    fontSize: 19,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  ),
  subtitle1: GoogleFonts.oswald(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    color: Colors.white,
  ),
  subtitle2: GoogleFonts.oswald(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    color: Colors.white,
  ),
  bodyText1: GoogleFonts.oswald(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.20,
  ),
  bodyText2: GoogleFonts.oswald(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  button: GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
  ),
  caption: GoogleFonts.montserrat(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  ),
  overline: GoogleFonts.montserrat(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
  ),
);

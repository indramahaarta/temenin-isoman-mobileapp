import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFFE91E63);
const Color secondaryColor = Color(0xFFA7C7E7);
const Color darkPrimaryColor = Color(0xFF000000);
const Color darkSecondaryColor = Color(0xFF202A44);
const Color btnColor = Color(0xFFF7E165);


final TextTheme myTextTheme = TextTheme(
  headline1: GoogleFonts.merriweather(
    fontSize: 92,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
    color: Colors.white,
  ),
  headline2: GoogleFonts.merriweather(
    fontSize: 57,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
    color: Colors.white,
  ),
  headline3: GoogleFonts.merriweather(
    fontSize: 46,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  ),
  headline4: GoogleFonts.merriweather(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: Colors.white,
  ),
  headline5: GoogleFonts.merriweather(
    fontSize: 23,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  ),
  headline6: GoogleFonts.merriweather(
    fontSize: 19,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  ),
  subtitle1: GoogleFonts.merriweather(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    color: Colors.white,
  ),
  subtitle2: GoogleFonts.merriweather(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    color: Colors.white,
  ),
  bodyText1: GoogleFonts.merriweather(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.20,
  ),
  bodyText2: GoogleFonts.merriweather(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  button: GoogleFonts.merriweatherSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
    color: Color(0xFF2F2F2F),
  ),
  caption: GoogleFonts.merriweather(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  ),
  overline: GoogleFonts.merriweather(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
  ),
);

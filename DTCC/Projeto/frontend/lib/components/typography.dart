import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eclinic/components/color.dart';

// Simple
TextStyle headlineTextStyle = GoogleFonts.montserrat(
    textStyle: const TextStyle(
        fontSize: 26,
        color: textPrimary,
        letterSpacing: 1.5,
        fontWeight: FontWeight.w300));

TextStyle headlineSecondaryTextStyle = GoogleFonts.montserrat(
    textStyle: const TextStyle(
        fontSize: 20, color: textPrimary, fontWeight: FontWeight.w300));

TextStyle subtitleTextStyle = GoogleFonts.openSans(
    textStyle:
        const TextStyle(fontSize: 14, color: textSecondary, letterSpacing: 1));

TextStyle bodyTextStyle = GoogleFonts.openSans(
    textStyle: const TextStyle(fontSize: 14, color: textPrimary));

TextStyle buttonTextStyle = GoogleFonts.montserrat(
    textStyle:
        const TextStyle(fontSize: 14, color: textPrimary, letterSpacing: 1));

TextStyle tituloH1 = GoogleFonts.montserrat(
    textStyle: const TextStyle(
        fontSize: 34,
        color: textPrimary,
        letterSpacing: 0.5,
        fontWeight: FontWeight.w400));

TextStyle tituloH2 = GoogleFonts.montserrat(
    textStyle: const TextStyle(
        fontSize: 24,
        color: textPrimary,
        letterSpacing: 0.5,
        fontWeight: FontWeight.w400));

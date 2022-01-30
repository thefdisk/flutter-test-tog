import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme() {
  return ThemeData(
    fontFamily: GoogleFonts.poppins().fontFamily,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.greenAccent,
    ),
  );
}

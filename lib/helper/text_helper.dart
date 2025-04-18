import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TextHelper {
  static Size textSize(String text, TextStyle? style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  // ====== TextStyles =======
  static final displayTextStyle = GoogleFonts.openSans(
    color: Colors.white.withOpacity(0.85),
    fontSize: 36.r,
    fontWeight: FontWeight.bold,
  );

  static final headerTextStyle = GoogleFonts.openSans(
    color: Colors.white60,
    fontSize: 18.r,
    fontWeight: FontWeight.w600,
  );

  static final buttonTextStyle = GoogleFonts.openSans(
    color: Colors.white70,
    fontWeight: FontWeight.bold,
    fontSize: 16.r,
  );

  static final forgotPassTextStyle = GoogleFonts.openSans(
    color: Colors.white60,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
    fontSize: 12.r,
  );

  static final captionTextStyle = GoogleFonts.openSans(
    color: Colors.white30,
    fontSize: 11.r,
    fontWeight: FontWeight.w400,
  );

  static final textFieldTextStyle = GoogleFonts.openSans(
    fontSize: 16.r,
    fontWeight: FontWeight.w600,
    color: Colors.white70,
  );

  static final textFieldHintTextStyle = GoogleFonts.openSans(
    fontSize: 16.r,
    fontWeight: FontWeight.w400,
    color: Colors.white.withOpacity(0.5),
  );

  static final pageSwitcherTextStyle = GoogleFonts.openSans(
    fontSize: 14.r,
    fontWeight: FontWeight.w400,
    color: Colors.white.withOpacity(0.50),
  );

  static final appBarTextStyle = GoogleFonts.openSans(
    fontSize: 12.r,
    fontWeight: FontWeight.normal,
    color: Colors.white.withOpacity(0.80),
  );

  static final homeTextStyle = GoogleFonts.poppins(
    fontSize: 22.r,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static final dialogHeaderTextStyle = GoogleFonts.openSans(
    color: Colors.white.withOpacity(0.85),
    fontSize: 20.r,
    fontWeight: FontWeight.w600,
  );

  static final dialogCaptionTextStyle = GoogleFonts.openSans(
    color: Colors.white38,
    fontSize: 12.r,
    fontStyle: FontStyle.italic,
  );

  static final captionButtonTextStyle = GoogleFonts.openSans(
    color: Colors.white70,
    fontSize: 12.r,
    fontWeight: FontWeight.w600,
  );

  static final countryPickerTextStyle = GoogleFonts.openSans(
    color: Colors.white.withOpacity(0.9),
    fontSize: 14.r,
    fontWeight: FontWeight.normal,
  );

  static final snackBarTitleTextStyle = GoogleFonts.openSans(
    color: Colors.white.withOpacity(0.9),
    fontSize: 16.r,
    fontWeight: FontWeight.normal,
  );

  static final snackBarMessageTextStyle = GoogleFonts.openSans(
    color: Colors.white.withOpacity(0.85),
    fontSize: 12.r,
    fontWeight: FontWeight.normal,
  );
}

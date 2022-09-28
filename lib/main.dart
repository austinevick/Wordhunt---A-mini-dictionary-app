import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordhunt/screen/word_search_screen.dart';
import 'common/constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wordhunt',
      theme: ThemeData(
        textTheme: TextTheme(
            headline6: GoogleFonts.notoSerif(),
            bodyText2: GoogleFonts.notoSerif(),
            bodyText1: GoogleFonts.notoSerif()),
      ),
      color: appColor,
      debugShowCheckedModeBanner: false,
      home: const WordSearchScreen(),
    );
  }
}

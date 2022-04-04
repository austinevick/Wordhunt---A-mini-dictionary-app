import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constant.dart';
import 'screen/word_search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wordhunt',
      color: appColor,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
              headline6: GoogleFonts.notoSerif(),
              bodyText2: GoogleFonts.notoSerif(),
              bodyText1: GoogleFonts.notoSerif())),
      home: const WordSearchScreen(),
    );
  }
}

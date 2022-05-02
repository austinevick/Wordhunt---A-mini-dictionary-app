import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wordhunt/screen/word_search_screen.dart';
import 'constant.dart';

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

class Test {
  final controller = StreamController<DateTime>();

  Stream<DateTime> updateTime(BuildContext context) async* {
    Timer.periodic(
        const Duration(seconds: 10), (t) => controller.add(DateTime.now()));
    controller.stream.listen((event) {
      showDialog(
          context: context,
          builder: (ctx) => const AlertDialog(
                title: Text('Hello dear'),
                content: Text('You got a new message'),
              ));
    });
  }
}

class H extends StatelessWidget {
  const H({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamProvider<DateTime>(
      create: (_) => Test().updateTime(context),
      initialData: DateTime.now(),
      child: Text('Hello'),
    ));
  }
}

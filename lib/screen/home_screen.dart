import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:wordhunt/main.dart';
import '../constant.dart';
import '../model/word_model.dart';

class HomeScreen extends StatefulWidget {
  final WordModel? model;
  const HomeScreen({Key? key, this.model}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios, color: appColor)),
                const SizedBox(height: 20),
                Text(widget.model!.word!, style: style),
                Row(
                  children: [
                    Text(
                      widget.model!.phonetics![0].text!,
                      style: const TextStyle(color: appColor),
                    ),
                    widget.model!.phonetics![0].audio!.isEmpty
                        ? IconButton(
                            onPressed: () async {
                              try {
                                await audioPlayer
                                    .play(widget.model!.phonetics![1].audio!);
                              } on SocketException catch (_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    snackBar('No internet connection'));
                                rethrow;
                              }
                            },
                            icon: const Icon(Icons.volume_up, color: appColor))
                        : IconButton(
                            onPressed: () async {
                              try {
                                await audioPlayer
                                    .play(widget.model!.phonetics![0].audio!);
                              } on SocketException catch (_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    snackBar('No internet connection'));
                                rethrow;
                              }
                            },
                            icon: const Icon(Icons.volume_up, color: appColor)),
                  ],
                ),
                const SizedBox(height: 10),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(
                            widget.model!.meanings!.length,
                            (i) => Padding(
                                  padding: const EdgeInsets.only(right: 6.0),
                                  child: OutlinedButton(
                                    style: ButtonStyle(
                                        side: MaterialStateProperty.all(
                                            BorderSide(
                                                width: 2.8,
                                                color: selectedIndex == i
                                                    ? appColor
                                                    : Colors.grey))),
                                    onPressed: () =>
                                        setState(() => selectedIndex = i),
                                    child: Text(widget
                                        .model!.meanings![i].partOfSpeech!),
                                  ),
                                ))),
                  ),
                  const SizedBox(height: 15),
                  Text('Definitions', style: style.copyWith(fontSize: 16)),
                  const SizedBox(height: 5),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                          widget.model!.meanings![selectedIndex].definitions!
                              .length, (i) {
                        final m =
                            widget.model!.meanings![selectedIndex].definitions!;
                        return Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: '${i + 1}. ',
                                style: style.copyWith(
                                    fontSize: 14, color: Colors.black)),
                            TextSpan(
                                text: m[i].definition!,
                                style: style.copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                    color: Colors.black))
                          ])),
                        );
                      })),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      widget.model!.meanings![selectedIndex].definitions![0]
                              .synonyms!.isEmpty
                          ? Container()
                          : Column(
                              children: [
                                Text('Synonyms',
                                    style: style.copyWith(fontSize: 16)),
                                Column(
                                    children: List.generate(
                                  widget.model!.meanings![selectedIndex]
                                      .definitions![0].synonyms!.length,
                                  (i) {
                                    final m = widget
                                        .model!
                                        .meanings![selectedIndex]
                                        .definitions![0]
                                        .synonyms![i];
                                    return Text(m);
                                  },
                                ))
                              ],
                            ),
                      widget.model!.meanings![selectedIndex].definitions![0]
                              .antonyms!.isEmpty
                          ? Container()
                          : Column(
                              children: [
                                Text('Antonyms',
                                    style: style.copyWith(fontSize: 16)),
                                Column(
                                    children: List.generate(
                                  widget.model!.meanings![selectedIndex]
                                      .definitions![0].antonyms!.length,
                                  (i) {
                                    final m = widget
                                        .model!
                                        .meanings![selectedIndex]
                                        .definitions![0]
                                        .antonyms![i];
                                    return Text(m);
                                  },
                                ))
                              ],
                            ),
                    ],
                  )
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}

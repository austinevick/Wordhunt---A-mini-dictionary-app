import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wordhunt/loading_widget.dart';
import 'package:wordhunt/provider/word_search_provider.dart';

import '../constant.dart';
import '../model/word_model.dart';
import '../repository/word_search_repository.dart';
import 'home_screen.dart';

class WordSearchScreen extends StatefulWidget {
  const WordSearchScreen({Key? key}) : super(key: key);

  @override
  State<WordSearchScreen> createState() => _WordSearchScreenState();
}

class _WordSearchScreenState extends State<WordSearchScreen> {
  final controller = TextEditingController();
  List<String> searchResult = [];
  bool isLoading = false;

  Future<WordModel?> wordSearchResult() async {
    if (controller.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar('Please enter a text'));
      return null;
    }
    try {
      setState(() => isLoading = true);

      WordModel model = await WordSearchRepository.getWordData(controller.text);
      if (model.word != null) {
        setState(() => isLoading = false);
        await WordSearchProvider.saveWordHistory([model.word!]);
        await Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => HomeScreen(model: model)));
        controller.clear();
      } else {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar('Something went wrong'));
      }
      return model;
    } on SocketException catch (_) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar('No internet connection'));
      rethrow;
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    Future<List<String>> search = WordSearchProvider.getWordHistory();
    await search.then((value) => setState(() => searchResult = value));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 14.0,
            right: 14,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              const Text(
                'Dictionary',
                style: style,
              ),
              const SizedBox(height: 18),
              TextField(
                cursorColor: Colors.black,
                cursorWidth: 1,
                onEditingComplete: () async => await wordSearchResult(),
                onSubmitted: (value) =>
                    WordSearchProvider.saveWordHistory([controller.text]),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                ),
                controller: controller,
                decoration: InputDecoration(
                    fillColor: Colors.grey.withOpacity(0.2),
                    filled: true,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: 'Search here',
                    suffixIcon: IconButton(
                        onPressed: () async => await wordSearchResult(),
                        icon: LoadingWidget(
                            isLoading: isLoading,
                            child: const Icon(
                              Icons.arrow_forward_ios,
                            ))),
                    prefixIcon: const Icon(Icons.search)),
              ),
              const SizedBox(height: 20),
              const Text('Recent', style: style),
              const SizedBox(height: 10),
              Column(
                children: List.generate(
                    searchResult.length,
                    (i) => InkWell(
                          onTap: () =>
                              setState(() => controller.text = searchResult[i]),
                          child: SizedBox(
                            height: 30,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                searchResult[i],
                                style: style.copyWith(fontSize: 15),
                              ),
                            ),
                          ),
                        )),
              )
            ],
          ),
        ),
      )),
    );
  }
}

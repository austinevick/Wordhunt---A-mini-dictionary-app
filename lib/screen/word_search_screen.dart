import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wordhunt/loading_widget.dart';
import 'package:wordhunt/model/word_history_model.dart';
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
  List<WordHistoryModel> searchResult = [];
  bool isLoading = false;
  String word = '';
  Future<WordModel?> wordSearchResult(String word) async {
    FocusScope.of(context).unfocus();
    if (word.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar('Please enter a text'));
      return null;
    }
    try {
      setState(() => isLoading = true);
      WordModel model = await WordSearchRepository.getWordData(word);
      if (model.word != null) {
        setState(() => isLoading = false);
        await WordSearchProvider.saveWordHistory(
            WordHistoryModel(word: model.word, dateTime: DateTime.now()));
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
    } catch (_) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar('${controller.text}not found'));
      rethrow;
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    Future<List<WordHistoryModel>> search = WordSearchProvider.getWordHistory();
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
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
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
                  onEditingComplete: () async =>
                      await wordSearchResult(controller.text)
                          .whenComplete(() => init()),
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
                          onPressed: () async =>
                              await wordSearchResult(controller.text)
                                  .whenComplete(() => init()),
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
                searchResult.isEmpty
                    ? Center(
                        child: Text('Your search history will appear here',
                            style: style.copyWith(
                                fontSize: 14, color: Colors.grey)))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            searchResult.length,
                            (i) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.grey)),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () async {
                                              setState(() => controller.text =
                                                  searchResult[i].word!);
                                              await wordSearchResult(
                                                  controller.text);
                                            },
                                            child: SizedBox(
                                              height: 40,
                                              width: double.infinity,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  searchResult[i].word!,
                                                  style: style.copyWith(
                                                      fontSize: 15),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () => WordSearchProvider
                                                    .deleteHistory(
                                                        searchResult[i].id!)
                                                .whenComplete(() => init()),
                                            icon: const Icon(Icons.clear))
                                      ],
                                    ),
                                  ),
                                )),
                      )
              ],
            ),
          ),
        )),
      ),
    );
  }
}

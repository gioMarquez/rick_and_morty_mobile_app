

import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/api/rick_api.dart';
import 'package:rick_and_morty_app/models/character.dart';
import 'package:rick_and_morty_app/pages/character_detail_page.dart';
import 'package:rick_and_morty_app/widgets/character_card.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final scrollController = ScrollController();
  List<Character> characters = [];
  int page = 1;
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    loadData();
    scrollController.addListener(_pagination);
  }

  void _pagination() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 100 &&
        !isLoading &&
        hasMore) {
      loadData();
    }
  }

  Future<void> loadData() async {
    setState(() => isLoading = true);

    final data = await RickApi.getCharacters(page);

    setState(() {
      characters.addAll(data["characters"]);
      hasMore = data["hasMore"];
      page++;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F232B),
      appBar: AppBar(
        title: const Text("Rick & Morty", style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFF24282F),
      ),
      body: ListView.builder(
        controller: scrollController,
        itemCount: characters.length + (isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == characters.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final c = characters[index];

          return CharacterCard(
            character: c,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CharacterDetailPage(character: c),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

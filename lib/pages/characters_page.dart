import 'dart:async';
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

  Timer? _debounce;
  String searchName = "";
  String searchStatus = "";

  @override
  void initState() {
    super.initState();
    // carga inicial
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
    // Evitar reentradas accidentales
    if (isLoading) return;

    setState(() => isLoading = true);

    try {
      final data = await RickApi.getCharacters(
        page: page,
        name: searchName,
        status: searchStatus,
      );

      final List<Character> fetched =
          (data["characters"] as List<Character>?) ?? <Character>[];

      setState(() {
        // Si es la primera página, reemplazamos la lista. Si no, hacemos append.
        if (page == 1) {
          characters = fetched;
        } else {
          characters.addAll(fetched);
        }
        hasMore = data["hasMore"] == true;
        // Si llegaron resultados, aumentamos la página para la siguiente petición
        if (fetched.isNotEmpty) page++;
      });
    } catch (e, st) {
      // Loguea el error en consola para que lo puedas ver en el debug console
      debugPrint('Error en loadData: $e\n$st');

      // Si hubo error, asumimos que no hay más resultados por ahora
      setState(() {
        hasMore = false;
        // Si estamos en la primera página y falla, dejamos characters vacío
        if (page == 1) characters = [];
      });
    } finally {
      // Siempre aseguramos que isLoading pase a false
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    scrollController.dispose();
    super.dispose();
  }

  Widget _buildBody() {
    // Si estamos cargando y no hay items aún, mostramos spinner central
    if (isLoading && characters.isEmpty) {
      return const Center(
          child: CircularProgressIndicator(
        strokeWidth: 2,
        color: Colors.white,
      ));
    }

    // Si no hay resultados y no estamos cargando -> mensaje
    if (!isLoading && characters.isEmpty) {
      // Mostrar mensaje distinto si el usuario buscó algo o no
      final searched = (searchName.isNotEmpty || searchStatus.isNotEmpty);
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            searched
                ? "No hay personajes que coincidan con tu búsqueda."
                : "No hay personajes para mostrar.",
            style: const TextStyle(color: Colors.white70, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    // Lista normal (incluye indicador al final cuando isLoading == true)
    return ListView.builder(
      controller: scrollController,
      itemCount: characters.length + (isLoading && hasMore ? 1 : 0),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F232B),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          backgroundColor: const Color(0xFF24282F),
          flexibleSpace: Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  "Personajes Rick & Morty",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F232B),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      if (_debounce?.isActive ?? false) _debounce!.cancel();

                      _debounce = Timer(const Duration(seconds: 1), () {
                        final q = value.trim();
                        if (q == searchName) return;

                        setState(() {
                          searchName = q;
                          page = 1;
                          characters.clear();
                          hasMore = true;
                        });
                        loadData();
                      });
                    },
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Buscar personaje...",
                      hintStyle: TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            PopupMenuButton<String>(
              color: const Color(0xFF2C313A),
              icon: const Icon(Icons.filter_list, color: Colors.white),
              onSelected: (value) {
                if (value == searchStatus) return;
                setState(() {
                  searchStatus = value;
                  page = 1;
                  characters.clear();
                  hasMore = true;
                  _debounce?.cancel();
                });
                loadData();
              },
              itemBuilder: (_) => const [
                PopupMenuItem(
                    value: "",
                    child:
                        Text("Todos", style: TextStyle(color: Colors.white))),
                PopupMenuItem(
                    value: "alive",
                    child:
                        Text("Alive", style: TextStyle(color: Colors.white))),
                PopupMenuItem(
                    value: "dead",
                    child: Text("Dead", style: TextStyle(color: Colors.white))),
                PopupMenuItem(
                    value: "unknown",
                    child:
                        Text("Unknown", style: TextStyle(color: Colors.white))),
              ],
            ),
          ],
        ),
      ),
      body: _buildBody(),
    );
  }
}

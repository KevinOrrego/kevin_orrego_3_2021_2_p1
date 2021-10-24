import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kevin_orrego_3_2021_2_p1/components/loader_component.dart';
import 'package:kevin_orrego_3_2021_2_p1/helpers/constants.dart';
import 'package:kevin_orrego_3_2021_2_p1/models/anime.dart';
import 'package:http/http.dart' as http;
import 'package:kevin_orrego_3_2021_2_p1/screens/single_anime.dart';

class AnimeList extends StatefulWidget {
  const AnimeList({Key? key}) : super(key: key);

  @override
  _AnimeListState createState() => _AnimeListState();
}

class _AnimeListState extends State<AnimeList> {
  final List<Anime> _animes = [];
  bool _showLoader = false;

  @override
  void initState() {
    super.initState();
    _getAnimes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: const Text('Lista de animes disponibles'),
      ),
      body: _showLoader
          ? LoaderComponent(text: 'Por favor espere...')
          : _getContent(),
    );
  }

  void _getAnimes() async {
    setState(() {
      _showLoader = true;
    });

    var url = Uri.parse(Constants.apiUrl);

    var response = await http.get(url, headers: {
      'content-type': 'application/json',
      'accept': 'application/json',
    });

    setState(() {
      _showLoader = false;
    });

    var body = response.body;
    var decodedJson = jsonDecode(body);

    if (decodedJson != null) {
      for (var item in decodedJson['data']) {
        _animes.add(Anime.fromJson(item));
      }
    }
  }

  Widget _getContent() {
    return _animes.isEmpty ? _noContent() : _getListView();
  }

  Widget _noContent() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(30),
        child: const Text('Actualmente no hay animes disponibles',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _getListView() {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 30),
      children: _animes.map((e) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SingleAnime(animeName: e.animeName)));
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.lightBlue),
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            margin:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              children: [
                Image.network(
                  e.animeImg,
                  width: 120,
                  height: 120,
                ),
                Flexible(
                  child: Text(
                    e.animeName.replaceAll("_", " "),
                    overflow: TextOverflow.fade,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

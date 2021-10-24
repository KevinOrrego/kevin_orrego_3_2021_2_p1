import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kevin_orrego_3_2021_2_p1/components/loader_component.dart';
import 'package:kevin_orrego_3_2021_2_p1/helpers/constants.dart';
import 'package:kevin_orrego_3_2021_2_p1/models/anime.dart';
import 'package:http/http.dart' as http;

class AnimeList extends StatefulWidget {
  const AnimeList({Key? key}) : super(key: key);

  @override
  _AnimeListState createState() => _AnimeListState();
}

class _AnimeListState extends State<AnimeList> {
  List<Anime> _animes = [];
  bool _showLoader = false;

  @override
  void initState() {
    super.initState();
    _getAnimes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

    var url = Uri.parse('${Constants.apiUrl}');

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

    print(_animes);
  }

  _getContent() {}
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kevin_orrego_3_2021_2_p1/components/loader_component.dart';
import 'package:kevin_orrego_3_2021_2_p1/helpers/constants.dart';
import 'package:kevin_orrego_3_2021_2_p1/models/single_anime_item.dart';
import 'package:http/http.dart' as http;

class SingleAnime extends StatefulWidget {
  final String animeName;

  const SingleAnime({Key? key, required this.animeName}) : super(key: key);

  @override
  _SingleAnimeState createState() => _SingleAnimeState();
}

class _SingleAnimeState extends State<SingleAnime> {
  late SingleAnimeItem _singleAnimeItem;
  bool _showLoader = false;

  @override
  void initState() {
    super.initState();
    _getSingleAnime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getName()),
      ),
      body: _showLoader
          ? LoaderComponent(text: 'Por favor espere...')
          : _getContent(),
    );
  }

  String _getName() {
    return widget.animeName.replaceAll("_", " ");
  }

  void _getSingleAnime() async {
    setState(() {
      _showLoader = true;
    });

    var url = Uri.parse('${Constants.apiUrl}/${widget.animeName}');

    var response = await http.get(url, headers: {
      'content-type': 'application/json',
      'accept': 'application/json',
    });

    setState(() {
      _showLoader = false;
    });

    var body = response.body;
    var decodedJson = jsonDecode(body);

    _singleAnimeItem = SingleAnimeItem.fromJson(decodedJson);
  }

  _getContent() {
    return _singleAnimeItem.success ? _getListView() : _noContent();
  }

  Widget _getListView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            _singleAnimeItem.img,
            // width: 120,
            // height: 120,
          ),
        ],
      ),
    );
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
}

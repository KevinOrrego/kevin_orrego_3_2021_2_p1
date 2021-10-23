import 'package:flutter/material.dart';
import 'package:kevin_orrego_3_2021_2_p1/screens/anime_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Anime list on pocket',
        home: AnimeList());
  }
}

import 'package:flutter/material.dart';
import 'package:kevin_orrego_3_2021_2_p1/anime_list_container.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Bienvenido al catalogo de animes"),
          ),
          body: const AnimeListContainer(),
        ));
  }
}

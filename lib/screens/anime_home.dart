import 'package:flutter/material.dart';

class AnimeHome extends StatefulWidget {
  const AnimeHome({Key? key}) : super(key: key);

  @override
  _AnimeHomeState createState() => _AnimeHomeState();
}

class _AnimeHomeState extends State<AnimeHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _showTitle(),
          _showLogo(),
          Container(
            padding: const EdgeInsets.all(30),
            child: FloatingActionButton.extended(
              onPressed: () {},
              label: const Text(
                "Ir a la lista",
                style: TextStyle(color: Colors.black, fontSize: 22),
              ),
              backgroundColor: Colors.amber,
            ),
          ),
        ],
      )),
    );
  }

  Widget _showLogo() {
    return const Image(
      image: AssetImage('assets/logo.png'),
      width: 300,
    );
  }

  Widget _showTitle() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: const Text(
        "Bienvenido a la lista de animes Zenitsu",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

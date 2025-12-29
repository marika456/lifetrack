import 'package:flutter/material.dart';

class TipsPage extends StatelessWidget {
  const TipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LifeTrack - Tips"),
      ),
      body: const Center(
        child: Text("Suggerimenti per l'utente!"),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:lifetrack/app_localizations.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    int ora= DateTime.now().hour;
    String chiave;

    if(ora < 12){
      chiave="welcome_morning";
    } else if (ora < 18) {
      chiave = "welcome_afternoon";
    } else {
      chiave = "welcome_evening";
    }

    return Scaffold(
      body: Center(
        child: Text(
          AppLocalizations.of(context)!.translate(chiave),
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
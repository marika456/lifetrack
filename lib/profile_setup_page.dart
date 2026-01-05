import 'package:flutter/material.dart';
import 'package:lifetrack/app_localizations.dart';
import 'constants.dart';

class ProfileSetupPage extends StatefulWidget {
  final String userGoal; //dentro questa variabile salverò l'obiettivo della schermata precedente
  const ProfileSetupPage({super.key, required this.userGoal});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.APP_NAME,
          style: TextStyle(
              color: Colors.black54,
              fontSize: 28,
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Text("Obiettivo scelto: ${widget.userGoal}"),
      ),
    );
  }
}

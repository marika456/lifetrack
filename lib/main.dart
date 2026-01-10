import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lifetrack/landing_page.dart';
import 'constants.dart';
import 'app_localizations.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'tips_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main() {
  runApp(
      const ProviderScope(
          child: MyApp()
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.APP_NAME,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('it', ''),
        Locale('en', ''),
      ],
      home: const LandingPage(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(Constants.APP_NAME),
            bottom: TabBar(
              labelColor: Colors.blueAccent,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.blueAccent,
                tabs: [
                  //in text chiamiamo il traduttore per mostrare il saluto nella lingua corretta
                  Tab(icon: const Icon(Icons.home), text: AppLocalizations.of(context)!.translate('home')),
                  Tab(icon: const Icon(Icons.lightbulb), text: AppLocalizations.of(context)!.translate('tips')),
                  Tab(icon: const Icon(Icons.person), text: AppLocalizations.of(context)!.translate('profile')),
                ],
            ),
          ),
          body: const TabBarView(
              children: [
                HomePage(),
                TipsPage(),
                ProfilePage(),
              ],
          ),
        ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'constants.dart';
import 'app_localizations.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'tips_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
      home: const MainScreen(),
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
                tabs: [
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


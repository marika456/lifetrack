import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lifetrack/UI/pages/landing_page.dart';
import 'constants.dart';
import 'localization/app_localizations.dart';
import 'UI/pages/home_page.dart';
import 'UI/pages/profile_page.dart';
import 'UI/pages/tips_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifetrack/model/user_provider.dart';


void main() {
  runApp(
      const ProviderScope(
          child: MyApp()
      ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final userProfile = ref.watch(userProvider);

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
      home: userProfile.weight == 0 ? const LandingPage() : const MainScreen(),
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
                  //in text chiamo il traduttore per mostrare il saluto nella lingua corretta
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


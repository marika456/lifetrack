import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifetrack/UI/pages/fitness_plan_page.dart';
import 'package:lifetrack/constants.dart';
import 'package:lifetrack/localization/app_localizations.dart';
import 'package:lifetrack/model/user_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            Constants.APP_NAME,
          style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.black54),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.account_circle, size: 80, color: Colors.blueAccent),
          const SizedBox(height: 40),

          Text(
            "${local.translate('weight_label')}: ${user.weight} kg",
            style: const TextStyle(fontSize: 20, color: Colors.blueAccent),
          ),
          const SizedBox(height: 10),

          Text(
            "${local.translate('height_label')}: ${user.height} cm",
            style: const TextStyle(fontSize: 20, color: Colors.blueAccent),
          ),
          const SizedBox(height: 10),

          Text(
            "${local.translate('age_label')}: ${user.age}",
            style: const TextStyle(fontSize: 20, color: Colors.blueAccent),
          ),
          const SizedBox(height: 40),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const FitnessPlanPage()),
              );
            },
          style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
            child: Text(AppLocalizations.of(context)!.translate('edit_profile'),
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),

            ),
        ),
        ],
      ),
    ),
    ),
    );
  }
}
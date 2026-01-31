import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifetrack/model/user_provider.dart';
import 'package:lifetrack/localization/app_localizations.dart';

class TipsPage extends ConsumerWidget {
  const TipsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final local = AppLocalizations.of(context)!;

    String tipTitle = local.translate('generic_tip_title');
    String tipMessage = local.translate('generic_tip_msg');
    IconData tipIcon = Icons.lightbulb;
    Color themeColor = Colors.orangeAccent;

    if (user.goal == 'gain_weight' && user.steps > 300) {
      tipTitle = local.translate('extra_snack_title');
      tipMessage = local.translate('extra_snack_msg');
      tipIcon = Icons.restaurant;
      themeColor = Colors.greenAccent;
    } else if (user.goal == 'lose_weight' && user.consumedCalories > (user.dailyCalories * 0.7)) {
      tipTitle = local.translate('walk_suggestion_title');
      tipMessage = local.translate('walk_suggestion_msg');
      tipIcon = Icons.directions_walk;
      themeColor = Colors.blueAccent;
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: themeColor.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(tipIcon, size: 60, color: themeColor),
                ),
                const SizedBox(height: 30),
                Text(
                  tipTitle,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Text(
                  tipMessage,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
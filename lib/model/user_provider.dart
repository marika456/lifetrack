import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'user_model.dart';
import 'db_manager.dart';

class UserNotifier extends StateNotifier<UserProfile> {
  UserNotifier() : super(UserProfile(
      weight: 0,
      height: 0,
      age: 0,
      gender: '',
      goal: 'maintain',
      dailyCalories: 2000,
      consumedCalories: 0,
      lastUpdate: ''
  )) {
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      final data = await DbManager.getUserProfile();
      final profile = UserProfile.fromMap(data);

      final oggi = DateTime.now().toIso8601String().split('T')[0];

      if (profile.lastUpdate != oggi) {
        state = profile.copyWith(consumedCalories: 0, lastUpdate: oggi);
        await DbManager.updateUserProfile(state.toMap());
      } else {
        state = profile;
      }
    } catch (e) {
      print("Errore nel caricamento del profilo: $e");
    }
  }

  void addCalories(int kcal) async {
    state = state.copyWith(consumedCalories: state.consumedCalories + kcal);
    await DbManager.updateUserProfile(state.toMap());
  }

  void updateSetup(UserProfile newProfile) async {
    state = newProfile;
    await DbManager.updateUserProfile(state.toMap());
  }

  void resetCalories() async {
    state = state.copyWith(consumedCalories: 0);
    await DbManager.updateUserProfile(state.toMap());
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserProfile>((ref) {
  return UserNotifier();
});
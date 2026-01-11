import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserState {
  final String goal;
  final double weight;
  final double height;
  final int age;
  final String gender;
  final int dailyCalories;
  final int consumedCalories;

  UserState({
    required this.goal,
    required this.weight,
    required this.height,
    required this.age,
    required this.gender,
    required this.dailyCalories,
    this.consumedCalories=0,
  });

  UserState copyWith({
    String? goal,
    double? weight,
    double? height,
    int? age,
    String? gender,
    int? dailyCalories,
    int? consumedCalories,
  }) {
    return UserState(
      goal: goal ?? this.goal,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      dailyCalories: dailyCalories ?? this.dailyCalories,
      consumedCalories: consumedCalories ?? this.consumedCalories,
    );
  }
}

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier() : super(UserState(goal: '', weight: 0, height: 0, age: 0, gender: '', dailyCalories: 0));

  void updateProfile(UserState newUserState) {
    state = newUserState;
  }

  //metodo che aggiunge le calorie a quelle già esistenti
  void addCalories(int kcal) {
    state = state.copyWith(consumedCalories: state.consumedCalories + kcal);
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier();
});
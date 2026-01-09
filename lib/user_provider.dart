import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserState {
  final String goal;
  final double weight;
  final double height;
  final int age;
  final String gender;
  final int dailyCalories;

  UserState({
    this.goal = '',
    this.weight = 0.0,
    this.height = 0.0,
    this.age = 0,
    this.gender = 'Male',
    this.dailyCalories = 0,
  });

  UserState copyWith({
    String? goal,
    double? weight,
    double? height,
    int? age,
    String? gender,
    int? dailyCalories,
  }) {
    return UserState(
      goal: goal ?? this.goal,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      dailyCalories: dailyCalories ?? this.dailyCalories,
    );
  }
}

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier() : super(UserState());

  void updateProfile(UserState newUserState) {
    state = newUserState;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier();
});
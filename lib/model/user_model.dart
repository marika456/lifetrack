class UserProfile {
  final double weight;
  final double height;
  final int age;
  final String gender;
  final String goal;
  final int dailyCalories;
  final int consumedCalories;
  final String lastUpdate;
  final int steps;

  UserProfile({
    required this.weight,
    required this.height,
    required this.age,
    required this.gender,
    required this.goal,
    required this.dailyCalories,
    this.consumedCalories = 0,
    required this.lastUpdate,
    this.steps=0
  });

  Map<String, dynamic> toMap() {
    return {
      'weight': weight,
      'height': height,
      'age': age,
      'gender': gender,
      'goal': goal,
      'dailyCalories': dailyCalories,
      'consumedCalories': consumedCalories,
      'lastUpdate': lastUpdate,
      'steps': steps,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      weight: map['weight'],
      height: map['height'],
      age: map['age'],
      gender: map['gender'],
      goal: map['goal'],
      dailyCalories: map['dailyCalories'],
      consumedCalories: map['consumedCalories'],
      lastUpdate: map['lastUpdate'],
      steps: map['steps']
    );
  }

  UserProfile copyWith({
    double? weight,
    double? height,
    int? age,
    String? gender,
    String? goal,
    int? dailyCalories,
    int? consumedCalories,
    String? lastUpdate,
    int? steps
  }) {
    return UserProfile(
      weight: weight ?? this.weight,
      height: height ?? this.height,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      goal: goal ?? this.goal,
      dailyCalories: dailyCalories ?? this.dailyCalories,
      consumedCalories: consumedCalories ?? this.consumedCalories,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      steps: steps ?? this.steps
    );
  }
}
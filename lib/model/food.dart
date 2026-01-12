class Food {
  final int? id;
  final String name;
  final int caloriePer100g;

  Food({
    this.id,
    required this.name,
    required this.caloriePer100g,
});

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      id: map['id'],
      name: map['name'],
      caloriePer100g: map['caloriePer100g'],
    ); //converto la mappa proveniente dal db in un oggetto food
  }
}
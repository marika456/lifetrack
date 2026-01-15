import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifetrack/localization/app_localizations.dart';
import 'package:lifetrack/model/user_provider.dart';
import '../../model/food.dart';
import 'package:lifetrack/model/db_manager.dart';

class FoodSearch extends ConsumerStatefulWidget {
  const FoodSearch({super.key});

  @override
  ConsumerState<FoodSearch> createState() => _FoodSearchState();
}

class _FoodSearchState extends ConsumerState<FoodSearch> {
  List<Food> _results = [];

  void _onSearchChanged(String query) async {
    if (query.isEmpty) {
      setState(() => _results = []);
      return;
    }

    final results = await DbManager.searchFoods(query);

    setState(() {
      _results = results;
    });
  }

  void _inserisciGrammi(BuildContext context, Food food){
    final TextEditingController _grammiController=TextEditingController();
    final local=AppLocalizations.of(context)!;

    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text(food.name),
            content: TextField(
              controller: _grammiController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: local.translate('enter_grams'),
                suffixText: "g",
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(local.translate('cancel')),
              ),
              ElevatedButton(
                  onPressed: () {
                    final double? grammi = double.tryParse(_grammiController.text);
                    if (grammi != null && grammi >0 ){
                      final int totalCalories = ((food.caloriePer100g*grammi) / 100).round();

                      ref.read(userProvider.notifier).addCalories(totalCalories);

                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(local.translate('add'))
              )
            ],
          );
        }
    );
  }//_inserisciGrammi

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              local.translate('search_database'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 15),
          TextField(
            onChanged: _onSearchChanged,
            decoration: InputDecoration(
              hintText: local.translate('search_food'),
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 10),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 300),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _results.length,
              itemBuilder: (context, index) {
                final food = _results[index];
                return ListTile(
                  title: Text(food.name),
                  subtitle: Text("${food.caloriePer100g} kcal/100g"),
                  trailing: const Icon(Icons.add_circle_outline),
                  onTap: () {
                    _inserisciGrammi(context, food);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifetrack/localization/app_localizations.dart';
import 'package:lifetrack/main.dart';
import 'package:lifetrack/model/user_model.dart';
import 'package:lifetrack/model/user_provider.dart';
import '../../constants.dart';

class ProfileSetupPage extends ConsumerStatefulWidget {
  final String userGoal; //dentro questa variabile salvo l'obiettivo della schermata precedente
  const ProfileSetupPage({super.key, required this.userGoal});

  @override
  ConsumerState<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends ConsumerState<ProfileSetupPage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  late AnimationController _controller;
  late Animation<double> _animation;

  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  String _selectedGender = 'Male';

  @override
  void initState(){
    super.initState();

    _controller=AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _animation=CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    _controller.forward();
  }

  @override
  void dispose(){
    _controller.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _saveAndCalculate(){

    if(!_formKey.currentState!.validate()){
      return;
    }
    //prendo i dati dai controller
    double weight=double.tryParse(_weightController.text)  ?? 0;
    double height = double.tryParse(_heightController.text) ?? 0;
    int age = int.tryParse(_ageController.text) ?? 0;

    //calcolo il BMR
    double bmr=(10*weight)+(6.25*height)-(5*age);
    bmr+=(_selectedGender=='Male') ? 5 : -161;

    //calcolo le calorie in base all'obiettivo
    int finalCalories;
    if (widget.userGoal=='lose_weight'){
      finalCalories=(bmr * 1.2 - 500).toInt();
    }else if (widget.userGoal=='gain_weight'){
      finalCalories=(bmr*1.2 + 500).toInt();
    }else{
      finalCalories=(bmr * 1.2).toInt();
    }

    final oggi = DateTime.now().toIso8601String().split('T')[0];

    //aggiorno lo stato globale con riverpod
    ref.read(userProvider.notifier).updateSetup(
      UserProfile(
        goal: widget.userGoal,
        weight: weight,
        height: height,
        age: age,
        gender: _selectedGender,
        dailyCalories: finalCalories,
        consumedCalories: ref.read(userProvider).consumedCalories,
        lastUpdate: oggi,
      ),
    );

    //infine la navigazione alla mainscreen
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const MainScreen()),
        (route) => false
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.APP_NAME,
          style: TextStyle(
              color: Colors.black54,
              fontSize: 28,
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${AppLocalizations.of(context)!.translate('setup_title')} ${AppLocalizations.of(context)!.translate(widget.userGoal)}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54
                ),
              ),
              const SizedBox(height: 40),
              ScaleTransition(
                  scale: _animation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //TEXTFIELD PESO
                    TextFormField(
                      controller: _weightController,
                      keyboardType: TextInputType.number, //per aprire la tastiera numerica
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.translate('weight_label'),
                        prefixIcon: const Icon(Icons.scale),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
                      ),
                      validator: (value){
                        if(value==null || value.isEmpty) {
                          return AppLocalizations.of(context)!.translate('required_field');
                        }
                        final n=double.tryParse(value);
                        if (n==null || n < 30 || n > 200 )
                          return AppLocalizations.of(context)!.translate('invalid_field');
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),

                    //TEXTFIELD ALTEZZA
                    TextFormField(
                      controller: _heightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.translate('height_label'),
                        prefixIcon: const Icon(Icons.height),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
                      ),
                      validator: (value){
                        if(value==null || value.isEmpty) {
                          return AppLocalizations.of(context)!.translate('required_field');
                        }
                        final n=double.tryParse(value);
                        if (n==null || n < 100 || n > 250 )
                          return AppLocalizations.of(context)!.translate('invalid_field');
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),

                    //TEXTFIELD ETA'
                    TextFormField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.translate('age_label'),
                          prefixIcon: const Icon(Icons.cake_outlined),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
                      ),
                      validator: (value){
                        if(value==null || value.isEmpty) {
                          return AppLocalizations.of(context)!.translate('required_field');
                        }
                        final n=double.tryParse(value);
                        if (n==null || n < 5 || n > 80 )
                          return AppLocalizations.of(context)!.translate('invalid_field');
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),

                    //MENU A TENDINA
                    DropdownButtonFormField<String>(
                      initialValue: _selectedGender,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.translate('gender_label'),
                          prefixIcon: const Icon(Icons.person_2_outlined),
                          border:OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'Male',
                              child: Text(AppLocalizations.of(context)!.translate('male'))
                          ),
                          DropdownMenuItem(
                            value: 'Female',
                              child: Text(AppLocalizations.of(context)!.translate('female'))
                          ),
                        ],
                        onChanged: (String? newValue){
                        setState(() {
                          _selectedGender=newValue!;
                        });
                        }
                    ),
                    const SizedBox(height: 40),

                    //TASTO CALCOLA CALORIE
                    ElevatedButton(
                        onPressed: _saveAndCalculate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.translate('calculate_button'),
                        style: const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
       ),
    )
    );
  }
}

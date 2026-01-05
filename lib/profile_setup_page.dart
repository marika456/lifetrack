import 'package:flutter/material.dart';
import 'package:lifetrack/app_localizations.dart';
import 'constants.dart';

class ProfileSetupPage extends StatefulWidget {
  final String userGoal; //dentro questa variabile salverò l'obiettivo della schermata precedente
  const ProfileSetupPage({super.key, required this.userGoal});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> with SingleTickerProviderStateMixin {
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
                    ),
                    const SizedBox(height: 40),

                    //TEXTFIELD ETA'
                    TextFormField(
                      controller: _heightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.translate('age_label'),
                          prefixIcon: const Icon(Icons.cake_outlined),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
                      ),
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
                  ],
                ),
              ),
            ],
          ),
        ),
       ),
    );
  }
}

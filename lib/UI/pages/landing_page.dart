import 'package:flutter/material.dart';
import '../../localization/app_localizations.dart';
import '../../constants.dart';
import '../../main.dart';
import 'fitness_plan_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

// Uso il mixin per le animazioni
class _LandingPageState extends State<LandingPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;


  @override
  void initState() {
    super.initState();
    // Inizializzo il controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward(); // Avvia l'animazione all'apertura
  }

  @override
  void dispose() {
    _controller.dispose(); // Libera la memoria
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // BARRA SUPERIORE
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF0077B6),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade200,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.coffee, color: Colors.white, size: 30),
                  Icon(Icons.restaurant, color: Colors.white, size: 30),
                  Icon(Icons.directions_run, color: Colors.white, size: 30),
                  Icon(Icons.fitness_center, color: Colors.white, size: 30),
                  Icon(Icons.bakery_dining, color: Colors.white, size: 30),
                  Icon(Icons.local_pizza, color: Colors.white, size: 30),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),

          // IL TESTO DI BENVENUTO
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 20),
            child: FadeTransition(
              opacity: _animation, //Uso l'animazione definita in initState
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.translate('welcome_to').toUpperCase(),
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 2.0, //Aumento lo spazio tra le lettere
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    Constants.APP_NAME,
                    style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0077B6),
                      letterSpacing: -1.0, // Effetto lettere vicine
                    ),
                  ),
                ],
              ),
            ),
          ),

          //CAROUSEL VIEW
          SizedBox(
            height: 400, // Altezza
            child: CarouselView(
              itemExtent: MediaQuery.of(context).size.width * 0.8, // Ogni foto occupa l'80% della larghezza
              shrinkExtent: 200,
              children: [
                Image.asset('assets/images/img_tre.jpg', fit: BoxFit.cover),
                Image.asset('assets/images/img_due.jpg', fit: BoxFit.cover),
                Image.asset('assets/images/img_uno.jpg', fit: BoxFit.cover),
              ],
            ),
          ),

          const Spacer(), //Spinge il bottone verso il basso

          //BOTTONE INIZIAMO
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0077B6),
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                shape: const StadiumBorder(),
              ),
              onPressed: () {
                // Passaggio alla MainScreen con Modalità Replace
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const FitnessPlanPage()),
                      (route) => false,
                );
              },
              child: Text(
                AppLocalizations.of(context)!.translate('start_button'),
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


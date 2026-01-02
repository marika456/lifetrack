import 'package:flutter/material.dart';
import 'package:lifetrack/app_localizations.dart';
import 'constants.dart';



class FitnessPlanPage extends StatefulWidget {
  const FitnessPlanPage({super.key});

  @override
  State<FitnessPlanPage> createState() => _FitnessPlanPageState();
}

class _FitnessPlanPageState extends State<FitnessPlanPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

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
      body: Padding(
        padding: EdgeInsets.all(20),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text(
              AppLocalizations.of(context)!.translate('fitness_goal_title'),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            const SizedBox(height: 100),

            ScaleTransition(
              scale: _animation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //BOTTONE 1
                  ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      elevation: 6, //intensità ombra
                      padding: const EdgeInsets.symmetric(vertical: 18), // Altezza del bottone
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // Bordi arrotondati
                      ),
                    ),
                    child: Text(AppLocalizations.of(context)!.translate('lose_weight'),
                        style: TextStyle(fontSize: 22, color: Colors.white)
                    ),
                  ),
                  const SizedBox(height: 40),

                  //BOTTONE 2
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      elevation: 6,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(AppLocalizations.of(context)!.translate('maintain_weight'),
                        style: TextStyle(fontSize: 22, color: Colors.white)),
                  ),
                  const SizedBox(height: 40),

                  // Bottone 3
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      elevation: 6,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(AppLocalizations.of(context)!.translate('gain_weight'),
                        style: TextStyle(fontSize: 22, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

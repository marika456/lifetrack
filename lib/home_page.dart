import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifetrack/app_localizations.dart';
import 'package:lifetrack/user_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState(){
    super.initState();

    _animationController=AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _animation=CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubic,
    );

    _animationController.forward();
  }

  @override
  void dispose(){
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userState=ref.watch(userProvider);

    int ora=DateTime.now().hour;
    String chiave;

    if (ora<12){
      chiave="welcome_morning";
    }else if(ora<18){
      chiave="welcome_afternoon";
    }else{
      chiave="welcome_evening";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.translate(chiave),
          style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.black54),
        ),
        centerTitle: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                //CERCHIO PER LE CALORIE
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: CircularProgressIndicator(
                        value: _animation.value,
                        strokeWidth: 12,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.blueAccent),
                        backgroundColor: Colors.black26,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("${userState.dailyCalories}", style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                        Text("kcal", style: TextStyle(fontSize: 14))
                      ],
                    ),
                  ],
                );
              },
          ),
        const SizedBox(height: 30),

        // IL BOTTONE SOTTO IL CERCHIO
        ElevatedButton(
          onPressed: () {
            // qui devo aggiungere la ricerca del cibo
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(15),
            backgroundColor: Colors.blueAccent,
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
        ],
        ),
      ),
    );
  }
}

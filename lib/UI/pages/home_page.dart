import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifetrack/UI/widgets/food_search.dart';
import 'package:lifetrack/localization/app_localizations.dart';
import 'package:lifetrack/model/user_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubic,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = ref.watch(userProvider);
    final l10n = AppLocalizations.of(context)!;

    double percentuale = 0.0;
    if (userProfile.dailyCalories > 0) {
      percentuale = (userProfile.consumedCalories / userProfile.dailyCalories).clamp(0.0, 1.0);
    }

    int ora = DateTime.now().hour;
    String chiaveSaluto;
    if (ora < 12) {
      chiaveSaluto = "welcome_morning";
    } else if (ora < 18) {
      chiaveSaluto = "welcome_afternoon";
    } else {
      chiaveSaluto = "welcome_evening";
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          l10n.translate(chiaveSaluto),
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black54),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Bottone Reset
                IconButton(
                  onPressed: () => ref.read(userProvider.notifier).resetCalories(),
                  icon: const Icon(Icons.refresh, color: Colors.blueAccent, size: 30),
                  tooltip: "Reset",
                ),

                const SizedBox(height: 20),
                //CERCHIO
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 240,
                          height: 240,
                          child: CircularProgressIndicator(
                            value: _animation.value * percentuale,
                            strokeWidth: 16,
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                            backgroundColor: Colors.black12,
                            strokeCap: StrokeCap.round,
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${userProfile.consumedCalories}",
                              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "/ ${userProfile.dailyCalories} kcal",
                              style: const TextStyle(fontSize: 18, color: Colors.black54),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.directions_walk, size: 30, color: Colors.orangeAccent),
                                const SizedBox(width: 4),
                                Text(
                                  "${userProfile.steps}",
                                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 50),

                //BOTTONE AGGIUNGI
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                      ),
                      builder: (context) => Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: const FoodSearch(),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(24),
                    backgroundColor: Colors.blueAccent,
                    elevation: 8,
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 40),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

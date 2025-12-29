import 'package:flutter/material.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'tips_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.lightBlueAccent),
      ),
      home: const MainScreen(),
    );
  }
}
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex=0; //quale pagina è selezionata(0,1,2)
  final List<Widget> _pages=[
    const HomePage(),
    const ProfilePage(),
    const TipsPage(),
  ];//lista delle pagine da mostrare
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //mostra la pagina corrente presa dalla lista
      body: _pages[_currentIndex],
      //barra di navigazione in basso
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,//dice alla barra quale icona illuminare
        onTap: (index){
          //questa funzione scatta quando tocco l'icona
          setState(() {
            _currentIndex=index; //aggiorna indice e ridisegna app
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profilo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Tips',
          ),
        ],
      ),
    );
  }
}

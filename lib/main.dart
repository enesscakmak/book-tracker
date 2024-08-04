// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:reader_tracker/pages/books_details.dart';
import 'package:reader_tracker/pages/favorites_screen.dart';
import 'package:reader_tracker/pages/home_screen.dart';
import 'package:reader_tracker/pages/saved_screen.dart';

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
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 45, 181, 158)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/home': ((context) => HomeScreen()),
        '/saved': ((context) => SavedScreen()),
        '/favorites': ((context) => FavoritesScreen()),
        '/details': ((context) => BookDetailsScreen()),
      },
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SavedScreen(),
    const FavoritesScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 16, 60, 93),
        title: Text(''),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Color.fromARGB(255, 16, 60, 93),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.save), label: "Saved"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favorites")
        ],
        selectedItemColor: Color.fromARGB(255, 222, 222, 33),
        unselectedItemColor: Colors.white,
        onTap: (value) {
          print("Tapped $value");
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'home_screen.dart';

// the main function is the starting point for all fluuter apps
// matrialapp(home:center(child:text))
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    
    );
  
  }

 

}

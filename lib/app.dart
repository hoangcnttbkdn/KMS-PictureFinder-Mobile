import 'package:flutter/material.dart';
import 'package:pictures_finder/ui/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PictureFinder',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

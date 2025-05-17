import 'package:country_app/CountryListScreen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(CountryApp());
}

class CountryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'World Countries',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CountryListScreen(),
    );
  }
}


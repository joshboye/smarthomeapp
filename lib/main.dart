import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthomeapp/provider/temp_provider.dart';
import 'package:smarthomeapp/view/screens/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TempProvider())
      ],
      child: MaterialApp(
        title: 'smart home app',
        home: HomeScreen(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Fixed the import statement

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure proper initialization
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hive',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(), // Corrected class name
    );
  }
}

class MyHomePage extends StatelessWidget {
  // Extended StatelessWidget
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive Example'),
      ),
      body: Center(
        child: Text('Hello, Hive!'),
      ),
    );
  }
}

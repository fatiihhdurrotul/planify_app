import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider package
import 'task_provider.dart'; // Import task_provider.dart
// Import dashboard.dart
import 'login.dart'; // Import login.dart

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(), // Ubah ini ke LoginPage
    );
  }
}

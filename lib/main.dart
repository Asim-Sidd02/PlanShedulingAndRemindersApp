import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plan_sheduling_and_reminders/HomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, Key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      key: UniqueKey(),
      title: 'Plan Scheduling And Reminders',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false, // remove the debug banner
      home: const HomeScreen(),
    );
  }
}

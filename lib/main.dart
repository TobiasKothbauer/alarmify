import 'dart:async';
import 'package:alarmify/views/edit_alarm.dart';
import 'package:alarmify/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:alarm/alarm.dart';
import 'package:flutter/services.dart';
import 'package:alarmify/constants/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Alarm.init(showDebugLogs: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alarmify',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ClockHome(),
      routes: {
        newAlarmRoute: (context) => const ExampleAlarmEditScreen(),
      },
    );
  }
}

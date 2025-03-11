import 'package:flutter/material.dart';
import 'package:w5_observer_pattern_and_state_management/Excerise-2/providers/model_counter.dart';
import 'package:w5_observer_pattern_and_state_management/Excerise-2/screens/step_3.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ColorCounters()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: Home()),
      ),
    ),
  );
}
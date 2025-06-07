import 'package:flutter/material.dart';
import 'package:roll_dice_2d/roll_dice_2d.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: RollDice2D(
            rollingTimes: 3000, // Number of times to roll the dice
            color: DiceColor.red,
            onRoll: (value) {
              debugPrint('Rolled value: $value');
            },
          ),
        ),
      ),
    );
  }
}

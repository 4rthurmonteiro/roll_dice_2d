import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum DiceColor { red, white }

class RollDice2D extends StatefulWidget {
  const RollDice2D({
    super.key,
    this.color = DiceColor.red,
    this.rollingTimes = 1,
    required this.onRoll,
    this.speed = 200, // Default speed for rolling animation
  });
  final DiceColor color;
  final int rollingTimes;
  final void Function(int value) onRoll;
  final int speed; // Speed of the rolling animation in milliseconds

  @override
  State<RollDice2D> createState() => _RollDice2DState();
}

class _RollDice2DState extends State<RollDice2D> {
  late int initialValue;
  late final Random random;

  @override
  void initState() {
    super.initState();
    random = Random(0xFFFFFF);
    initialValue =
        random.nextInt(6) + 1; // Random initial value between 1 and 6

    if (widget.rollingTimes > 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        for (int i = 0; i < widget.rollingTimes; i++) {
          await Future.delayed(Duration(milliseconds: widget.speed), rollDice);
        }
        widget.onRoll(initialValue);
      });
    } else {
      widget.onRoll(initialValue);
    }
  }

  void rollDice() {
    setState(() {
      initialValue = random.nextInt(6) + 1; // Random value between 1 and 6
    });
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/dice_${widget.color.name}_$initialValue.png',
      width: 100,
      height: 100,
      fit: BoxFit.cover,

      package: 'roll_dice_2d',
    );
  }
}

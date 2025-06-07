<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# roll_dice_2d

A Flutter widget that displays an animated 2D dice. It allows customization of dice color, rolling animation, and provides a callback with the final dice value.

## Features

*   Displays a 2D dice.
*   Customizable dice color: `DiceColor.red` (default) or `DiceColor.white`.
*   Animates dice rolling by changing faces.
*   Configurable number of animated rolls (`rollingTimes`) and animation speed (`speed`).
*   `onRoll` callback: Provides the final dice value (1-6) after rolling animation completes.
*   Bundled dice images: Includes assets for red and white dice faces from 1 to 6.
*   Deterministic roll sequence: Due to a fixed seed for the random number generator, the sequence of dice rolls is the same each time the widget is initialized or re-keyed. This can be useful for testing or specific scenarios requiring predictable outcomes.

*(Consider adding a GIF here showing the dice roll animation!)*

## Getting started

1.  Add `roll_dice_2d` to your `pubspec.yaml` dependencies:

    ```yaml
    dependencies:
      flutter:
        sdk: flutter
      roll_dice_2d: ^1.0.0 # Replace with the latest version
    ```

2.  Run `flutter pub get` to install the package.

3.  Import the package in your Dart file:

    ```dart
    import 'package:roll_dice_2d/roll_dice_2d.dart';
    ```

The package includes the necessary dice images (e.g., `assets/images/dice_red_1.png`). No additional asset setup is required in your project's `pubspec.yaml` for these images.

## Usage

Here's a basic example of how to use the `RollDice2D` widget:

```dart
import 'package:flutter/material.dart';
import 'package:roll_dice_2d/roll_dice_2d.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RollDice2D Demo',
      home: DiceDemoPage(),
    );
  }
}

class DiceDemoPage extends StatefulWidget {
  const DiceDemoPage({super.key});

  @override
  State<DiceDemoPage> createState() => _DiceDemoPageState();
}

class _DiceDemoPageState extends State<DiceDemoPage> {
  int _currentDiceValue = 1; // To store the dice value
  Key _diceKey = UniqueKey(); // To re-trigger the roll animation

  void _rollTheDice() {
    // To re-trigger the animation and onRoll, we change the key of RollDice2D.
    // This causes the widget to be rebuilt and its initState (including the roll) to run again.
    setState(() {
      _diceKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RollDice2D Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RollDice2D(
              key: _diceKey, // Assign the key here
              onRoll: (int value) {
                // This callback is triggered after the rolling animation completes (if any).
                // It provides the final value of the dice.
                setState(() {
                  _currentDiceValue = value;
                });
                print('Dice rolled, final value: $value');
              },
              color: DiceColor.red,     // Or DiceColor.white
              rollingTimes: 5,          // Number of times the dice face changes during animation
                                        // If 1 or less, shows initial face and calls onRoll immediately.
              speed: 150,               // Duration in milliseconds for each face change animation
            ),
            const SizedBox(height: 20),
            Text(
              'Dice Value: $_currentDiceValue',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _rollTheDice,
              child: const Text('Roll Again'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Widget Parameters

*   `key` (optional): A `Key` to uniquely identify the widget. Changing the key will cause the widget to re-initialize and re-run the rolling animation.
*   `color`: `DiceColor` (enum: `DiceColor.red`, `DiceColor.white`). Default is `DiceColor.red`. Sets the color of the dice.
*   `rollingTimes`: `int`. Default is `1`. The number of times the dice face will change during the rolling animation. If set to `1` or less, an initial dice face is shown, and `onRoll` is called immediately without an animation loop.
*   `onRoll`: `required void Function(int value)`. A callback function that is invoked after the dice has finished its rolling sequence. It provides the final integer value (1-6) of the dice.
*   `speed`: `int`. Default is `200`. The duration in milliseconds for each individual face change during the animation. A lower value means a faster animation.

The dice images are displayed with a fixed size of `100x100` pixels and `BoxFit.cover`.

## Additional information

*   **Reporting Issues**: If you encounter any bugs or have suggestions, please file an issue on the package's GitHub repository (replace with actual link).
*   **Contributing**: Contributions are welcome! Please refer to the repository for guidelines.
*   **Deterministic Rolls**: The dice rolling mechanism uses a fixed seed for its random number generator. This means that each time the `RollDice2D` widget is initialized (e.g., on first load or when its `key` changes), it will produce the exact same sequence of dice values if `rollingTimes` is greater than 0. If `rollingTimes` is 1 or less, it will always show the same initial dice face. This is important to understand if you expect different random outcomes on each "roll again" action without changing other factors.

---


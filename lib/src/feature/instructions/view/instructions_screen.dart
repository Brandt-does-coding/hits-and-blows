import 'package:flutter/material.dart';
import 'package:hits_and_blows_game/src/global/themes/theme.dart';

class InstructionsScreen extends StatelessWidget {
  const InstructionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      bottom: false,
      child: Container(
        height: height * 0.75,
        padding: const EdgeInsets.all(20.0),
        color: AppTheme.darkBackgroundColor,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.blueGrey[700],
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 20.0,
              children: [
                Text('🎯 Hits & Blows', style: AppTheme.mainTitleStyle),
                SizedBox(height: 20),
                Text(
                  '🔹 The game generates a secret 4-digit number with unique digits.',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  '🔹 You guess the number using the input boxes.',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  '🔥 A "Hit" means a correct digit in the correct position.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.lightGreenAccent,
                  ),
                ),
                Text(
                  '💥 A "Blow" means a correct digit in the wrong position.',
                  style: TextStyle(fontSize: 18, color: Colors.orangeAccent),
                ),
                Text(
                  '🧠 Keep guessing until you get all 4 digits in the right place!',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hits_and_blows_game/src/global/themes/theme.dart';

class InstructionsScreen extends StatelessWidget {
  const InstructionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text('How to Play'),
        backgroundColor: Colors.blueGrey[950],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
            children: [
              Text('🎯 Hits & Blows', style: AppTheme.mainTitleStyle),
              SizedBox(height: 20),
              Text(
                '🔹 The game generates a secret 4-digit number with unique digits.',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                '🔹 You guess the number using the input boxes.',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                '🔥 A "Hit" means a correct digit in the correct position.',
                style: TextStyle(fontSize: 18, color: Colors.lightGreenAccent),
              ),
              SizedBox(height: 10),
              Text(
                '💥 A "Blow" means a correct digit in the wrong position.',
                style: TextStyle(fontSize: 18, color: Colors.orangeAccent),
              ),
              SizedBox(height: 10),
              Text(
                '🧠 Keep guessing until you get all 4 digits in the right place!',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              const Spacer(),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () => context.pop(),
                  icon: Icon(Icons.arrow_back),
                  label: Text('Back to Game'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey[900],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

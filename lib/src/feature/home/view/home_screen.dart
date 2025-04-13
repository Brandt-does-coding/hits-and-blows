import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hits_and_blows_game/src/constants/button_styles.dart';
import 'package:hits_and_blows_game/src/constants/logo.dart';
import 'package:hits_and_blows_game/src/feature/instructions/view/instructions_screen.dart';
import 'package:hits_and_blows_game/src/global/themes/theme.dart';
import 'package:hits_and_blows_game/src/global/widgets/buttons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackgroundColor,
      appBar: AppBar(title: kAppLogo, backgroundColor: Colors.transparent),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            spacing: 24.0,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Hits & Blows", style: AppTheme.mainTitleStyle),
              SizedBox(height: 40.0),
              AnimatedButton(
                onPressed: () {
                  context.push('/mode-select');
                },
                text: 'Play',
                style: MainStyle(),
              ),
              TextButton(
                onPressed: () {
                  showModalBottomSheet(
                    useRootNavigator: true,
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (context) => const InstructionsScreen(),
                  );
                },
                child: Text(
                  'Instructions',
                  style: TextStyle(fontSize: 18, color: Colors.white70),
                ),
              ),
              SizedBox(height: 80.0),
            ],
          ),
        ),
      ),
    );
  }
}

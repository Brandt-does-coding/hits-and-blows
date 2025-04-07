import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hits_and_blows_game/src/constants/button_styles.dart';
import 'package:hits_and_blows_game/src/global/themes/theme.dart';
import 'package:hits_and_blows_game/src/global/widgets/buttons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
      lowerBound: 0.9,
      upperBound: 1.0,
    )..repeat(reverse: true);

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'logo',
              child: Material(
                type: MaterialType.transparency,
                child: DefaultTextStyle(
                  style: AppTheme.mainTitleStyle.copyWith(fontSize: 36),
                  child: Text('Hits & Blows'),
                ),
              ),
            ),
            SizedBox(height: 40),
            ScaleTransition(
              scale: _scaleAnimation,
              child: Consumer(
                builder: (context, ref, child) {
                  return AnimatedButton(
                    onPressed: () {
                      context.push('/mode-select');
                    },
                    text: 'Play',
                    style: MainStyle(),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () => context.push('/instructions'),
              child: Text(
                'Instructions',
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
            ),
            SizedBox(height: 50),
            OutlinedButton(
              onPressed: () => context.push('/history'),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.white70),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text(
                'History',
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

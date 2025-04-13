import 'package:flutter/material.dart';
import 'package:hits_and_blows_game/src/feature/game/widgets/Feedback/hits_and_blows_counter.dart';

class FadingPopupOverlay extends StatefulWidget {
  final int hits;
  final int blows;
  final double opacity;

  const FadingPopupOverlay({
    super.key,
    required this.hits,
    required this.blows,
    required this.opacity,
  });

  @override
  State<FadingPopupOverlay> createState() => _FadingPopupOverlayState();
}

class _FadingPopupOverlayState extends State<FadingPopupOverlay> {
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();
    _opacity = widget.opacity;
  }

  @override
  void didUpdateWidget(covariant FadingPopupOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.opacity != oldWidget.opacity) {
      setState(() {
        _opacity = widget.opacity;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: AnimatedOpacity(
            opacity: _opacity,
            duration: Duration(milliseconds: 400),
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: SizedBox(
                  width: 200,
                  child: HitsAndBlowsCounter(
                    hitsText: '${widget.hits} Hits',
                    blowsText: '${widget.blows} Blows',
                    iconSize: 35.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

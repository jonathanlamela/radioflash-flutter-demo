import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class OnAirAnimation extends HookWidget {
  OnAirAnimation({Key? key}) : super(key: key);

  final Animatable<Color?> background = TweenSequence<Color?>(
    [
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.white,
          end: Colors.red,
        ),
      ),
    ],
  );

  final Duration duration = const Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    final _controller = useAnimationController(
      duration: duration,
    );

    _controller.repeat(period: duration);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Align(
          alignment: Alignment.topRight,
          child: Container(
            color: Colors.redAccent[700],
            width: 100,
            margin: EdgeInsets.only(
              right: 10,
              top: 10,
            ),
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.settings_input_antenna,
                  color: background.evaluate(
                    AlwaysStoppedAnimation(
                      _controller.value,
                    ),
                  ),
                  size: 24,
                ),
                Text(
                  "ON AIR",
                  style: TextStyle(
                    fontSize: 12,
                    color: background.evaluate(
                      AlwaysStoppedAnimation(_controller.value),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

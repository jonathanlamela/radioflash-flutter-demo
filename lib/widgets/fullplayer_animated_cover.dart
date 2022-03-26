import 'package:flutter/material.dart';

class FullPlayerAnimatedCover extends StatefulWidget {
  final Image? image;
  final bool? isPlaying;
  FullPlayerAnimatedCover({this.image, this.isPlaying = false});
  @override
  State<StatefulWidget> createState() {
    return FullPlayerAnimatedCoverState();
  }
}

class FullPlayerAnimatedCoverState extends State<FullPlayerAnimatedCover>
    with SingleTickerProviderStateMixin {
  double boxWidth = 300;
  double boxHeight = 300;

  late AnimationController _animationController;
  late Animation<int> animation;
  Widget? child;

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);
    animation = Tween(end: 25, begin: 5).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isPlaying!) {
      return Center(
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Container(
              width: boxWidth,
              height: boxHeight,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.4),
                    spreadRadius: 5,
                    blurRadius: _animationController.value * 100,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: widget.image,
            );
          },
        ),
      );
    } else {
      return Center(
        child: Container(
          width: boxWidth,
          height: boxHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: widget.image,
        ),
      );
    }
  }
}

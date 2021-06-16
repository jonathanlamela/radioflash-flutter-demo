import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:radioflash/services/PlayerProvider.dart';
import 'package:radioflash/widgets/LoadingProgress.dart';
import '../../ThemeConfig.dart';

class FullPagePlayer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FullPagePlayerState();
  }
}

class FullPagePlayerState extends State<FullPagePlayer> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: context.statusBarColor()));

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.grey,
            context.gradiendEndColor(),
          ],
        ),
      ),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        child: Scaffold(
          backgroundColor: context.scaffoldBackgroundColor(),
          body: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Consumer<PlayerProvider>(
                            builder: (context, value, child) {
                              Widget child = LoadingProgress();
                              if (value.currentList.isNotEmpty) {
                                child = Container(
                                  key: UniqueKey(),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: SizedBox(
                                          width: 300,
                                          height: 300,
                                          child: FullPageAnimatedCover(
                                              isPlaying: value.isPlaying,
                                              image: value
                                                  .currentList.first.cover),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 24),
                                        height: 200,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                value.currentList.first.title,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                value.currentList.first.artist,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }

                              return AnimatedSwitcher(
                                child: child,
                                duration: Duration(milliseconds: 700),
                              );
                            },
                          ),
                          Container(
                            height: 100,
                            child: FullPlayerPlayButton(),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          appBar: PreferredSize(
            child: AppBar(
                brightness: Brightness.dark,
                elevation: 0,
                backgroundColor: context.statusBarColor()),
            preferredSize: Size.fromHeight(0),
          ),
        ),
      ),
    );
  }
}

class FullPageAnimatedCover extends StatefulWidget {
  final Image? image;
  final bool? isPlaying;
  FullPageAnimatedCover({this.image, this.isPlaying = false});
  @override
  State<StatefulWidget> createState() {
    return FullPlayerAnimatedCoverState();
  }
}

class FullPlayerAnimatedCoverState extends State<FullPageAnimatedCover>
    with SingleTickerProviderStateMixin {
  double boxWidth = 300;
  double boxHeight = 300;

  late AnimationController _animationController;
  late Animation<int> animation;
  Widget? child;

  @override
  void dispose() {
    _animationController.dispose();
    print("Dispose");
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    print("Init state");

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
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                spreadRadius: 15,
                blurRadius: 5,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
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

class FullPlayerPlayButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FullPlayerPlayButtonState();
  }
}

class FullPlayerPlayButtonState extends State<FullPlayerPlayButton> {
  var isPlaying = false;
  @override
  Widget build(BuildContext context) {
    isPlaying = Provider.of<PlayerProvider>(context, listen: true).isPlaying;
    var content = Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            minRadius: 40,
            backgroundColor: context.playPauseButtonColor(),
            child: IconButton(
                icon: (isPlaying != true
                    ? Icon(
                        Icons.play_arrow_rounded,
                      )
                    : Icon(
                        Icons.pause,
                      )),
                color: context.playPauseButtonIconColor(),
                onPressed: () {
                  if (isPlaying) {
                    Provider.of<PlayerProvider>(context, listen: false).stop();
                  } else {
                    Provider.of<PlayerProvider>(context, listen: false).play();
                  }
                }),
          )
        ],
      ),
    );

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Flexible(child: content)]))
        ]);
  }
}

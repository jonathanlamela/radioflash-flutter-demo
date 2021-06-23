import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:radioflash/services/PlayerProvider.dart';
import 'package:radioflash/widgets/LoadingProgress.dart';

import '../../ThemeConfig.dart';
import 'FullPageAnimatedCover.dart';
import 'FullPlayerPlayButton.dart';

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
        child: SafeArea(
          child: Scaffold(
            backgroundColor: context.scaffoldBackgroundColor(),
            body: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    child: Row(
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
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 6,
                            child: Consumer<PlayerProvider>(
                              builder: (context, value, child) {
                                Widget child = LoadingProgress();
                                if (value.currentList.isNotEmpty) {
                                  child = Container(
                                    width: double.infinity,
                                    key: UniqueKey(),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Flexible(
                                          flex: 4,
                                          child: Container(
                                            padding: EdgeInsets.only(left: 10),
                                            child: SizedBox(
                                              child: FullPageAnimatedCover(
                                                  isPlaying: value.isPlaying,
                                                  image: value
                                                      .currentList.first.cover),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 2,
                                          child: Container(
                                            padding: EdgeInsets.only(top: 24),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    value.currentList.first
                                                        .title,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    value.currentList.first
                                                        .artist,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
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
                          ),
                          Flexible(
                            flex: 2,
                            child: Container(
                              child: FullPlayerPlayButton(),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
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
      ),
    );
  }
}

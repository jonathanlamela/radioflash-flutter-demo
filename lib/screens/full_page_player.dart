import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radioflash/provider.dart';
import 'package:radioflash/widgets/loading_progress.dart';

import '../ThemeConfig.dart';
import 'full_page_player/FullPageAnimatedCover.dart';
import 'full_page_player/FullPlayerPlayButton.dart';

class FullPagePlayer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: context.statusBarColor()));

    var playerStatus = ref.watch(playerStatusProvider);

    Widget child = LoadingProgress();

    if (playerStatus.currentList.isNotEmpty) {
      child = Container(
        width: double.infinity,
        key: UniqueKey(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              flex: 4,
              child: Container(
                padding: EdgeInsets.only(left: 10),
                child: SizedBox(
                  child: FullPageAnimatedCover(
                      isPlaying: playerStatus.isPlaying,
                      image: playerStatus.currentList.first.cover),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(top: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        playerStatus.currentList.first.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        playerStatus.currentList.first.artist,
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
            ),
          ],
        ),
      );
    }

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
                            child: AnimatedSwitcher(
                              child: child,
                              duration: Duration(milliseconds: 700),
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
                  systemOverlayStyle: SystemUiOverlayStyle.dark,
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

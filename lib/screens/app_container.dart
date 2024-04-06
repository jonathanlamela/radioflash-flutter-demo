import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radioflash/ThemeConfig.dart';
import 'package:radioflash/provider.dart';
import 'package:radioflash/screens/no_internet.dart';
import 'package:radioflash/screens/notizie.dart';
import 'package:radioflash/screens/home.dart';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:radioflash/widgets/radio_bottom_player_widget.dart';

import '../widgets/radio_top_bar.dart';

class AppContainer extends ConsumerWidget {
  final pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationProvider);

    var navItems = [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.article),
        label: "Notizie",
      ),
    ];

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: context.statusBarColor()));

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            context.gradientStartColor(),
            context.gradiendEndColor(),
          ],
        ),
      ),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        child: Scaffold(
            backgroundColor: context.scaffoldBackgroundColor(),
            body: FutureBuilder(
              builder: (context, snapshot) {
                Widget container = Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RadioTopBar(),
                        Expanded(
                          child: PageView(
                            scrollDirection: Axis.horizontal,
                            controller: pageController,
                            onPageChanged: (value) {
                              ref
                                  .read(navigationProvider.notifier)
                                  .selectedItem(value);
                            },
                            children: [
                              Home(
                                key: UniqueKey(),
                              ),
                              Notizie(
                                key: UniqueKey(),
                              ),
                            ],
                          ),
                        ),
                        RadioBottomPlayerWidget()
                      ],
                    ),
                  ],
                );

                if (snapshot.hasData) {
                  var resultData = snapshot.data as List<ConnectivityResult>;

                  if (resultData.first == ConnectivityResult.none) {
                    container = Container(
                      child: NoInternet(),
                    );
                  }
                }

                return container;
              },
              future: checkConnection(),
            ),
            appBar: PreferredSize(
              child: AppBar(
                  systemOverlayStyle: SystemUiOverlayStyle.dark,
                  elevation: 0,
                  backgroundColor: context.statusBarColor()),
              preferredSize: Size.fromHeight(0),
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (value) {
                pageController.animateToPage(
                  value,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              },
              currentIndex: selectedIndex,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: context.bottomNavSelectedItemColor(),
              unselectedItemColor: context.bottomNavUnselectedItemColor(),
              unselectedLabelStyle: context.bottomNavTextStyle(),
              selectedLabelStyle: context.bottomNavSelectedTextStyle(),
              items: List.generate(navItems.length, (index) {
                return BottomNavigationBarItem(
                  icon: navItems[index].icon,
                  label: navItems[index].label,
                );
              }),
            )),
      ),
    );
  }
}

Future<List<ConnectivityResult>> checkConnection() async {
  return await Connectivity().checkConnectivity();
}

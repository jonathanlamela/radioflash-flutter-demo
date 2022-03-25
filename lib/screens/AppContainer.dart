import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radioflash/ThemeConfig.dart';
import 'package:radioflash/bloc/navigation_bloc.dart';
import 'package:radioflash/screens/NoInternet.dart';
import 'package:radioflash/screens/Notizie/Notizie.dart';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:radioflash/widgets/radio_bottom_player/radio_bottom_player_widget.dart';

import 'Home/Home.dart';
import 'Classifica/ClassificaPage.dart';
import '../widgets/RadioTopBar.dart';

class AppContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppContainerState();
  }
}

class AppContainerState extends State<AppContainer> {
  var pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var navItems = [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.bar_chart),
        label: "Classifica",
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
                              context.read<NavigationBloc>().add(
                                  NavigationPageChangedEvent(
                                      currentPage: value));
                            },
                            children: [
                              Home(
                                key: UniqueKey(),
                              ),
                              ClassificaPage(
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
                  if ((snapshot.data as ConnectivityResult) ==
                      ConnectivityResult.none) {
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
            bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
              builder: (context, state) {
                return BottomNavigationBar(
                  onTap: (value) {
                    pageController.animateToPage(
                      value,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                  currentIndex: state.currentPage,
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
                );
              },
            )),
      ),
    );
  }
}

Future<ConnectivityResult> checkConnection() async {
  return await Connectivity().checkConnectivity();
}

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:radioflash/ThemeConfig.dart';
import 'package:radioflash/models/Classifica.dart';
import 'package:radioflash/screens/Notizie/Notizie.dart';
import 'package:radioflash/services/NavigationProvider.dart';
import 'package:radioflash/widgets/RadioPlayerBottom/RPBWidget.dart';

import 'package:flutter/material.dart';

import 'Home/Home.dart';
import 'Classifica/ClassificaPage.dart';
import 'RadioPlayer/RadioPlayer.dart';
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
        icon: Icon(Icons.radio),
        label: "Radio",
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
          body: Stack(
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
                        Provider.of<NavigationProvider>(context, listen: false)
                            .setPage(value);
                      },
                      children: [
                        Home(
                          key: UniqueKey(),
                        ),
                        RadioPlayer(
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
                  RPBWidget()
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
          bottomNavigationBar: Consumer<NavigationProvider>(
            builder: (context, value, child) {
              return BottomNavigationBar(
                onTap: (value) {
                  pageController.animateToPage(
                    value,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                },
                currentIndex: value.currentPage,
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
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radioflash/screens/Home/components/HitsRadio.dart';

import 'package:radioflash/screens/Home/components/OnAirNowProgramWidget.dart';
import 'package:radioflash/screens/Home/components/UltimeUsciteTablet.dart';
import 'package:radioflash/widgets/RadioSize.dart';

import 'components/CanzoneInOnda.dart';
import 'components/UltimeUscite.dart';
import 'components/UltimiSuonatiInOnda.dart';
import 'components/UltimiSuonatiInOndaTablet.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Widget layout = HomeContentMobile();

        if (constraints.minWidth > 700) {
          layout = HomeContentTablet(
            widthPercent: 0.9,
          );
        }

        return AnimatedSwitcher(
            duration: Duration(milliseconds: 300), child: layout);
      },
    );
  }
}

class HomeContentMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  height: getSliderHeight(context),
                  child: OnAirNowProgramWidget(),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 24),
                  color: Color.fromARGB(70, 255, 13, 13),
                  child: Column(
                    children: [
                      CanzoneInOnda(),
                      UltimiSuonatiInOnda(),
                      UltimeUscite(),
                      HitsRadio()
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomeContentTablet extends StatelessWidget {
  double widthPercent = 1;
  HomeContentTablet({Key? key, required this.widthPercent}) : super(key: key);
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  height: getSliderHeight(context),
                  child: OnAirNowProgramWidget(),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 24),
                  color: Color.fromARGB(70, 255, 13, 13),
                  child: Column(
                    children: [
                      CanzoneInOnda(),
                      UltimiSuonatiInOndaTablet(),
                      UltimeUsciteTablet(),
                      HitsRadio()
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

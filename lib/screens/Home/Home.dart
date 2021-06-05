import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radioflash/screens/Home/components/HitsRadio.dart';

import 'package:radioflash/screens/Home/components/OnAirNowProgramWidget.dart';
import 'package:radioflash/screens/Home/components/UltimaClassificaWidget.dart';
import 'package:radioflash/widgets/RadioSize.dart';

import '../../ThemeConfig.dart';
import 'components/CanzoneInOnda.dart';
import 'components/UltimeUscite.dart';
import 'components/UltimiSuonatiInOnda.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: Container(
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
                    margin: EdgeInsets.only(top: 24, left: 10, right: 10),
                    decoration: context.homeContainerStyle(),
                    padding: EdgeInsets.only(
                        left: 24, right: 24, top: 10, bottom: 24),
                    child: Column(
                      children: [
                        CanzoneInOnda(),
                        UltimiSuonatiInOnda(),
                        UltimaClassificaWidget(),
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
      ),
    );
  }
}

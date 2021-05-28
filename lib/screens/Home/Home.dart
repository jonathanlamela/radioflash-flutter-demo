import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radioflash/screens/Home/components/HitsRadio.dart';

import 'package:radioflash/screens/Home/components/OnAirNowProgramWidget.dart';
import 'package:radioflash/screens/Home/components/UltimaClassificaWidget.dart';
import 'package:radioflash/widgets/RadioSize.dart';

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
                    margin: EdgeInsets.only(top: 24),
                    color: Colors.black87,
                    padding: EdgeInsets.only(
                        left: 24, right: 24, top: 24, bottom: 24),
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

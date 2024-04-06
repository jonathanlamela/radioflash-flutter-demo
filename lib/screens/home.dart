import 'package:flutter/material.dart';

import 'package:radioflash/widgets/RadioSize.dart';
import 'package:radioflash/widgets/home_canzone_in_onda.dart';
import 'package:radioflash/widgets/home_hits_radio.dart';
import 'package:radioflash/widgets/home_programma_in_onda_widget.dart';
import 'package:radioflash/widgets/home_ultime_uscite.dart';
import 'package:radioflash/widgets/home_ultimi_suonati.dart';
import 'package:radioflash/widgets/home_webradio_choose.dart';

import '../ThemeConfig.dart';

var frequenzeSicilia = ["90.6", "93.5", "97.3", "99.7", "104.9"];

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
                    child: HomeProgrammaInOndaWidget(),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 24, left: 10, right: 10),
                    child: Column(
                      children: [
                        CardHome(
                          padding: EdgeInsets.all(16),
                          child: HomeCanzoneInOnda(),
                        ),
                        Container(
                          height: 200,
                          child: HomeWebRadioChooseWidget(),
                        ),
                        CardHome(
                          padding: EdgeInsets.all(16),
                          child: HomeUltimiSuonati(),
                        ),
                        FrequenzeRadio(),
                        CardHome(
                          padding: EdgeInsets.all(16),
                          child: HomeUltimeUscite(),
                        ),
                        CardHome(
                          padding: EdgeInsets.all(16),
                          child: HomeHitsRadio(),
                        )
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

class CardHome extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  CardHome({required this.child, this.padding});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? EdgeInsets.only(left: 24, right: 24, top: 10, bottom: 24),
      margin: EdgeInsets.only(bottom: 8),
      decoration: context.cardHomeDecoration(),
      child: this.child,
    );
  }
}

class FrequenzeRadio extends StatelessWidget {
  const FrequenzeRadio({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: context.homeContainerColor(),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 8),
            padding: EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.white, width: 0.2))),
            child: Row(
              children: [
                Text(
                  "Frequenze",
                  textScaler: MediaQuery.of(context).textScaler,
                  style: context.ultimiSuonatiPlaylistTextStyle(),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: context.homeContainerColor(),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "SICILIA (FM)",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:
                              List.generate(frequenzeSicilia.length, (index) {
                            return Container(
                              padding: EdgeInsets.only(right: 8),
                              child: Text(
                                frequenzeSicilia.elementAt(index),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "MALTA,GOZO E SUD SICILIA (DAB+)",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 8),
                              child: Text(
                                "6C",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

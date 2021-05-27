import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './components/WebRadioChoose.dart';

import 'components/WebRadioChoose.dart';
import 'components/UltimiSuonatiPlaylist.dart';

class RadioPlayer extends StatelessWidget {
  RadioPlayer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.minWidth > 900) {
          return RadioPlayerTablet();
        } else {
          return RadioPlayerMobile();
        }
      },
    );
  }
}

class RadioPlayerMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Container(height: 200, child: WebRadioChooseWidget()),
                  Container(
                    padding: EdgeInsets.only(left: 24, right: 24, top: 24),
                    height: 430,
                    child: UltimiSuonatiPlaylist(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RadioPlayerTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      margin: EdgeInsets.only(left: 5, right: 5),
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: 24),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.6,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 3,
                    child: Container(
                      child: WebRadioChooseWidget(),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Column(
                      children: [
                        Expanded(
                          child: UltimiSuonatiPlaylist(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

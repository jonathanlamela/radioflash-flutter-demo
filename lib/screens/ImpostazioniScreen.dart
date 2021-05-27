import 'package:flutter/services.dart';

import '../ThemeConfig.dart';

import 'package:flutter/material.dart';

class ImpostazioniScreen extends StatefulWidget {
  ImpostazioniScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ImpostazioniScreenState();
  }
}

class ImpostazioniScreenState extends State<ImpostazioniScreen> {
  @override
  Widget build(BuildContext context) {
    var tophead = Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: themePrimary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(60, 30),
          bottomRight: Radius.elliptical(60, 30),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(24),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        color: topIconColor,
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    var optionbody = Container(
      margin: EdgeInsets.only(top: 120),
      padding: EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Impostazioni",
            style: TextStyle(
                fontSize: 16,
                fontFamily: themeFontFamily,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );

    return Container(
      color: themePrimary,
      child: SafeArea(
        child: Scaffold(
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Stack(
              children: [tophead, optionbody],
            ),
          ),
        ),
      ),
    );
  }
}

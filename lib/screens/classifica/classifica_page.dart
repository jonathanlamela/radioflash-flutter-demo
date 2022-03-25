import 'package:flutter/material.dart';

import 'package:radioflash/widgets/classifica/classifica_anno_control.dart';
import 'package:radioflash/widgets/classifica/classifica_control.dart';
import 'package:radioflash/widgets/classifica/classifica_render.dart';
import "../../ThemeConfig.dart";

class ClassificaPage extends StatefulWidget {
  ClassificaPage({Key? key}) : super(key: key);

  @override
  _ClassificaPageState createState() => _ClassificaPageState();
}

class _ClassificaPageState extends State<ClassificaPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 24, left: 10, right: 10),
              decoration: BoxDecoration(
                color: context.homeContainerColor(),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              padding: EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 24),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    margin: EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: Colors.white, width: 0.2))),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Classifica",
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor,
                              style: context.classificaPageTextStyle(),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  AnnoControl(),
                  ClassificaControl(),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 20),
                      child: SingleChildScrollView(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          child: ClassificaRender(
                            key: UniqueKey(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

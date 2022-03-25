import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../ThemeConfig.dart';

class ContattoInterazione extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.white, width: 0.2))),
          child: Row(
            children: [
              Text(
                "Contatti",
                textScaleFactor: MediaQuery.of(context).textScaleFactor,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(primary: context.themePrimary()),
                onPressed: () {
                  launch("https://wa.me/+393348715100");
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Icon(Icons.message, color: Colors.white),
                      Text(
                        "WhatsApp",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.orange),
                onPressed: () {
                  launch("https://www.radioflash.fm");
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Icon(Icons.web, color: Colors.white),
                      Text(
                        "Sito web",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.blue),
                onPressed: () {
                  launch(
                      "https://www.facebook.com/radioflashlaradiochefunziona/");
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Icon(Icons.facebook, color: Colors.white),
                      Text(
                        "Facebook",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

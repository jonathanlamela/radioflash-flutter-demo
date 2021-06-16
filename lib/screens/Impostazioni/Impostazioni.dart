import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImpostazioniScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ImpostazioniScreenState();
  }
}

class ImpostazioniScreenState extends State<ImpostazioniScreen> {
  bool? notifyNotizieStatus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getNotifyNotizieStatus();
  }

  getNotifyNotizieStatus() async {
    notifyNotizieStatus = await getOptionBool('notifyNotizie');

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Impostazioni"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: Colors.grey, width: 0.2))),
                    child: Text(
                      "Notifiche",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: 8,
                    child: Container(child: Text("Ricevi notifiche notizie"))),
                Flexible(
                  flex: 2,
                  child: Switch(
                    value: notifyNotizieStatus ?? false,
                    onChanged: (value) {
                      setState(() {
                        notifyNotizieStatus = value;
                      });
                      writeOptionBool('notifyNotizie', value);

                      FirebaseMessaging messaging = FirebaseMessaging.instance;

                      if (value == true) {
                        messaging.subscribeToTopic("notizie");
                      } else {
                        messaging.unsubscribeFromTopic("notizie");
                      }
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<bool> getOptionBool(option) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(option)!;
  }

  writeOptionBool(option, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(option, value);
  }
}

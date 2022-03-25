import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:radioflash/models/NewSongRelease.dart';
import 'package:http/http.dart' as http;
import 'package:radioflash/widgets/home_ultime_uscite_mobile.dart';
import 'package:radioflash/widgets/home_ultime_uscite_tablet.dart';

Future<List<NewSongRelease>> fetchUltimeUscite(dynamic link) async {
  var httpClient = http.Client();

  var response = await httpClient.get(Uri.parse(link));

  var responseContent =
      jsonDecode(response.body)["result"].cast<Map<String, dynamic>>() ?? [];

  return compute(parseUltimeUscite, responseContent);
}

List<NewSongRelease> parseUltimeUscite(responseBody) {
  return responseBody
      .map<NewSongRelease>((e) => NewSongRelease.fromJson(e))
      .toList();
}

class HomeUltimeUscite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuerySize = MediaQuery.of(context).size;

    if (mediaQuerySize.width > 600) {
      return HomeUltimeUsciteTablet();
    } else if (mediaQuerySize.width > 300) {
      return HomeUltimeUsciteMobile();
    } else {
      return HomeUltimeUsciteMobile();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/TrackItem.dart';

class PlaylistItem extends StatelessWidget {
  final TrackItem item;
  PlaylistItem({required this.item});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1 / 1,
            child: Container(
              margin: EdgeInsets.all(4),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                child: FittedBox(
                  child: item.cover,
                  fit: BoxFit.fill,
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(blurRadius: 5, color: Colors.black.withOpacity(0.5))
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: GoogleFonts.quicksand(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    item.artist,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

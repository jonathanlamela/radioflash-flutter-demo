import 'package:flutter/material.dart';
import 'package:radioflash/models/NewSongRelease.dart';
import 'package:radioflash/widgets/home_ultime_uscite_detail.dart';

class HomeUltimeUsciteListMobile extends StatelessWidget {
  const HomeUltimeUsciteListMobile({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<NewSongRelease> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        CustomScrollView(
          primary: false,
          shrinkWrap: true,
          slivers: [
            SliverGrid(
              gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                childAspectRatio: 1,
              ),
              delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return InkWell(
                    onTap: () async {
                      await showGeneralDialog(
                        transitionDuration: Duration(milliseconds: 200),
                        context: context,
                        barrierLabel: '',
                        barrierDismissible: true,
                        barrierColor: Colors.white70,
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return Row();
                        },
                        transitionBuilder: (context, a1, a2, widget) {
                          return Transform.scale(
                            scale: a1.value,
                            child: Opacity(
                              opacity: a1.value,
                              child: HomeUltimeUsciteDetail(
                                  item: items.elementAt(index)),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      child: items.elementAt(index).cover,
                    ),
                  );
                },
                childCount: items.length >= 12 ? 12 : items.length,
              ),
            ),
          ],
        ),
        Container(
          height: 0,
        )
      ],
    );
  }
}

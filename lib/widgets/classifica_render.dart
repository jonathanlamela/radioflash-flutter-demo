import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radioflash/ThemeConfig.dart';
import 'package:radioflash/provider.dart';
import 'package:radioflash/widgets/loading_progress.dart';

class ClassificaRender extends ConsumerWidget {
  ClassificaRender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var selected =
        ref.watch(classificaProvider.select((value) => value.selected));

    var items = ref.watch(classificaProvider.select((value) => value.items));

    if (selected != null && items != null && items.isNotEmpty) {
      return Column(
        key: UniqueKey(),
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          selected.items.length,
          (index) {
            var item = selected.items.elementAt(index);
            var symbol = Icon(Icons.arrow_drop_up, color: Colors.green);

            switch (item.movement) {
              case "=":
                {
                  symbol = Icon(Icons.swap_vert, color: Colors.yellow);
                }
                break;
              case "up":
                {
                  symbol = Icon(Icons.arrow_upward, color: Colors.greenAccent);
                }
                break;
              case "down":
                {
                  symbol = Icon(Icons.arrow_downward, color: Colors.redAccent);
                }
                break;
            }
            return Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${index + 1}",
                            style: context.classificaNumeroTextStyle()),
                        symbol,
                      ],
                    ),
                  ),
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
                        decoration: context.classificaCoverDecoration()),
                  ),
                  Flexible(
                    flex: 6,
                    child: Row(
                      children: [
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.only(left: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.titolo!,
                                  style: context.classificaSongTitleTextStyle(),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(children: [
                                  Flexible(
                                    child: Text(
                                      stringAutori(item.autori),
                                      overflow: TextOverflow.ellipsis,
                                      style: context
                                          .classificaSongAuthorsTextStyle(),
                                    ),
                                  )
                                ]),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      );
    } else {
      return LoadingProgress();
    }
  }
}

String stringAutori(autori) {
  String result = "";

  List.generate(autori.length, (index) {
    result += autori.elementAt(index).name! +
        (autori.length > 1 && index < autori.length - 1 ? " & " : "");
  });

  return result;
}

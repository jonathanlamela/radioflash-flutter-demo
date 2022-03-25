import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radioflash/provider.dart';

class AnnoControl extends ConsumerWidget {
  AnnoControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var anni = ref.watch(classificaProvider.select((value) => value.anni));
    var currentYear =
        ref.watch(classificaProvider.select((value) => value.currentYear));

    Widget content = Container();

    if (anni != null && anni.isNotEmpty) {
      content = Expanded(
        child: Container(
          child: DropdownButton(
              isExpanded: true,
              dropdownColor: Colors.black,
              style: TextStyle(color: Colors.white),
              onChanged: (value) {
                ref
                    .read(classificaProvider.notifier)
                    .downloadCharts(value.toString());
              },
              value: currentYear,
              items: List.generate(anni.length, (index) {
                return DropdownMenuItem(
                  value: anni.elementAt(index),
                  child: Text(
                    anni.elementAt(index),
                  ),
                );
              })),
        ),
      );
    }

    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 150,
            child: Text(
              "Anno",
              textScaleFactor: MediaQuery.of(context).textScaleFactor,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
          content
        ],
      ),
    );
  }
}

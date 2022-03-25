import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radioflash/models/Classifica.dart';
import 'package:radioflash/provider.dart';

class ClassificaControl extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget content = Container();

    var currentChart =
        ref.watch(classificaProvider.select((value) => value.selected));
    var items = ref.watch(classificaProvider.select((value) => value.items));

    if (items != null && items.isNotEmpty) {
      content = Expanded(
        child: Container(
          child: DropdownButton(
            isExpanded: true,
            dropdownColor: Colors.black,
            style: TextStyle(color: Colors.white),
            value: currentChart,
            onChanged: (value) {
              ref
                  .read(classificaProvider.notifier)
                  .pickChart(value as Classifica);
            },
            items: List.generate(items.length, (index) {
              return DropdownMenuItem(
                value: items.elementAt(index),
                child: Text(
                  items.elementAt(index).titolo!,
                ),
              );
            }),
          ),
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
              "Classifica",
              textScaleFactor: MediaQuery.of(context).textScaleFactor,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
          content,
        ],
      ),
    );
  }
}

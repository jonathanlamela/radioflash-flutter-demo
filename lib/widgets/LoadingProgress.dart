import 'package:flutter/material.dart';
import '../ThemeConfig.dart';

class LoadingProgress extends StatelessWidget {
  const LoadingProgress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      key: UniqueKey(),
      children: [
        Center(
          child: CircularProgressIndicator(
            backgroundColor: context.loadingProgressBackgroundColor(),
            valueColor: new AlwaysStoppedAnimation<Color>(
                context.loadingProgressColor()),
          ),
        ),
      ],
    );
  }
}

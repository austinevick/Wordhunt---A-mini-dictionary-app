import 'package:flutter/material.dart';

import 'constant.dart';

class LoadingWidget extends StatelessWidget {
  final bool isLoading;
  final Widget? child;
  final Color? color;
  final Color? spinnerColor;
  const LoadingWidget(
      {Key? key,
      required this.isLoading,
      required this.child,
      this.color,
      this.spinnerColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? child!
        : Center(
            child: SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(
                    color: spinnerColor ?? appColor, strokeWidth: 2)),
          );
  }
}

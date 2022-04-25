import 'package:flutter/material.dart';

import 'TishAppColors.dart';

Widget totalRatting(var value) {
  value -= 0.7;

  return SizedBox(
    height: 10,
    child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return index <= value
              ? Icon(Icons.star, color: mainColorTheme, size: 16)
              : Icon(Icons.star_outline, color: mainColorTheme, size: 16);
        }),
  );
}

Widget Function(BuildContext, String)? placeholderWidgetFn() =>
    (_, s) => placeholderWidget();

Widget placeholderWidget() => Container(
    height: 20, width: 20, child: Center(child: CircularProgressIndicator()));

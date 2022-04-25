import 'package:TishApp/TishApp/utils/TishAppColors.dart';
import 'package:flutter/material.dart';

class SubmitBtn extends StatelessWidget {
  const SubmitBtn({Key? key, required this.onPressed}) : super(key: key);

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: mainColorTheme,
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(Icons.arrow_forward_ios_outlined),
          color: Colors.white,
        ));
  }
}

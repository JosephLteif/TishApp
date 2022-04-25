import 'package:flutter/material.dart';

class CloseBtn extends StatelessWidget {
  const CloseBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(
              color: Colors.grey,
              width: 2,
            ),
          ),
          child: Icon(Icons.close)),
    );
  }
}

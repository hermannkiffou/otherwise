import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final Function()? onTap;
  final Widget customWidget;

  MyAppBar({
    required this.onTap,
    required this.customWidget,
  });

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
        leading: CircleAvatar(
          child: Image.asset(
            'assets/imgBook.png',
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.menu,
              size: 40,
            ),
          )
        ],
        title: customWidget);
  }
}

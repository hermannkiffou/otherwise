import 'package:flutter/material.dart';
import 'package:othewise/components/constants.dart';
import 'package:othewise/components/bottomNav.dart';

class Principale extends StatefulWidget {
  static const String id = "pricinpale";

  @override
  State<Principale> createState() => _PrincipaleState();
}

class _PrincipaleState extends State<Principale> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Image.asset(
            'assets/imgBook.png',
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.menu,
              size: 40,
            ),
          )
        ],
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Bienvenue !",
            ),
            Text("Hermann KIFFOU"),
          ],
        ),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Bienvenu",
            textAlign: TextAlign.center,
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}

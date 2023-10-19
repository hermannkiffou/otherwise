import 'package:flutter/material.dart';
import 'package:othewise/components/bouton.dart';
import 'package:othewise/components/constants.dart';
import 'package:othewise/screens/loginStart.dart';

class Start2 extends StatelessWidget {
  static const String id = "start2";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Image.asset(
                  "assets/img6.png",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Avec Otherwise !",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(
                        15,
                      ),
                      child: Text(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                        ),
                        "Anticipez l'achat de vos fournitures scolaires, et bénéficiez de moyens de payements flexibles et échelonnés...",
                      ),
                    ),
                    MyButton(
                      onTap: () {
                        Navigator.pushNamed(context, LoginStart.id);
                      },
                      text: "Suivant",
                      textColor: Colors.white,
                      bgColor: mainColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

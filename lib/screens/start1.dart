import 'package:flutter/material.dart';
import 'package:othewise/components/bouton.dart';
import 'package:othewise/components/constants.dart';
import 'package:othewise/Screens/start2.dart';

class StartedPage extends StatelessWidget {
  static const String id = "statedPage";
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
                    "assets/imgBook.png",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(40),
                child: Container(
                  height: MediaQuery.of(context).size.height / 2.4,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Bienvenue sur Otherwise !",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(
                          20,
                        ),
                        child: Text(
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                          ),
                          "Ici vous pouvez acheter et vendre des livres selon votre budget, et selon vos besoins ...",
                        ),
                      ),
                      MyButton(
                        onTap: () {
                          Navigator.pushNamed(context, Start2.id);
                        },
                        text: "Commencer",
                        textColor: Colors.white,
                        bgColor: mainColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

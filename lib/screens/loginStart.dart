import 'package:flutter/material.dart';
import 'package:othewise/components/constants.dart';
import 'package:othewise/components/optionConnex.dart';
import 'package:othewise/screens/connexionOptions.dart';
import 'package:othewise/screens/inscription.dart';

class LoginStart extends StatelessWidget {
  static const String id = "loginStart";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Image.asset(
                "assets/inscription.jpg",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40),
            child: Container(
              height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Incrivez vous ici !",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  OptionConnex(
                    onTap: null,
                    image: Image.asset("assets/google.png"),
                    text: "Incription avec Google",
                  ),
                  OptionConnex(
                    onTap: null,
                    image: Image.asset("assets/facebook.png"),
                    text: 'Inscription avec Facebook',
                  ),
                  OptionConnex(
                    onTap: () => Navigator.pushNamed(context, Inscription.id),
                    image: Image.asset("assets/avatar.png"),
                    text: 'Inscription Annonyme',
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ConnexionOption.id);
                      },
                      child: const Text(
                        "J'ai déjà un compte !",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ))
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}

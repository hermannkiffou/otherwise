import 'package:flutter/material.dart';
import 'package:otherwise/components/constants.dart';
import 'package:otherwise/screens/connexion.dart';
import 'package:otherwise/screens/loginStart.dart';
import 'package:otherwise/components/optionConnex.dart';

class ConnexionOption extends StatefulWidget {
  static const String id = "connexionOption";

  @override
  State<ConnexionOption> createState() => _ConnexionOptionState();
}

class _ConnexionOptionState extends State<ConnexionOption> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(40),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "assets/connexion.jpg",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40),
              child: Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: mainColor, borderRadius: BorderRadius.circular(30)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Choisir une option d'inscription !",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    OptionConnex(
                      onTap: null,
                      image: Image.asset("assets/google.png"),
                      text: "Connexion par Google",
                    ),
                    OptionConnex(
                      onTap: null,
                      image: Image.asset("assets/facebook.png"),
                      text: 'Connexion par Facebook',
                    ),
                    OptionConnex(
                      onTap: () => Navigator.pushNamed(context, Connexion.id),
                      image: Image.asset("assets/avatar.png"),
                      text: 'Connexion Annonyme',
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LoginStart.id);
                      },
                      child: const Text(
                        "Je n'ai pas de compte !",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

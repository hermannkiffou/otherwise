import 'package:flutter/material.dart';
import 'package:othewise/Screens/loginStart.dart';
import 'package:othewise/Screens/principale.dart';
import 'package:othewise/components/bouton.dart';
import 'package:othewise/components/constants.dart';
import 'package:othewise/components/textField.dart';

class Connexion extends StatefulWidget {
  static const String id = "connexion";

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _login = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      'Connexion',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      MyTextField(
                        controller: _login,
                        hintText: 'Email ou Téléphone',
                        obscureText: false,
                        textInputType: TextInputType.name,
                        validator: (value) {
                          null;
                        },
                        onSaved: (value) {
                          _login.text = value;
                        },
                      ),
                      MyTextField(
                        controller: _password,
                        hintText: 'Mot de passe',
                        obscureText: true,
                        textInputType: TextInputType.text,
                        validator: (value) {},
                        onSaved: (value) {
                          _password.text = value;
                        },
                      ),
                    ],
                  ),
                  MyButton(
                    onTap: () => Navigator.pushNamed(context, Principale.id),
                    text: "Connexion",
                    textColor: Colors.white,
                    bgColor: mainColor,
                  ),
                  TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, LoginStart.id),
                    child: const Text(
                      "Je n'ai pas de compte!",
                      style: TextStyle(
                        fontSize: 18,
                        color: secondColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

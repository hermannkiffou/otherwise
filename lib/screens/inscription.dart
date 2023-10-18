import 'package:flutter/material.dart';
import 'package:othewise/components/bouton.dart';
import 'package:othewise/components/constants.dart';
import 'package:othewise/components/textField.dart';
import 'package:othewise/Screens/connexionOptions.dart';
import 'package:othewise/Screens/confirmInscription.dart';

class Inscription extends StatefulWidget {
  static const String id = "inscription";

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _fullName = TextEditingController();
  TextEditingController _login = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Container(
            height: MediaQuery.of(context).size.height / 1.8,
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
                      'Incription',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      MyTextField(
                        controller: _fullName,
                        hintText: 'Nom Complet',
                        obscureText: false,
                        textInputType: TextInputType.name,
                        validator: (value) {
                          null;
                        },
                        onSaved: (value) {
                          _fullName.text = value;
                        },
                      ),
                      MyTextField(
                        controller: _login,
                        hintText: 'Email ou Téléphone',
                        obscureText: false,
                        textInputType: TextInputType.text,
                        validator: (value) {},
                        onSaved: (value) {
                          _login.text = value;
                        },
                      ),
                      MyTextField(
                        controller: _password,
                        hintText: 'Mot de passe',
                        obscureText: true,
                        textInputType: TextInputType.visiblePassword,
                        validator: (value) {},
                        onSaved: (value) {
                          _password.text = value;
                        },
                      ),
                      MyTextField(
                        controller: _confirmPassword,
                        hintText: 'Confirmer le mot de passe',
                        obscureText: true,
                        textInputType: TextInputType.visiblePassword,
                        validator: (value) {},
                        onSaved: (value) {
                          _confirmPassword.text = value;
                        },
                      ),
                    ],
                  ),
                  MyButton(
                    onTap: () =>
                        Navigator.pushNamed(context, ConfirmInscription.id),
                    text: "S'inscrire",
                    textColor: Colors.white,
                    bgColor: mainColor,
                  ),
                  TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, ConnexionOption.id),
                    child: const Text(
                      "J'ai déjà un compte !",
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

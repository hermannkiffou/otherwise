import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:othewise/components/bouton.dart';
import 'package:othewise/components/constants.dart';
import 'package:othewise/components/textField.dart';
import 'package:othewise/screens/connexionOptions.dart';
import 'package:othewise/screens/principale.dart';
import 'package:othewise/services/authServices.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Inscription extends StatefulWidget {
  static const String id = "inscription";
  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _fullName = TextEditingController();
  TextEditingController _login = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  final spinkit = SpinKitWaveSpinner(color: secondColor);
  bool loading = false;

  @override
  void dispose() {
    _fullName.dispose();
    _login.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

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
              child: loading
                  ? spinkit
                  : Column(
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
                          onTap: _signUpWithEmail,
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

  void _signUpWithEmail() async {
    setState(() {
      loading = true;
    });
    String fullName = _fullName.text;
    String login = _login.text;
    String password = _password.text;
    String confirmPassword = _confirmPassword.text;
    User? user = await _auth.createUserWithEmail(login, password);
    setState(() {
      loading = false;
    });
    if (user != null) {
      print("Utilisateur créés avec succès !");
      Navigator.pushNamed(context, Principale.id);
    } else {
      print("Une erreur est survenue lors de l'inscription !");
    }
  }

  void _signUpWithPhone() async {}
}

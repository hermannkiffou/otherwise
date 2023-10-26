import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otherwise/Screens/inscription.dart';
import 'package:otherwise/components/loading.dart';
import 'package:otherwise/components/bouton.dart';
import 'package:otherwise/components/constants.dart';
import 'package:otherwise/components/optionConnex.dart';
import 'package:otherwise/components/textField.dart';
import 'package:otherwise/screens/principale.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Connexion extends StatefulWidget {
  static const String id = "connexion";

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _login = TextEditingController();
  TextEditingController _password = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _store = FirebaseFirestore.instance;
  // User? user;

  bool loading = false;
  String message = "";

  _setLocalSetting(String uid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('uid', uid);
    pref.setBool('connected', true);
  }

//   signIn async() {
//     String login = _login.text;
//     String password = _password.text;
//     try {
//   final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//     email: emailAddress,
//     password: password
//   );
// } on FirebaseAuthException catch (e) {
//   if (e.code == 'user-not-found') {
//     print('No user found for that email.');
//   } else if (e.code == 'wrong-password') {
//     print('Wrong password provided for that user.');
//   }
// }
//   }

  _connexion() async {
    String login = _login.text;
    String password = _password.text;
    if (_formkey.currentState!.validate()) {
      // final collectionUser = await _store
      //     .collection('user')
      //     .where("email", isEqualTo: login)
      //     .get();
      // if ((collectionUser != null) && (collectionUser == password)) {}
      setState(() {
        loading = true;
      });

      try {
        final user = await _auth.signInWithEmailAndPassword(
            email: login, password: password);
        if (user != null) {
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setBool('connected', true);
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, Principale.id);
        }
      } on FirebaseAuthException catch (e) {
        message = "Verifiez votre email et votre mot de passe !";
      } catch (error) {
        message = "Aucun utilisateur ne correspond à votre email";
      }

      setState(() {
        loading = false;
      });

      if (message != "") {
        // ignore: use_build_context_synchronously
        informationMessage(context, message, false, PanaraDialogType.error);
        message = "";
      }
      // Navigator.pushNamed(context, Principale.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            // Image.asset(
            //   "assets/inscription.jpg",
            //   width: MediaQuery.of(context).size.width / 2,
            //   height: 250,
            // ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Center(
                        child: Text(
                          'CONNEXION',
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
                            hintText: 'Email',
                            obscureText: false,
                            textInputType: TextInputType.emailAddress,
                            validator: (value) {
                              String patternEmail =
                                  "^[a-z]+[0-9]*@+[a-z]+.+[a-z]+";
                              RegExp regExpTelephone = RegExp(patternEmail);
                              if (value.isEmpty) {
                                return "Email ou téléphone obligatoire !";
                              }
                              if (regExpTelephone.hasMatch(value)) {
                                return null;
                              } else {
                                return "Adresse email n'est pas dvalude !";
                              }
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
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Vous devez renseigner un mot de passe !";
                              }
                              if (value.length < 8) {
                                return "Mot de passe et court !";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              _password.text = value;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      loading
                          ? SizedBox(
                              height: 100,
                              child: Loading(
                                size: 70,
                                color: mainColor,
                              ),
                            )
                          : MyButton(
                              onTap: () {
                                _connexion();
                              },
                              text: "Connexion",
                              textColor: Colors.white,
                              bgColor: mainColor,
                            ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Inscription.id);
                        },
                        child: const Text(
                          "Je n'ai pas de compte!",
                          style: TextStyle(
                            fontSize: 18,
                            color: secondColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        child: Text(
                          "Autres option de connexion ",
                        ),
                        height: 30,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      OptionConnex(
                          onTap: null,
                          image: Image.asset('assets/google.png'),
                          text: "Connexion par google !"),
                      const SizedBox(
                        height: 5,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      OptionConnex(
                          onTap: null,
                          image: Image.asset('assets/facebook.png'),
                          text: "Connxion par Facebook !"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otherwise/components/bouton.dart';
import 'package:otherwise/components/constants.dart';
import 'package:otherwise/components/loading.dart';
import 'package:otherwise/components/optionConnex.dart';
import 'package:otherwise/components/textField.dart';
import 'package:otherwise/screens/connexion.dart';
import 'package:otherwise/screens/principale.dart';
import 'package:otherwise/services/authServices.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Inscription extends StatefulWidget {
  static const String id = "inscription";

  const Inscription({super.key});
  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _login = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final String message = "";
  final bool succes = false;

  final Widget _separation = const SizedBox(
    height: 10,
  );

  bool loading = false;
  String signUpType = "";
  User? user;

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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image.asset(
                //   "assets/inscription.jpg",
                //   width: MediaQuery.of(context).size.width / 2,
                //   height: 150,
                // ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    const Center(
                      child: Text(
                        'INSCRIPTION',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    MyTextField(
                      controller: _fullName,
                      hintText: 'Nom Complet',
                      obscureText: false,
                      textInputType: TextInputType.name,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Vous devez renseigner votre nom";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _fullName.text = value;
                      },
                    ),
                    MyTextField(
                      controller: _login,
                      hintText: 'Email',
                      obscureText: false,
                      textInputType: TextInputType.emailAddress,
                      validator: (value) {
                        String patternEmail = "^[a-z]+[0-9]*@+[a-z]+.+[a-z]";
                        RegExp regExpEmail = RegExp(patternEmail);
                        if (value.isEmpty) {
                          return "Veillez renseigner votre email ou Téléphone !";
                        } else if (!(regExpEmail.hasMatch(value))) {
                          return "Votre email doit être une adresse email valide !";
                        } else {
                          return null;
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
                      textInputType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Vous devez renseigner un mot de passe";
                        } else if (value.length < 8) {
                          return "Le mot de passe est trop court !";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _password.text = value;
                      },
                    ),
                    MyTextField(
                      controller: _confirmPassword,
                      hintText: 'Confirmer le mot de passe',
                      obscureText: true,
                      textInputType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Vous devez confirmer votre mot de passe !";
                        } else if (value == _password.text) {
                          return null;
                        } else {
                          return "Les mots de passe ne sont pas conformes !";
                        }
                      },
                      onSaved: (value) {
                        _confirmPassword.text = value;
                      },
                    ),
                    _separation,
                    loading
                        ? SizedBox(
                            height: 80,
                            child: Loading(
                              size: 70,
                              color: mainColor,
                            ),
                          )
                        : MyButton(
                            onTap: () {
                              _inscription();
                            },
                            text: "S'inscrire",
                            textColor: Colors.white,
                            bgColor: mainColor,
                          ),
                  ],
                ),
                _separation,
                _separation,
                // const Text("Autres options de connection !"),
                // _separation,
                // OptionConnex(
                //   onTap: () {
                //     confirmationMessage(
                //       context,
                //       "Confirmer vous cette opératioin ?",
                //       sup,
                //     );
                //   },
                //   image: Image.asset("assets/google.png"),
                //   text: "Connexion par Google",
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                // OptionConnex(
                //   onTap: null,
                //   image: Image.asset("assets/facebook.png"),
                //   text: 'Connexion par Facebook',
                // ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, Connexion.id),
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
    );
  }

  void sup() {
    print('Utilisateur supprimé !');
  }

  _setLocalUser(String uid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('uid', uid);
    pref.setBool('connected', true);
  }

  bool status = false;

  Function? close(bool stat) {
    if (stat) {
      return () => Navigator.pushNamed(context, Principale.id);
    } else {
      return () => null;
    }
  }

  void _inscription() async {
    setState(() {
      loading = true;
    });
    String message = "";
    setState(() {
      status = false;
    });
    try {
      String fullName = _fullName.text;
      String login = _login.text;
      String password = _password.text;

      if (_formkey.currentState!.validate()) {
        user = await _auth.createUserWithEmail(login, password);
        if (user != null) {
          // print('User créé dans Firebase authentification');
          final createdUser = await _firestore.collection('user').add({
            'id': user!.uid,
            'name': fullName,
            'email': login,
            'password': password,
            'login': login,
            'avatar': "",
            'adresse': "",
            'city': "",
            'country': "",
            'phone': "",
            'redevence': 0,
            'solde': 0,
            'admin': false,
          });

          if (createdUser != null) {
            // print("User ajouter dans La collection firestore");
            final connectUser = await _auth.signInWithEmail(login, password);
            if (connectUser != null) {
              // print("User connécté avec sucès !");
              _setLocalUser(user!.uid);

              message = "Votre compte a été créé avec succès !";
              PanaraInfoDialog.show(
                context,
                title: "Otherwise",
                message: "Votre compte a été créé avec succès !",
                buttonText: "Fermer",
                onTapDismiss: () {
                  Navigator.pushNamed(context, Connexion.id);
                },
                panaraDialogType: PanaraDialogType.success,
                barrierDismissible: false,
              );

              setState(() {
                status = true;
              });
            } else {
              message =
                  "Echec d'ouverture de session pour l'utilisateur ! veuillez reéssayer";
            }
          } else {
            message = "Echec de creation de l'utilisateur !";
          }
        } else {
          message = "L'adresse email est utilisé par un autre compte !";
        }

        // AFFICHAGE DE MESSAGE
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == "email-already-in-use") {
        message = "Votre adresse email existe déjà utilisé";
      }
    }

    setState(() {
      loading = false;
    });
    // MESSAGE
    if (message != "") {
      PanaraInfoDialog.show(
        context,
        title: "Otherwise",
        message: message,
        buttonText: "Fermer",
        onTapDismiss: () {
          status
              ? Navigator.pushNamed(context, Connexion.id)
              : Navigator.pop(context);
        },
        panaraDialogType:
            status ? PanaraDialogType.success : PanaraDialogType.warning,
        barrierDismissible: status,
      );
    }

    //   InfoMessage info = InfoMessage(
    //       message: message,
    //       typeMessage: PanaraDialogType.error,
    //       close: _close(status));
    //   setState(() {
    //     info.close;
    //   });
    // }

    // void _signUpWithPhone() async {}
  }
}

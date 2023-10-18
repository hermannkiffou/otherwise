import 'package:flutter/material.dart';
import 'package:othewise/components/bouton.dart';
import 'package:othewise/components/constants.dart';
import 'package:othewise/components/textField.dart';
import 'package:othewise/screens/principale.dart';

class ConfirmInscription extends StatefulWidget {
  static const String id = 'confirmInscription';

  @override
  State<ConfirmInscription> createState() => _ConfirmInscriptionState();
}

class _ConfirmInscriptionState extends State<ConfirmInscription> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _validationCode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
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
                  const Text(
                    "Confirmmation d'inscription",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          textAlign: TextAlign.center,
                          """Vous avez réçu un code de comfirmarmation par email. Entrer le code pour finaliser votre inscription""",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      MyTextField(
                        controller: _validationCode,
                        hintText: '--  --  --',
                        obscureText: false,
                        textInputType: TextInputType.name,
                        validator: (value) {
                          null;
                        },
                        onSaved: (value) {
                          _validationCode.text = value;
                        },
                      ),
                    ],
                  ),
                  MyButton(
                    onTap: () => Navigator.pushNamed(
                      context,
                      Principale.id,
                    ),
                    text: "Confirmer",
                    textColor: Colors.white,
                    bgColor: mainColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

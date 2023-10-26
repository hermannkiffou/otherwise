import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:otherwise/screens/connexionOptions.dart';
import 'package:otherwise/screens/start2.dart';
import 'package:otherwise/screens/start1.dart';
import 'package:otherwise/screens/loginStart.dart';
import 'package:otherwise/screens/inscription.dart';
import 'package:otherwise/screens/connexion.dart';
import 'package:otherwise/screens/confirmInscription.dart';
import 'package:otherwise/screens/principale.dart';
import 'package:otherwise/components/onBoarging.dart';
import 'package:otherwise/firebase_options.dart';
import 'package:otherwise/transition.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Transition.id,
      routes: {
        Transition.id: (conext) => Transition(),
        OnBoarding.id: (context) => OnBoarding(),
        StartedPage.id: (context) => StartedPage(),
        Start2.id: (context) => Start2(),
        LoginStart.id: (context) => LoginStart(),
        ConnexionOption.id: (context) => ConnexionOption(),
        Inscription.id: (context) => Inscription(),
        Connexion.id: (context) => Connexion(),
        ConfirmInscription.id: (context) => ConfirmInscription(),
        Principale.id: (context) => Principale(),
      },
      home: Principale(),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:othewise/screens/connexionOptions.dart';
import 'package:othewise/screens/start2.dart';
import 'package:othewise/screens/start1.dart';
import 'package:othewise/screens/loginStart.dart';
import 'package:othewise/screens/inscription.dart';
import 'package:othewise/screens/connexion.dart';
import 'package:othewise/screens/confirmInscription.dart';
import 'package:othewise/screens/principale.dart';
import 'package:othewise/components/onBoarging.dart';
import 'package:othewise/firebase_options.dart';

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
      initialRoute: OnBoarding.id,
      routes: {
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

import 'package:flutter/material.dart';
import 'package:otherwise/components/constants.dart';
import 'package:otherwise/components/loading.dart';
import 'package:otherwise/components/onBoarging.dart';
import 'package:otherwise/screens/connexion.dart';
import 'package:otherwise/screens/principale.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Transition extends StatefulWidget {
  static String id = "tansition";

  @override
  State<Transition> createState() => _TransitionState();
}

class _TransitionState extends State<Transition> {
  bool? onboarded = false;
  bool? connected = false;
  bool loading = false;

  _pref() async {
    setState(() {
      loading = true;
    });
    final SharedPreferences pref = await SharedPreferences.getInstance();

    if (pref.getBool('onboarded') == null) {
      pref.setBool('onboarded', false);
    } else {
      setState(() {
        onboarded = pref.getBool('onboarded');
      });
    }

    if (pref.getBool('connected') == null) {
      pref.setBool('connected', false);
    } else {
      setState(() {
        connected = pref.getBool('connected');
      });
    }

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _pref();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Loading(size: 100, color: mainColor)
          : connected!
              ? Principale()
              : onboarded!
                  ? Connexion()
                  : OnBoarding(),
    );
  }
}

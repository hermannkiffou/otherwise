import 'package:introduction_slider/introduction_slider.dart';
import 'package:flutter/material.dart';
import 'package:otherwise/components/loading.dart';
import 'package:otherwise/screens/inscription.dart';
import 'package:otherwise/components/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class OnBoarding extends StatefulWidget {
  static String id = "onBoarding";

  // ignore: prefer_const_constructors_in_immutables
  OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  bool loading = false;

  onBoarded() async {
    setState(() {
      loading = true;
    });
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('onboarded', true);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionSlider(
      showStatusBar: true,
      items: [
        IntroductionSliderItem(
          backgroundColor: Colors.white,
          logo: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Image.asset("assets/slider2.jpg"),
          ),
          title: const Padding(
            padding: EdgeInsets.all(
              30,
            ),
            child: Text(
              textAlign: TextAlign.center,
              "Bienvenue sur Otherwise !",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          subtitle: const Padding(
            padding: EdgeInsets.only(
              bottom: 100,
              left: 20,
              right: 20,
            ),
            child: Text(
              "Ici vous pouvez acheter et vendre des livres selon votre budget, et selon vos besoins ...",
              style: TextStyle(
                fontSize: 23,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        IntroductionSliderItem(
          backgroundColor: Colors.white,
          logo: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Image.asset("assets/slider3.jpg"),
          ),
          title: const Padding(
            padding: EdgeInsets.only(
              bottom: 30,
            ),
            child: Text(
              "Avec Otherwise !",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          subtitle: const Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              "Anticipez l'achat de vos fournitures scolaires, et bénéficiez de moyens de payements flexibles et échelonnés...",
              style: TextStyle(
                color: Colors.black,
                fontSize: 23,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        IntroductionSliderItem(
          backgroundColor: Colors.white,
          logo: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Image.asset("assets/slider1.jpg"),
          ),
          title: const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              textAlign: TextAlign.center,
              "Sur Otherwise",
              style: TextStyle(
                color: Colors.black,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          subtitle: const Padding(
            padding: EdgeInsets.all(
              25,
            ),
            child: Text(
              "Vous pouver alimenter votre compte personnel et bénéficier de nos offres exceptionnelles, lors de la rentrée scolaire...",
              style: TextStyle(
                color: Colors.black,
                fontSize: 23,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
      done: Done(
        home: const Inscription(),
        child: loading
            ? Loading(size: 60, color: mainColor)
            : TextButton(
                onPressed: () {
                  onBoarded();
                  Navigator.pushNamed(context, Inscription.id);
                },
                child: const Text(
                  'Commencer !',
                  style: TextStyle(
                    fontSize: 20,
                    color: secondColor,
                  ),
                ),
              ),
      ),
      next: const Next(
        child: Padding(
          padding: EdgeInsets.only(
            right: 30,
          ),
          child: Text("Suivant",
              style: TextStyle(
                fontSize: 17,
                color: secondColor,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
      back: const Back(
        child: Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            "Retour",
            style: TextStyle(
              fontSize: 17,
              color: secondColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      dotIndicator: const DotIndicator(
        selectedColor: mainColor,
        unselectedColor: secondColor,
        size: 10,
      ),
    );
  }
}

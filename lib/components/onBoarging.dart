import 'package:introduction_slider/introduction_slider.dart';
import 'package:flutter/material.dart';
import 'package:othewise/screens/loginStart.dart';
import 'package:othewise/components/constants.dart';

class OnBoarding extends StatelessWidget {
  static String id = "onBoarding";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IntroductionSlider(
        showStatusBar: true,
        items: [
          IntroductionSliderItem(
            backgroundColor: Colors.white,
            logo: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset("assets/slider2.jpg"),
            ),
            title: Padding(
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
            subtitle: Padding(
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
          child: TextButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: mainColor,
              foregroundColor: secondColor,
            ),
            child: Text(
              'Commencer !',
              style: TextStyle(
                fontSize: 20,
                color: secondColor,
              ),
            ),
            onPressed: null,
          ),
          home: LoginStart(),
        ),
        next: Next(
          child: Padding(
            padding: const EdgeInsets.only(
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
        back: Back(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
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
        dotIndicator: DotIndicator(
          selectedColor: mainColor,
          unselectedColor: secondColor,
          size: 10,
        ),
      ),
    );
  }
}

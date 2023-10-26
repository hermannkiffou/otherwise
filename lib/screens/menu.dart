import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otherwise/components/constants.dart';
import 'package:otherwise/components/loading.dart';
import 'package:otherwise/components/textField.dart';
import 'package:otherwise/screens/connexion.dart';
import 'package:otherwise/screens/listArticle.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController adresseController = TextEditingController();

  String uid = "";
  String message = "";

  String storeUid = "";
  String id = "";
  String? email = "hermann@gmail.com";
  String name = "Hermann KIFFOU";
  bool admin = false;
  String avatar = "";
  String phone = "";
  String city = "";
  String country = "";
  String adresse = "";
  int solde = 0;
  int redevence = 0;
  bool loading = false;

  int index = 0;

  _getCurrentUserInfo() async {
    var currentUser = auth.currentUser;
    if (currentUser != null) {
      var storeUser = await _firestore
          .collection('user')
          .where('id', isEqualTo: currentUser.uid)
          .get()
          .then((users) {
        for (final user in users.docs) {
          print(user.data());
          setState(() {
            storeUid = user.id;
            name = user.data()['name'];
            id = user.data()['id'];
            email = user.data()['email'];
            admin = user.data()['admin'];
            avatar = user.data()['avatar'];
            phone = user.data()['phone'];
            city = user.data()['city'];
            country = user.data()['country'];
            adresse = user.data()['adresse'];
            solde = user.data()['solde'];
            redevence = user.data()['redevence'];
          });
        }
      });
      print("Store id $storeUid  uid $uid email $email");
    } else {
      print("Aucun utilisateur trouvé !");
    }
  }

  @override
  void initState() {
    setState(() {
      loading = true;
    });
    _getCurrentUserInfo();
    setState(() {
      loading = false;
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        body: loading
            ? Center(child: Loading(size: 50, color: secondColor))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2.5,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 10.0,
                                        left: 10,
                                        right: 10,
                                      ),
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundImage: AssetImage(
                                          'assets/avatar.png',
                                        ),
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        print("Modifier Avatar");
                                      },
                                      child: Text(
                                        'Editer',
                                        style: TextStyle(
                                          color: secondColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        admin ? Text("ADMIN") : Text('USER'),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            filInForm();
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        "Modifiez vos informations "),
                                                    content: updateUserForm(),
                                                    actions: [
                                                      ElevatedButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: Text("Annuler"),
                                                      ),
                                                      loading
                                                          ? Loading(
                                                              color:
                                                                  secondColor,
                                                              size: 40,
                                                            )
                                                          : ElevatedButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  loading =
                                                                      true;
                                                                });
                                                                updateAction();
                                                                setState(() {
                                                                  loading =
                                                                      false;
                                                                });
                                                              },
                                                              child: Text(
                                                                  "Modifier"),
                                                            ),
                                                    ],
                                                  );
                                                });
                                          },
                                          child: Text(
                                            "Modifier Profil",
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("NOM : $name"),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("TELEPHONE : $phone"),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("EMAIL : $email"),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 100,
                                  width:
                                      MediaQuery.of(context).size.width / 2.6,
                                  decoration: BoxDecoration(),
                                  child: Column(
                                    children: [
                                      Text("VILLE : $city"),
                                      Text("PAYS : $country"),
                                      Text("ADRESSE GEO : "),
                                      Text("$adresse"),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Text(
                                            "SOLDE : ",
                                          ),
                                          Text(
                                            "$solde FR CFA ",
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        children: [
                                          Text(
                                            "SOLDE : ",
                                          ),
                                          Text(
                                            "$redevence FR CFA ",
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            TextButton(
                              onPressed: null,
                              child: Text(
                                "Modifier mon mot de passe",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    Container(
                      height: MediaQuery.of(context).size.height / 1.3,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("MES OPTIONS"),
                            const Text(
                                "--------------------------------------------"),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, ArticleList.id),
                              child: Text("Liste des Articles"),
                            ),
                            TextButton(
                              onPressed: null,
                              child: Text("Liste des Articles"),
                            ),
                            TextButton(
                              onPressed: null,
                              child: Text("Liste des Articles"),
                            ),
                            TextButton(
                              onPressed: null,
                              child: Text("Liste des Articles"),
                            ),
                            TextButton(
                              onPressed: null,
                              child: Text("Commandes Livrées [Terminées]"),
                            ),
                            TextButton(
                              onPressed: null,
                              child: Text("Commandes Annulées [Rejetées]"),
                            ),
                            TextButton(
                              onPressed: null,
                              child: Text("Gestion des utilisateurs"),
                            ),
                            Text("-----------------------------"),
                            TextButton(
                              onPressed: null,
                              child: Text("Mes Articles Floor"),
                            ),
                            TextButton(
                              onPressed: null,
                              child: Text("Mes cotisations"),
                            ),
                            TextButton(
                              onPressed: null,
                              child: Text("Mes commandes"),
                            ),
                            Text("-----------------------------"),
                            TextButton(
                              onPressed: () {
                                confirmationMessage(
                                  context,
                                  "Confirmez vous la déconnexion",
                                  () => _logOut(),
                                );
                              },
                              child: Text(
                                "Déconnexion",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: secondColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ));
  }

  _logOut() async {
    setState(() {
      loading = true;
    });

    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('uid', '');
    pref.setBool('connected', false);
    auth.signOut();
    Navigator.pushNamed(context, Connexion.id);
    setState(() {
      loading = false;
    });
  }

  filInForm() {
    setState(() {
      nameController.text = name;
      phoneController.text = phone;
      cityController.text = city;
      countryController.text = country;
      adresseController.text = adresse;
    });
  }

  updateAction() async {
    if ((nameController.text != "") &&
        (phoneController.text != "") &&
        (cityController.text != "") &&
        (countryController.text != "") &&
        (nameController.text != "") &&
        (adresseController.text != "")) {
      var currentUser = auth.currentUser;
      if (currentUser != null) {
        var updateUser =
            await _firestore.collection('user').doc(storeUid).update({
          'name': nameController.text,
          'phone': phoneController.text,
          'city': cityController.text,
          'country': countryController.text,
          'adresse': adresseController.text,
        }).then(
          (value) {
            _getCurrentUserInfo();
            informationMessage(
                context,
                "Vos informations ont été modifiées avec succès !",
                true,
                PanaraDialogType.success);
          },
        ).catchError((error) {
          informationMessage(
              context,
              "Echec de la modification des vos données ! $error id $id",
              false,
              PanaraDialogType.error);
        });
      }
    } else {
      informationMessage(
          context,
          "Vous devez renseigner tous les champs de saisie",
          false,
          PanaraDialogType.normal);
    }
  }

  updateUserForm() {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            MyTextField(
              controller: nameController,
              hintText: "Nom et Prénoms",
              obscureText: false,
              textInputType: TextInputType.name,
              validator: (value) {},
              onSaved: (value) {
                nameController.text = value;
              },
            ),
            MyTextField(
              controller: phoneController,
              hintText: "Numéro de téléphone",
              obscureText: false,
              textInputType: TextInputType.number,
              validator: (value) {},
              onSaved: (value) {
                nameController.text = value;
              },
            ),
            MyTextField(
              controller: cityController,
              hintText: "Ville",
              obscureText: false,
              textInputType: TextInputType.text,
              validator: (value) {},
              onSaved: (value) {
                cityController.text = value;
              },
            ),
            MyTextField(
              controller: countryController,
              hintText: "Pays",
              obscureText: false,
              textInputType: TextInputType.text,
              validator: (value) {},
              onSaved: (value) {
                countryController.text = value;
              },
            ),
            MyTextField(
              controller: adresseController,
              hintText: "Adresse Geographique",
              obscureText: false,
              textInputType: TextInputType.text,
              validator: (value) {},
              onSaved: (value) {
                adresseController.text = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}

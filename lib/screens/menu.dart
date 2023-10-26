import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otherwise/components/constants.dart';
import 'package:otherwise/components/loading.dart';
import 'package:otherwise/components/textField.dart';
import 'package:otherwise/screens/connexion.dart';
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

  String userId = "";
  String? userEmail = "hermann@gmail.com";
  String userName = "Hermann KIFFOU";
  bool isAdmin = false;
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
            userName = user.data()['name'];
            userId = user.data()['id'];
            userEmail = user.data()['email'];
            isAdmin = user.data()['admin'];
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
      print(currentUser.uid);
      print(currentUser.email);
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
                                        isAdmin ? Text("ADMIN") : Text('USER'),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                              showDialog(context: context, builder: (BuildContext (context){}))
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
                                    Text("NOM : $userName"),
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
                                    Text("EMAIL : $userEmail"),
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
                      height: MediaQuery.of(context).size.height / 1.4,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        children: [
                          Text("MES OPTIONS"),
                          Text("--------------------------------------------"),
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
                                "Confirmez vous l",
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

  Widget updateUserForm() {
    return Container(
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
            controller: cityController,
            hintText: "Entre ",
            obscureText: false,
            textInputType: TextInputType.name,
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
    );
  }
}

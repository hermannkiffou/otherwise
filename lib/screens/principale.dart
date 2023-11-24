import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otherwise/components/constants.dart';
import 'package:otherwise/components/loading.dart';
import 'package:otherwise/screens/menu.dart';
import 'package:otherwise/screens/shop.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Principale extends StatefulWidget {
  static const String id = "pricinpale";

  @override
  State<Principale> createState() => _PrincipaleState();
}

class _PrincipaleState extends State<Principale> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String uid = "";
  String message = "";
  String userId = "";
  String? userEmail = "hermann@gmail.com";
  String userName = "Hermann KIFFOU";
  bool isAdmin = false;
  bool loading = false;
  int index = 0;
  String avatar = "";

  authState() {
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print("Utilisateur déconnecté !");
      } else {
        print("Utilisateur connecté !");
      }
    });
  }

  _logOut() async {
    setState(() {
      loading = true;
    });

    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('uid', '');
    pref.setBool('connected', false);
    setState(() {
      loading = false;
    });
  }

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
      index = 0;
    });
    // getUser();
    authState();
    _getCurrentUserInfo();
    setState(() {
      loading = false;
    });
    print('Bonjour');
    print("$userName");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: mainColor,
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: avatar != ""
                ? const Text('Avatar')
                : Image.asset(
                    'assets/avatar.png',
                  ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                setState(() {
                  index = 3;
                });
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.menu,
                  size: 40,
                ),
              ),
            )
          ],
          title: loading
              ? Loading(size: 30, color: Colors.white)
              : index == 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Bienvenue !",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          userName,
                          style: TextStyle(fontSize: 19),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          isDense: true,
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          hintText: "Rechercher",
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                            borderSide: BorderSide(
                              color: secondColor,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    )),
      body: loading
          ? Center(child: Loading(size: 50, color: mainColor))
          : index == 0
              ? SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 20),
                        child: Container(
                          color: mainColor,
                          height: MediaQuery.of(context).size.height / 3,
                          child: Image.asset("assets/principale1.png"),
                        ),
                      ),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            decoration: BoxDecoration(),
                            child: Image.asset("assets/principale2.png"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 110,
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "SERVICE FLOOR",
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: secondColor,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      "Vendez vos vieux livres et romans. Acheter des livres de seconde main à moindre coût.",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            decoration: BoxDecoration(),
                            child: Image.asset("assets/principale3.png"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "VACANCES ANTICIPEES",
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: secondColor,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      "Programmer l'achat de vos fournitures scolaires dans le temps.",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : index == 1
                  ? const Shop()
                  : const Menu(),
      bottomNavigationBar: SizedBox(
        height: 90,
        child: BottomNavigationBar(
          onTap: _selectOption,
          currentIndex: index,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          unselectedFontSize: 20,
          unselectedItemColor: Colors.black,
          unselectedIconTheme: const IconThemeData(
            size: 30,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          selectedIconTheme: const IconThemeData(
            size: 40,
            color: secondColor,
          ),
          elevation: 5.0,
          selectedFontSize: 20,
          iconSize: 40,
          selectedItemColor: secondColor,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Shop',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Menu',
            ),
          ],
        ),
      ),
    );
  }

  void _selectOption(int value) {
    setState(() {
      index = value;
    });
    print("index est à $index");
  }
}

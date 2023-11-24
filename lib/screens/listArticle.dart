import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:otherwise/components/constants.dart';
import 'package:otherwise/components/loading.dart';
import 'package:otherwise/components/textField.dart';
import 'package:otherwise/main.dart';
import 'package:otherwise/screens/loginStart.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class ArticleList extends StatefulWidget {
  static const String id = "articleList";

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController libelleController = TextEditingController();
  TextEditingController prixUnitaireController = TextEditingController();
  TextEditingController quantiteController = TextEditingController();

  String libelle = "";
  int prixUnitaire = 0;
  int quantite = 0;
  String image = "";
  bool loading = false;
  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (error) {
      setState(() {
        _error = true;
      });
    }
  }

  List<Widget> mesArticles = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return Center(
        child: Loading(
          size: 60,
          color: mainColor,
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
        child: const Text("Retour"),
        onTap: () => Navigator.pop(context),
      )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('article').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(
                      "Echec de l'affichage des données ! Code erreur : ${snapshot.error.toString()}");
                }

                if (!snapshot.hasData) {
                  Center(
                    child: Loading(size: 50, color: mainColor),
                  );
                }

                QuerySnapshot data = snapshot.requireData;
                return Expanded(
                  child: ListView.builder(
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        Map item = data.docs[index].data() as Map;
                        return Card(
                          child: ListTile(
                            leading: Icon(Icons.article),
                            title: Text(
                              item['libelle'],
                            ),
                            subtitle: Text("Prix unitaire : ${item['prix']}"),
                          ),
                        );
                      }),
                );
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          libelleController.clear();
          prixUnitaireController.clear();
          quantiteController.clear();
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Ajouez des Articles !"),
                  content: addArticleForm(),
                  actions: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Annuler"),
                    ),
                    loading
                        ? Loading(
                            color: secondColor,
                            size: 40,
                          )
                        : ElevatedButton(
                            onPressed: () {
                              setState(() {
                                loading = true;
                              });
                              addArticleFinale();
                              setState(() {
                                loading = false;
                              });
                            },
                            child: const Text("Ajouter"),
                          ),
                  ],
                );
              });
        },
        label: const Text("Ajouter un article"),
      ),
    );
  }

  getAllArticle() async {
    var storedArticle =
        await _firestore.collection('article').get().then((articles) {
      for (final article in articles.docs) {
        print(article.data());
      }
    });
  }

  addArticle() async {
    libelle = libelleController.text;
    prixUnitaire = int.tryParse(prixUnitaireController.text)!;
    quantite = int.tryParse(quantiteController.text)!;
    print("$prixUnitaire ! prix unitaire");
    print('MESSAGE 1');
    image = "Lien Image";
    if ((libelle != "") &&
        (prixUnitaire != 0) &&
        (quantite != 0) &&
        (image != "")) {
      var article = await _firestore.collection("article").add({
        'libelle': libelle, // John Doe
        'prix': prixUnitaire, // Stokes and Sons
        'quantité': quantite,
        'image': image,
      }).then(
        (value) {
          informationMessage(context, "Article Ajouté avec succès !", true,
              PanaraDialogType.success, () => Navigator.pop(context));
        },
      ).catchError((error) {
        informationMessage(
          context,
          "Echec de l'ajout de l'article. Veuillez reessayer plus tard !",
          false,
          PanaraDialogType.error,
          () => Navigator.pop(context),
        );
      });
    } else {
      PanaraInfoDialog.show(
        context,
        title: "Otherwise",
        message: "Vous devez renseigner tous les champs de saisie !",
        buttonText: "Fermer",
        onTapDismiss: () {
          Navigator.pop(context);
        },
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: false,
      );
    }
  }

  addArticleFinale() async {
    if ((libelleController.text.isEmpty) ||
        (prixUnitaireController.text.isEmpty) ||
        (quantiteController.text.isEmpty)) {
      PanaraInfoDialog.show(
        context,
        title: "Otherwise",
        message: "Vous devez renseigner tous les champs de saisie :",
        buttonText: "Fermer",
        onTapDismiss: () {
          Navigator.pop(context);
        },
        panaraDialogType: PanaraDialogType.warning,
        barrierDismissible: false,
      );
    } else {
      var article = await _firestore.collection("article").add({
        'libelle': libelle, // John Doe
        'prix': prixUnitaire, // Stokes and Sons
        'quantité': quantite,
        'image': image,
      }).then(
        (value) {
          setState(() {
            getAllArticle();
          });
          PanaraInfoDialog.show(
            context,
            title: "Otherwise",
            message: "Article ajouté avec succès.",
            buttonText: "Fermer",
            onTapDismiss: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            panaraDialogType: PanaraDialogType.success,
            barrierDismissible: false,
          );
        },
      ).catchError((error) {
        PanaraInfoDialog.show(
          context,
          title: "Otherwise",
          message:
              "Il y a eu une erreur dans votre demande; Reéssayez plus tard !",
          buttonText: "Fermer",
          onTapDismiss: () {
            Navigator.pop(context);
          },
          panaraDialogType: PanaraDialogType.warning,
          barrierDismissible: false,
        );
      });
    }
  }

  addArticleForm() {
    return Container(
      height: MediaQuery.of(context).size.height / 2.2,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            MyTextField(
              controller: libelleController,
              hintText: "libellé",
              obscureText: false,
              textInputType: TextInputType.name,
              validator: (value) {
                if (value.isEmpty) {
                  return "Vous devez rensigner le libellé";
                }
              },
              onSaved: (value) {
                libelleController.text = value;
              },
            ),
            MyTextField(
              controller: prixUnitaireController,
              hintText: "Prix unitaire",
              obscureText: false,
              textInputType: TextInputType.number,
              validator: (value) {},
              onSaved: (value) {
                prixUnitaireController.text = value;
              },
            ),
            MyTextField(
              controller: quantiteController,
              hintText: "Quantité",
              obscureText: false,
              textInputType: TextInputType.number,
              validator: (value) {},
              onSaved: (value) {
                quantiteController.text = value;
              },
            ),
            const Icon(Icons.add_a_photo),
            Container(
              color: Colors.grey[350],
              height: 150,
              width: MediaQuery.of(context).size.width / 1.5,
              child: Image.asset(
                "assets/imgBook.png",
              ),
            )
          ],
        ),
      ),
    );
  }
}

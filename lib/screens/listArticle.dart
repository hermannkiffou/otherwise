import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otherwise/components/constants.dart';
import 'package:otherwise/components/loading.dart';
import 'package:otherwise/components/textField.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class ArticleList extends StatefulWidget {
  static const String id = "articleList";

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController libelleController = TextEditingController();
  TextEditingController prixUnitaireController = TextEditingController();
  TextEditingController quantiteController = TextEditingController();

  String libelle = "";
  int? prixUnitaire = 0;
  int? quantite = 0;
  String image = "";
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text("Afficher List Article"),
          ),
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Retour"),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Ajouez des Articles !"),
                  content: addArticleForm(),
                  actions: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Annuler"),
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
                              addArticle();
                              setState(() {
                                loading = false;
                              });
                            },
                            child: Text("Ajouter"),
                          ),
                  ],
                );
              });
        },
        label: Text("Ajouter un article"),
      ),
    );
  }

  addArticle() async {
    libelle = libelleController.text;
    prixUnitaire = int.tryParse(prixUnitaireController.text);
    quantite = int.tryParse(quantiteController.text);
    image = "Lien Image";
    if (!(libelle != "") &&
        (prixUnitaire != null) &&
        (quantite != null) &&
        (image != "")) {
      var article = await _firestore.collection("article").add({
        'libelle': libelle, // John Doe
        'prix': prixUnitaire, // Stokes and Sons
        'quantité': quantite,
        'image': image,
      }).then(
        (value) {
          informationMessage(context, "Article Ajouté avec succès !", true,
              PanaraDialogType.success);
        },
      ).catchError((error) {
        informationMessage(
          context,
          "Echec de l'ajout de l'article. Veuillez reessayer plus tard !",
          false,
          PanaraDialogType.error,
        );
      });
    } else {
      informationMessage(
        context,
        "Vous devez renseigner tous les champs de saisie.",
        false,
        PanaraDialogType.warning,
        () => Navigator.pop(context),
      );
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
              validator: (value) {},
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
            Icon(Icons.add_a_photo),
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

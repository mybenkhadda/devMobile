import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:matjar/models/utilisateur.dart';
import 'package:matjar/repositories/user.dart';
import 'package:matjar/screens/activitesList.dart';

class Enrregistrer extends StatefulWidget {
  @override
  State<Enrregistrer> createState() => _EnrregistrerState();
}

class _EnrregistrerState extends State<Enrregistrer> {

  var _loginController = TextEditingController();
  var _mailController = TextEditingController();
  var _phoneController = TextEditingController();
  var _passwordController = TextEditingController();
  var _cityController = TextEditingController();
  var _adressesController = TextEditingController();
  var _codePostalController = TextEditingController();
  var _imageController = TextEditingController();

  var user;
  var valueDate;
  var docid;
  var _date = "Anniversaire";

  getUser() async {
    var uid =FirebaseAuth.instance.currentUser!.uid;
    final _db = FirebaseFirestore.instance.collection("users").where("id", isEqualTo:uid);
    final QuerySnapshot querySnapshot = await _db.get();
    for (var doc in querySnapshot.docs) {
        user = doc.data();
        docid = doc.id.toString();
        valueDate = DateTime.fromMillisecondsSinceEpoch(user["dateDeNaissance"].seconds * 1000);
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.check,
            ),
            color: Color(0xFF589BF7),
            onPressed: () {
              FirebaseAuth.instance.createUserWithEmailAndPassword(email: _mailController.value.text, password: _passwordController.value.text);
              FirebaseAuth.instance.signInWithEmailAndPassword(email: _mailController.value.text, password: _passwordController.value.text);
              var u = Utilisateur(
                id: FirebaseAuth.instance.currentUser!.uid,
                name: _loginController.value.text,
                email: _mailController.value.text,
                phone: _phoneController.value.text,
                city: _cityController.value.text,
                image: _imageController.value.text,
                adresse: _adressesController.value.text,
                codePostal: _codePostalController.value.text,
                dateDeNaissance: valueDate,
                panier: [],
                favorites: [],
                activities: []
              );
              UserRepository().createUser(u);
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ActListPage()),
              );
            }
          )
        ],
        leading: BackButton(
          color: Color(0xFF589BF7),
        ),
        title: Text('Creer un profil'
        ,
            style: TextStyle(
              color: Color(0xFF589BF7),
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: FutureBuilder(
        future: getUser(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Container(
                child: Form(
            child: Center(
              child: Container(
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 12, 0, 10),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )
                      )
                    ),
                    TextFormField(
                      controller: _loginController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),                        
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Color(0xFF0057B9)),
                        ),

                      )
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 12, 0, 10),
                      child: Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )
                      )
                    ),
                    TextFormField(
                      controller: _mailController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),                        
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Color(0xFF0057B9)),
                        ),

                      )
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 12, 0, 10),
                      child: Text(
                        "Telephone",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )
                      )
                    ),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),                        
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Color(0xFF0057B9)),
                        ),

                      )
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 12, 0, 10),
                      child: Text(
                        "Mot de passe",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )
                      )
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),                        
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Color(0xFF0057B9)),
                        ),
                        labelText: "***********",
                        floatingLabelBehavior: FloatingLabelBehavior.never,

                      )
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 12, 0, 10),
                      child: Text(
                        "Lien d'image",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )
                      )
                    ),
                    TextFormField(
                      controller: _imageController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),                        
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Color(0xFF0057B9)),
                        ),

                      )
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 12, 0, 10),
                      child: Text(
                        "Ville",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )
                      )
                    ),
                    TextFormField(
                      controller: _cityController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),                        
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Color(0xFF0057B9)),
                        ),

                      )
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 12, 0, 10),
                      child: Text(
                        "Anniversaire",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )
                      )
                    ),
                    Center(
                      child: Container(
                            width: 200,
                            child: ElevatedButton(
                                              child: Text(_date),
                                              onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1960),
                              lastDate: DateTime.now(),
                            ).then((value) {
                              setState(() {
                                _date = "${value!.day} - ${value!.month} - ${value!.year}";
                                valueDate = value;
                              });
                            });
                                              }
                                            ),
                          ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 12, 0, 10),
                      child: Text(
                        "Adresse",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )
                      )
                    ),
                    new TextField(
                      controller: _adressesController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Color(0xFF0057B9)),
                        ),
                      ),
                      ),
                      Container(
                      margin: EdgeInsets.fromLTRB(10, 12, 0, 10),
                      child: Text(
                        "Code Postal",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )
                      )
                    ),
                    new TextField(
                      controller: _codePostalController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Color(0xFF0057B9)),
                        ),
                      ),
                      ),
                  ]
                ),
              ),
            ),
          )
              );
            }
          );
        }
      ),
    );
  }
}
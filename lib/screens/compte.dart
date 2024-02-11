// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:matjar/models/utilisateur.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dartx/dartx.dart';
import 'package:matjar/repositories/user.dart';
import 'package:matjar/screens/activitesList.dart';
import 'package:matjar/screens/addActivity.dart';
import 'package:matjar/screens/login_page.dart';
import 'package:matjar/screens/panier.dart';

class Compte extends StatefulWidget {
  const Compte({super.key});

  @override
  State<Compte> createState() => _CompteState();
}

class _CompteState extends State<Compte> {

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
      print(uid);
  }

  @override
  Widget build(BuildContext context) {
    // var u = Utilisateur(
    //   id: FirebaseAuth.instance.currentUser!.uid.toString(),
    //   email: FirebaseAuth.instance.currentUser!.email.toString(),
    //   name: "admin",
    //   city: "Marrakech",
    //   image: "https://cdn-icons-png.flaticon.com/512/149/149071.png",
    //   phone: "0654354353",
    //   activities: [],
    //   panier: [],
    //   favorites: [],
    // );

    // var ur = UserRepository();

    // ur.createUser(u);

    var _passwordController = TextEditingController();
    var _cityController = TextEditingController();
    var _adressesController = TextEditingController();
    var _codePostalController = TextEditingController();
    var _selectedTab = 2;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Color(0xFF589BF7),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            color: Color(0xFF589BF7),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddActivity()),
              );
            }
          ),
          IconButton(
            icon: Icon(
              Icons.check,
              color: Color(0xFF589BF7),
            ), onPressed: () { 
              if (_cityController.text.length > 0) {
                FirebaseFirestore.instance.collection("users").doc("${docid}").update(
                  {
                    "city": _cityController.value.text
                  }
                );
              }
              if (_adressesController.text.length > 0) {
                FirebaseFirestore.instance.collection("users").doc("${docid}").update(
                  {
                    "adresse": _adressesController.value.text
                  }
                );
              }
              if (_codePostalController.text.length > 0) {
                FirebaseFirestore.instance.collection("users").doc("${docid}").update(
                  {
                    "codePostal": _codePostalController.value.text
                  }
                );
              }
              if (valueDate != null) {
                FirebaseFirestore.instance.collection("users").doc("${docid}").update(
                  {
                    "dateDeNaissance": valueDate
                  }
                );
              }
              if (_passwordController.text.length > 0) {
                FirebaseAuth.instance.currentUser!.updatePassword(
                  _passwordController.value.text
                );
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
                FirebaseAuth.instance.signOut();
              }
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ActListPage()),
              );
             },
          ),
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Color(0xFF589BF7),
            ), onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            }
            )
        ],
        title: Text('Mon Profil'
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
                    Center(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 12, 0, 10),
                        child: Image.network(
                          user["image"].toString(),
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
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
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 12, 0, 10),
                      child: Text(
                        "${user["name"]}",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,

                        )
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
                        labelText: "${user["city"]}",
                        floatingLabelBehavior: FloatingLabelBehavior.never,

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
                        labelText: "${user["adresse"]}",
                        floatingLabelBehavior: FloatingLabelBehavior.never,
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
                        labelText: "${user["codePostal"]}",
                        floatingLabelBehavior: FloatingLabelBehavior.never,
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
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTab,
          onTap: (i) => setState((){
            if(i == 0){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ActListPage()));
            }
            if(i == 1){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Panier()));
            }
            if(i == 2){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Compte()));
            }
          }
          ),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Activités',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Panier',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
            )
          ],

          selectedItemColor: Color(0xFF589BF7),
          unselectedItemColor: Colors.grey,
        )
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dartx/dartx.dart';
import 'package:matjar/models/activity.dart';
import 'package:matjar/models/utilisateur.dart';
import 'package:matjar/screens/activitesList.dart';
import 'package:matjar/screens/activityDetail.dart';
import 'package:matjar/screens/compte.dart';
import 'package:matjar/widgets/shoppingCartCard.dart';

class Panier extends StatefulWidget {
  const Panier({super.key});

  @override
  State<Panier> createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  var user;
  var panier = [];
  var total;
  var docid;

  getPanier() async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    final _db = FirebaseFirestore.instance
        .collection("users")
        .where("id", isEqualTo: uid);
    final QuerySnapshot querySnapshot = await _db.get();
    for (var doc in querySnapshot.docs) {
      user = doc.data();
      docid = doc.id.toString();
      panier = user["panier"];
      total = 0.0;
      for (var i = 0; i < panier.length; i++) {
        total += panier[i]["price"];
      }
      setState(() {
        total = total;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var _selectedTab = 1;
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Color(0xFF589BF7),
          ),
          title: Text('Panier',
              style: TextStyle(
                  color: Color(0xFF589BF7),
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        body: Container(
          child: FutureBuilder(
                  future: getPanier(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                        itemCount: panier.length,
                        itemBuilder: (context, index) {
                          var activity = Activity.fromJson(panier[index]);
                          return Card(
                                elevation: 3,
                                margin: EdgeInsets.all(8),
                                color: Colors.white, // Default card color
                                child: ListTile(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => MaterialApp(
                                        home: ActivityDetail(
                                          activity: activity.toJson(),
                                        ),
                                      ),
                                    ));
                                  },
                                  contentPadding: EdgeInsets.all(16),
                                  leading: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(activity.pathImage),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  title: Text(
                                    activity.titre,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black, // Default text color
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '\$${activity.price.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          color: Color(0xFF589BF7), // Price color
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        '${activity.lieu}, ${activity.date.day}/${activity.date.month}/${activity.date.year}',
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    color: Colors.red,
                                    onPressed: () {
                                      panier.remove(
                                        panier[index],
                                      );
                                      FirebaseFirestore.instance.collection("users").doc("${docid}").update(
                                        {
                                          "panier": panier
                                        }
                                      );
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => Panier(),
                                        )
                                      );
                                    },
                                  ),
                                ),
                              );
                        });
                  }),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Color(0xFF589BF7),
          onPressed: () {
          }
          , label: Text(
            "Total : \$${total.toString()}",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTab,
          onTap: (i) => setState(() {
            if (i == 0) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ActListPage()));
            }
            if (i == 1) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Panier()));
            }
            if (i == 2) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Compte()));
            }
            // Navigator.push(context, MaterialPageRoute(builder: (context) => ActListPage()));
          }),
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
        ));
  }
}

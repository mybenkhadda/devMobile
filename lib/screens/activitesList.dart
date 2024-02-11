import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:matjar/models/activity.dart';
import 'package:matjar/repositories/activity.dart';
import 'package:matjar/screens/addActivity.dart';
import 'package:matjar/screens/compte.dart';
import 'package:matjar/screens/login_page.dart';
import 'package:matjar/screens/activityDetail.dart';
import 'package:matjar/screens/panier.dart';
import 'package:matjar/widgets/shoppingCartCard.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:matjar/widgets/small_activity_card.dart';

class ActListPage extends StatefulWidget {
  const ActListPage({super.key});

  User getUser() {
    return FirebaseAuth.instance.currentUser!;
  }

  @override
  State<ActListPage> createState() => _ActListPageState();
}

class _ActListPageState extends State<ActListPage> {

  var chosenTab = "Tous";
  var activities;

  @override
  Widget build(BuildContext context) {
    var user = widget.getUser();
    var tabs = ["Tous"];
    if (user == null) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ActListPage(),
      ));
    }
    ActivityRepository ar = ActivityRepository();

    getActivities(param) async {
      print(param);
      activities = [];
      final _db = FirebaseFirestore.instance.collection("activities");
      var querySnapshot;
      if (param != "Nothing"){
        if (param == "Tous" || param == null) {
        querySnapshot = await _db.get();
      }else{
        querySnapshot = await _db.where("categorie", isEqualTo: param).get();
      }
      for (var doc in querySnapshot.docs) {
          var data = doc.data();
          data["date"] = data["date"].toDate();
          data["price"] = data["price"].toDouble();
          var a = Activity(titre: data["titre"], pathImage: data["pathImage"], price: data["price"], lieu: data["lieu"], personCount: data["personCount"], date: data["date"], description: data["description"], nameOfUser: data["nameOfUser"], categorie: data["categorie"]);
          activities.add(a);
          if (!tabs.contains(data["categorie"])){
            tabs.add(data["categorie"]);
          }
        }
      }else{
        querySnapshot = await _db.get();
      }
    }
    var _selectedTab = 0;
    activities = [];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          leading: BackButton(
            color: Color(0xFF589BF7),
          ),
          title: const Text('MoveIt',
              style: TextStyle(
                  color: Color(0xFF589BF7),
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          actions: [
            IconButton(
              icon: Icon(
                Icons.add,
                color: Color(0xFF589BF7),
              ), onPressed: () { 
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddActivity(),
                ));
               },
            )
          ],
              )
        ,
        body: Container(
          height: double.infinity,
          child: ListView(scrollDirection: Axis.vertical, children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
              padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: Text('Activités',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
            width: double.maxFinite,
            child: FutureBuilder(
              future: getActivities(chosenTab),
              builder: (context, snapshot) {
                return SizedBox(
                  width: 500,
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: tabs.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.fromLTRB(2, 5, 2, 5),
                        child: ElevatedButton(
                           child: Text(tabs[index],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            )),
                          onPressed: () {
                            setState(() {
                              chosenTab = tabs[index];
                              activities = [];
                            });

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF589BF7),
                            foregroundColor: Color(0xFFFFFFFF),
                            shadowColor: Color(0xFF589BF7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          )
                        )
                      );
                    }
                  ),
                );
              }
            ),
          ),
          Container(
            child: FutureBuilder(future: getActivities("Nothing"), 
                    builder: (context, snapshot) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: activities.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: SmallActivityCard(activityJson: activities[index],
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MaterialApp(
                                  home: ActivityDetail(
                                    activity: activities[index].toJson(),
                                  ),
                                ),
                              ));
                            }

                            );
                        },
                      );
                    }
                    ),
          )
          ]),
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
        ));
  }
}

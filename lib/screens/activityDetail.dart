import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:matjar/models/activity.dart';
import 'package:flutter/material.dart';
import 'package:matjar/screens/activitesList.dart';
import 'package:matjar/screens/panier.dart';

class ActivityDetail extends StatefulWidget {
  final activity;

  ActivityDetail({required this.activity});

  @override
  State<ActivityDetail> createState() => _ActivityDetailState();
}

class _ActivityDetailState extends State<ActivityDetail> {

  var user;
  var panier;
  var favs;
  var docid;

  getPanier() async {
    var uid =FirebaseAuth.instance.currentUser!.uid;
    final _db = FirebaseFirestore.instance.collection("users").where("id", isEqualTo:uid);
    final QuerySnapshot querySnapshot = await _db.get();
    for (var doc in querySnapshot.docs) {
        user = doc.data();
        docid = doc.id.toString();
        panier = user["panier"];
        favs = user["Favorites"];
      }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.activity["date"]);
    Activity activity = Activity(
      titre: widget.activity["titre"],
      pathImage: widget.activity["pathImage"],
      price: widget.activity["price"],
      lieu: widget.activity["lieu"],
      personCount: widget.activity["personCount"],
      date: widget.activity["date"],
      description: widget.activity["description"],
      nameOfUser: widget.activity["nameOfUser"],
      categorie: widget.activity["categorie"],
    );
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Color(0xFF589BF7),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return ActListPage();
              },
            )),
          ),
          // centerTitle: true,
          title: Text(activity.titre,
              style: TextStyle(
                color: Color(0xFF589BF7),
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: Colors.transparent,
          // centerTitle: true,
          elevation: 0.0,
          actions: [

          ]
        ),
        body: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  child: Image.network(
                activity.pathImage,
                width: double.maxFinite,
                height: 350,
                fit: BoxFit.cover,
              )),
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 0, 10),
                child: Row(
                  children: [
                    Container(
                        child: Text(activity.titre,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 28,
                            ))),
                    Container(
                        margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Icon(
                          Icons.tag,
                          color: Color(0xFF589BF7),
                          size: 20,
                        )
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Text(
                          activity.categorie,
                        )
                    )
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  width: 100,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            child: Row(
                          children: [
                            Icon(Icons.location_on,
                                size: 13, color: Color(0xFF589BF7)),
                            Text(
                              activity.lieu,
                              style: TextStyle(fontSize: 13),
                            )
                          ],
                        )),
                        Container(
                            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Row(
                              children: [
                                Icon(Icons.person,
                                    size: 13, color: Color(0xFF589BF7)),
                                Text(
                                  activity.personCount.toString(),
                                  style: TextStyle(fontSize: 13),
                                )
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Row(children: [
                              Icon(Icons.monetization_on,
                                  size: 13, color: Color(0xFF589BF7)),
                              Text(
                                activity.price.toString(),
                                style: TextStyle(fontSize: 13),
                              )
                            ])),
                        Container(
                            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Row(children: [
                              Icon(Icons.calendar_today,
                                  size: 13, color: Color(0xFF589BF7)),
                              Text(
                                "${activity.date.day.toString()}/${activity.date.month.toString()}/${activity.date.year.toString()}",
                                style: TextStyle(fontSize: 13),
                              )
                            ])),
                        Container(
                            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Row(children: [
                              Icon(Icons.alarm,
                                  size: 13, color: Color(0xFF589BF7)),
                              Text(
                                "${activity.date.hour.toString()} : ${activity.date.minute.toString()}",
                                style: TextStyle(fontSize: 13),
                              )
                            ])),
                      ])),
              Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Text(activity.description.toString(),
                textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        )),
              ),
              FutureBuilder(
                future: getPanier(),
                builder: (context, snapshot) {
                  return Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: ElevatedButton(
                    child: Container(
                      width: 150,
                      child: Center(
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Text('Ajouter au panier')
                            ),
                            Icon(Icons.add_shopping_cart)
                          ],
                        ),
                      ),
                    ),
                    onPressed: () {
                      panier.add(activity.toJson());
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
                    }
                  )
                )
              );
                }
               ),
              
            ]));
  }
}

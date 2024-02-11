import 'package:dartx/dartx.dart';
import 'package:matjar/models/activity.dart';
import 'package:flutter/material.dart';
import 'package:matjar/screens/activityDetail.dart';
import 'package:matjar/screens/login_page.dart';

class SmallActivityCard extends StatelessWidget {
  final activityJson;
  const SmallActivityCard(
      {required this.activityJson}
      );

  @override
  Widget build(BuildContext context) {
    Activity activity = Activity(
      titre: activityJson.titre,
      pathImage: activityJson.pathImage,
      price: activityJson.price,
      lieu: activityJson.lieu,
      personCount: activityJson.personCount,
      date: activityJson.date,
      description: activityJson.description,
      nameOfUser: activityJson.nameOfUser,
      categorie: activityJson.categorie
    );
    return Container(
      child: Container(
          height: 70,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Image.network(
                  activity.pathImage,
                  width: 120,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                margin: EdgeInsets.fromLTRB(20, 5, 0, 10),
                child: Text(
                  activity.titre,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    
                  )
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0,20, 0),
                child: Row(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 12,
                            color: Color(0xFF589BF7)
                          ),
                          Text(
                            activity.lieu,
                            style: TextStyle(
                              fontSize: 11
                            ),
                          )
                        ],
                      )
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(3, 0, 0, 0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 12,
                            color: Color(0xFF589BF7)
                          ),
                          Text(
                            activity.personCount.toString(),
                            style: TextStyle(
                              fontSize: 11
                            ),
                          )
                        ],
                      )
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(3, 0, 0, 0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.monetization_on,
                            size: 12,
                            color: Color(0xFF589BF7)
                            ),
                          Text(
                            activity.price.toString(),
                            style: TextStyle(
                              fontSize: 11
                            ),
                          )
                        ]
                      )
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(3, 0, 0, 0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 12,
                            color: Color(0xFF589BF7)
                          ),
                          Text(
                            "${activity.date.day.toString()}/${activity.date.month.toString()}",
                            style: TextStyle(
                              fontSize: 11
                            ),
                          )
                        ]
                      )
                    )
                  ]
                ),
              )
                  ],
                )
              )
            ]
          )
        ),
    );
  }
}

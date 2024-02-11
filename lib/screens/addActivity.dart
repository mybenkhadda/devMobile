import 'package:dartx/dartx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:matjar/models/activity.dart';
import 'package:matjar/screens/activitesList.dart';
import 'activityDetail.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:matjar/repositories/activity.dart';


class AddActivity extends StatefulWidget {
  
  @override
  State<AddActivity> createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  var _formKey;
  var _titleController = TextEditingController();
  var _categorieController = TextEditingController();
  var _personController = TextEditingController();
  var _priceController = TextEditingController();
  var _locationController = TextEditingController();
  var _imageController = TextEditingController();
  var _descriptionController = TextEditingController();
  var _time = "Heure";
  var _date = "Date";
  var valueDate;
  var valueTime;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Color(0xFF589BF7),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.check,
              color: Color(0xFF589BF7),
            ), onPressed: () { 
              var dt = DateTime(valueDate.year, valueDate.month, valueDate.day, valueTime.hour, valueTime.minute, 0);
              Activity a = Activity(titre: _titleController.value.text, pathImage: _imageController.value.text, price: _priceController.text.toDouble(), lieu: _locationController.value.text, personCount: _personController.text.toInt(), date: dt, description: _descriptionController.value.text, nameOfUser: FirebaseAuth.instance.currentUser?.uid.toString(), categorie: _categorieController.value.text);
              ActivityRepository().createActivity(a);
             Navigator.of(context).push(
               MaterialPageRoute(builder: (context) => ActListPage()),
             );
             },
          )
        ],
        title: Text('Ajouter'
        ,
            style: TextStyle(
              color: Color(0xFF589BF7),
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: ListView(
        children: [Container(
          child: Form(
            key: _formKey,
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
                        "Titre",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )
                      )
                    ),
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Color(0xFF0057B9)),
                        )
                        // labelText: 'Titre',
                      )
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 12, 0, 10),
                      child: Text(
                        "Categorie",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )
                      )
                    ),
                    TextFormField(
                      controller: _categorieController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Color(0xFF0057B9)),
                        )
                        // labelText: 'Titre',
                      )
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 12, 0, 10),
                      child: Text(
                        "Nombre des personnes",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )
                      )
                    ),
                    new TextField(
                      controller: _personController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Color(0xFF0057B9)),
                        )
                        // labelText: 'Titre',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ], // Only numbers can be entered
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 12, 0, 10),
                      child: Text(
                        "Prix",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )
                      )
                    ),
                    new TextField(
                      controller: _priceController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Color(0xFF0057B9)),
                        )
                        // labelText: 'Titre',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ], // Only numbers can be entered
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 12, 0, 10),
                      child: Text(
                        "Lieu",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )
                      )
                    ),
                    TextFormField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Color(0xFF0057B9)),
                        )
                      )
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 12, 0, 10),
                      child: Text(
                        "Date et heure",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )
                      )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 120,
                          child: ElevatedButton(
                                            child: Text('$_date'),
                                            onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2030),
                          ).then((value) {
                            setState(() {
                              valueDate = value;
                              _date = "${value!.day} - ${value!.month} - ${value!.year}";
                            });
                          });
                                            }
                                          ),
                        ),
                    Container(
                      width: 120,
                      child: ElevatedButton(
                        onPressed: () {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                        
                          ).then((value) {
                            setState(() {
                              valueTime = value;
                              _time = "${value!.hour} : ${value!.minute}";
                            });
                          }
                          );
                        },
                        child: Text('$_time')
                      ),
                    )
                      ]
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
                        )
                      )
                    ),
                    Container(
                    margin: EdgeInsets.fromLTRB(10, 12, 0, 10),
                    child: Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )
                    )
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: TextFormField(
                      maxLines: 20,
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Color(0xFF0057B9)),
                        )
                        // labelText: 'Titre',
                      )
                    ),
                  ),
                  ]
                ),
              ),
            ),
          ),
        )]
      ),
    );
  }
  
}


// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartx/dartx.dart';
import 'package:matjar/models/activity.dart';

class ActivityRepository{
  ActivityRepository();
  final _db = FirebaseFirestore.instance.collection("activities");
  createActivity(Activity a) {
    _db.add(a.toJson());
  }
}
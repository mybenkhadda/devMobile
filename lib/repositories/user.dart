import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartx/dartx.dart';
import 'package:matjar/models/utilisateur.dart';

class UserRepository{
  UserRepository();
  final _db = FirebaseFirestore.instance.collection("users");
  createUser(Utilisateur  u) {
    _db.add(u.toJson());
  }
}
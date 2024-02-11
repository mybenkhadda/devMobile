import 'package:matjar/models/activity.dart';

class Utilisateur {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String city;
  final String image;
  final String adresse;
  final String codePostal;
  final DateTime dateDeNaissance;
  List<Activity> activities = [];
  List<Activity> panier = [];
  List<Activity> favorites = [];
  
  Utilisateur({
    required this.id,
    required this.name,
    required this.email,
    required this.city,
    required this.image,
    required this.phone, 
    required this.panier, 
    required this.favorites, //
    required this.activities,
    required this.dateDeNaissance,
    required this.adresse,
    required this.codePostal
  });  

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      city: json['city'],
      image: json['image'],
      phone: json['phone'],
      activities: json['activities'],
      panier: json['panier'],
      favorites: json['favorites'],
      dateDeNaissance: json['dateDeNaissance'].toDate(),
      adresse: json['adresse'],
      codePostal: json['codePostal']
    );
  }

  Map<String, dynamic> toJson() {
    return{
      'id': id,
      'name': name,
      'email': email,
      'city': city,
      'image': image,
      'phone': phone,
      'activities': activities,
      'panier': panier,
      'favorites': favorites,
      'dateDeNaissance': dateDeNaissance,
      'adresse': adresse,
      'codePostal': codePostal
    };
    }
  }
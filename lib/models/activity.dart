// create a new class for actvities in the app
class Activity {
  final String? id;
  final String titre;
  final String pathImage;
  final double price;
  final String lieu;
  final int personCount;
  final DateTime date;
  final String? description;
  final String? nameOfUser;
  final String categorie;

  Activity({
    this.id,
    required this.titre,
    required this.pathImage,
    required this.price,
    required this.lieu,
    required this.personCount,
    required this.date,
    required this.description,
    required this.nameOfUser,
    required this.categorie
  });

  factory Activity.fromJson(json) {
    return Activity(
      titre: json['titre'],
      pathImage: json['pathImage'],
      price: json['price'],
      lieu: json['lieu'],
      personCount: json['personCount'],
      date: json['date'].toDate(),
      description: json['description'],
      nameOfUser: json['nameOfUser'],
      categorie: json['categorie']
    );

  }

  Map<String, dynamic> toJson() {
    return {
      'titre': titre,
      'pathImage': pathImage,
      'price': price,
      'lieu': lieu,
      'personCount': personCount,
      'date': date,
      'description': description,
      'nameOfUser': nameOfUser,
      'categorie': categorie
    };
  }

}
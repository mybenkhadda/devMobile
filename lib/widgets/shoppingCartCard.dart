import 'package:flutter/material.dart';
import 'package:matjar/models/activity.dart';

class ShoppingCartCard extends StatelessWidget {
  final Activity a;

  ShoppingCartCard({
    required this.a,
  });

  @override
  Widget build(BuildContext context) {
    print("\n\n\nDate : ${a.date}\n\n\n");
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(8),
      color: Colors.white, // Default card color
      child: ListTile(
        onTap: () {
          // Handle the tap event, navigate to the activity details page if needed
          // Navigator.of(context).push(MaterialPageRoute(
          //   builder: (context) => MaterialApp(
          //     home: ActivityDetail(
          //       json: activities[index],
          //     ),
          //   ),
          // ));
        },
        contentPadding: EdgeInsets.all(16),
        leading: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(a.pathImage),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        title: Text(
          a.titre,
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
              '\$${a.price.toStringAsFixed(2)}',
              style: TextStyle(
                color: Color(0xFF589BF7), // Price color
                fontSize: 14,
              ),
            ),
            Text(
              '${_formatDate(a.date)}',
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
            
          },
        ),
      ),
    );
  }

  String _formatDate(date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}

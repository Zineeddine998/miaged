import 'package:flutter/material.dart';
import 'package:namer_app/activities_page.dart';
import 'package:namer_app/panier_manager.dart';
import 'package:namer_app/profile_page.dart';

class PanierPage extends StatefulWidget {
  @override
  _PanierPageState createState() => _PanierPageState();
}

class _PanierPageState extends State<PanierPage> {
  PanierManager panierManager = PanierManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Panier'),
      ),
      body: ListView.builder(
        itemCount: panierManager.panier.length,
        itemBuilder: (context, index) {
          final panierItem = panierManager.panier[index];

          return ListTile(
            leading: Image.asset(panierItem.activite.imageURL),
            title: Text(panierItem.activite.titre),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Lieu: ${panierItem.activite.lieu}'),
                Text('Prix: ${panierItem.activite.prix.toString()}'),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                // Retirer l'élément du panier
                setState(() {
                  PanierManager.retirerDuPanier(panierItem);
                });
              },
            ),
          );
        },
      ),
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total: ${PanierManager.calculerTotalPanier()}'),
            ],
          ),
        ),
      ],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Activités'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Panier'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        currentIndex: 1, // Index of the current tab, set it to 1 for PanierPage
        selectedItemColor: Colors.blue, // Color of the selected item
        onTap: (index) {
          // Handle navigation here
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ActivitesPage()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          }
        },
      ),
    );
  }
}

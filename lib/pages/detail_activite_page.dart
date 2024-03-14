// detail_activite_page.dart

import 'package:flutter/material.dart';
import 'package:namer_app/Panier.dart';
import 'package:namer_app/panier_manager.dart';

import 'Activite.dart';

class DetailActivitePage extends StatefulWidget {
  final Activite activite;

  DetailActivitePage(this.activite);

  @override
  _DetailActivitePageState createState() => _DetailActivitePageState();
}

class _DetailActivitePageState extends State<DetailActivitePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détail de l\'activité'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(widget.activite.imageURL),
            SizedBox(height: 16.0),
            Text('Titre: ${widget.activite.titre}', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            Text('Catégorie: ${widget.activite.categorie}', style: TextStyle(fontSize: 16.0)),
            Text('Lieu: ${widget.activite.lieu}', style: TextStyle(fontSize: 16.0)),
            Text('Nombre minimum de personnes: ${widget.activite.nombreMinimumPersonnes}', style: TextStyle(fontSize: 16.0)),
            Text('Prix: ${widget.activite.prix.toString()}', style: TextStyle(fontSize: 16.0)),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                ajouterAuPanier(widget.activite);
                Navigator.pop(context); 
              },
              child: Text('Ajouter au panier'),
            ),
          ],
        ),
      ),
    );
  }

  void ajouterAuPanier(Activite activite) {
    PanierItem panierItem = PanierItem(activite, 1); 
    PanierManager.ajouterAuPanier(panierItem);
  }
}

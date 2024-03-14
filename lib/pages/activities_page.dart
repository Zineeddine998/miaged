// // activites_page.dart

// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:namer_app/main.dart';
// import 'package:namer_app/panier_manager.dart';
// import 'package:namer_app/panier_page.dart';
// import 'package:namer_app/profile_page.dart';

// import 'Activite.dart';
// import 'detail_activite_page.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// Future<void> main() async {
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(ActivitesPage());
// }

// class ActivitesPage extends StatelessWidget {
//   final PanierManager panierManager = PanierManager();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Liste des Activités'),
//       ),
//       body: _buildActivitesList(),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Activités'),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.shopping_cart), label: 'Panier'),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
//         ],
//         currentIndex: 0, // Page Activités est la première
//         selectedItemColor: Colors.blue, // Couleur de l'icône sélectionnée
//         onTap: (index) {
//           // Naviguer vers la page du panier
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => _getPage(index)),
//           );
//           // Gérer la navigation entre les pages ici
//         },
//       ),
//     );
//   }

//   Widget _getPage(int index) {
//     switch (index) {
//       case 0:
//         return ActivitesPage();
//       case 1:
//         return PanierPage();
//       case 2:
//         return ProfilePage();
//       default:
//         return Container();
//     }
//   }

//   Widget _buildActivitesList() {
//     return FutureBuilder<List<Activite>>(
//       future: fetchData(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator(); // Afficher un indicateur de chargement en attendant
//         } else if (snapshot.hasError) {
//           return Text('Erreur : ${snapshot.error}');
//         } else {
//           return ListView.builder(
//             itemCount: snapshot.data?.length,
//             itemBuilder: (context, index) {
//               return _buildActiviteCard(snapshot.data![index], context);
//             },
//           );
//         }
//       },
//     );
//   }

//   Widget _buildActiviteCard(Activite activite, BuildContext context) {
//     return ListTile(
//         leading: Image.asset(
//           activite.imageURL,
//           errorBuilder: (context, error, stackTrace) {
//             return Text('Failed to load image');
//           },
//         ),
//         title: Text(activite.titre),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Lieu: ${activite.lieu}'),
//             Text('Prix: ${activite.prix.toString()}'),
//           ],
//         ),
//         onTap: () {
//           log("vous etes ici");
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => DetailActivitePage(activite)),
//           );
//         });
//   }

//   Future<List<Activite>> fetchData() async {
//     CollectionReference activitesRef =
//         FirebaseFirestore.instance.collection('activites');
//     try {
//       QuerySnapshot querySnapshot = await activitesRef.get();

//       List<Activite> activitesList = querySnapshot.docs.map((doc) {
//         Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//         return Activite(doc.id, data['titre'], data['lieu'], 2,
//             data['imageURL'], data['categorie'], data['quantite']);
//       }).toList();

//       return activitesList;
//     } catch (error) {
//       print("Error fetching data: $error");
//       throw error;
//     }
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/panier_page.dart';
import 'package:namer_app/profile_page.dart';

import 'Activite.dart';
import 'detail_activite_page.dart';

class ActivitesPage extends StatefulWidget {
  @override
  _ActivitesPageState createState() => _ActivitesPageState();
}

class _ActivitesPageState extends State<ActivitesPage> {
  final List<String> categories = ['Toutes', 'Sport', 'Shopping', 'Ludique'];
  List<Activite> activitiesList = [];
  String selectedCategory = 'Toutes';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Liste des Activités'),
          bottom: TabBar(
            tabs: categories.map((category) => Tab(text: category)).toList(),
            onTap: (index) {
              setState(() {
                selectedCategory = categories[index];
              });
            },
          ),
        ),
        body: _buildActivitesList(),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.event), label: 'Activités'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: 'Panier'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          ],
          currentIndex: 0,
          selectedItemColor: Colors.blue,
          onTap: (index) {
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PanierPage()),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      tabs: categories.map((category) => Tab(text: category)).toList(),
      onTap: (index) {
        setState(() {
          selectedCategory = categories[index];
        });
      },
    );
  }

  Widget _buildActivitesList() {
    return FutureBuilder<List<Activite>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Afficher un indicateur de chargement en attendant
        } else if (snapshot.hasError) {
          return Text('Erreur : ${snapshot.error}');
        } else {
          List<Activite> allActivites = snapshot.data!;
          List<Activite> filteredActivites = selectedCategory == 'Toutes'
              ? allActivites
              : allActivites
                  .where((activite) => activite.categorie == selectedCategory)
                  .toList();
          print(filteredActivites.length);
          return ListView.builder(
            itemCount: filteredActivites.length,
            itemBuilder: (context, index) {
              return _buildActiviteCard(filteredActivites[index], context);
            },
          );
        }
      },
    );
  }

  Widget _buildActiviteCard(Activite activite, BuildContext context) {
    return ListTile(
      leading: Image.asset(
        activite.imageURL,
        errorBuilder: (context, error, stackTrace) {
          return Text('Failed to load image');
        },
      ),
      title: Text(activite.titre),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Lieu: ${activite.lieu}'),
          Text('Prix: ${activite.prix.toString()}'),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailActivitePage(activite)),
        );
      },
    );
  }

  // List<Activite> fetchData(String category) {
  //   // Implement logic to fetch data based on the selected category
  //   // For now, returning sample data
  //   List<Activite> sampleActivites = [
  //     Activite('1', 'Activite 1', 'Lieu 1', 20, 'image_url_1', 'Category 1', 10),
  //     Activite('2', 'Activite 2', 'Lieu 2', 30, 'image_url_2', 'Category 2', 20),
  //     Activite('3', 'Activite 3', 'Lieu 3', 40, 'image_url_3', 'Category 3', 30),
  //   ];

  //   if (category == 'Toutes') {
  //     return sampleActivites;
  //   } else {
  //     return sampleActivites.where((activite) => activite.categorie == category).toList();
  //   }
  // }

  Future<List<Activite>> fetchData() async {
    CollectionReference activitesRef =
        FirebaseFirestore.instance.collection('activites');
    try {
      QuerySnapshot querySnapshot = await activitesRef.get();

      List<Activite> activitesList = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Activite(
          doc.id,
          data['titre'],
          data['lieu'],
          2,
          data['imageURL'],
          data['categorie'],
          data['quantite'],
        );
      }).toList();

      return activitesList;
    } catch (error) {
      print("Error fetching data: $error");
      throw error;
    }
  }
}

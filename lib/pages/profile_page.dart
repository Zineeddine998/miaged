import 'package:flutter/material.dart';
import 'package:namer_app/activities_page.dart';
import 'package:namer_app/login_page.dart';
import 'package:namer_app/panier_page.dart';
import 'package:provider/provider.dart';

import 'User.dart';
import 'userProvider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 2;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return ActivitesPage();
      case 1:
        return PanierPage();
      case 2:
        return ProfilePage();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Provider.of<UserProvider>(context, listen: false)
                      .updateUser(user!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Profile updated successfully')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              child: Text(
                'Valider',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                initialValue: user!.login,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Login',
                ),
              ),
              TextFormField(
                initialValue: user.password,
                onChanged: (value) {
                  setState(() {
                    user.password = value;
                  });
                },
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              TextFormField(
                readOnly: true,
                initialValue:
                    DateTime.parse(user.birthday).toLocal().toString(),
                onChanged: (value) {
                  setState(() {
                    user.birthday = value.toString();
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Anniversaire',
                ),
                keyboardType: TextInputType.datetime,
              ),
              TextFormField(
                initialValue: user.address,
                onChanged: (value) {
                  setState(() {
                    user.address = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Addresse',
                ),
              ),
              TextFormField(
                initialValue: user.postalCode.toString(),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    user.postalCode = int.parse(value);
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Code postal',
                ),
              ),
              TextFormField(
                initialValue: user.city,
                onChanged: (value) {
                  setState(() {
                    user.city = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Ville',
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                  ),
                  child: Text(
                    'Se déconnecter',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Activités'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Panier'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          if (index != _currentIndex) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => _getPage(index)),
            );
          }
        },
      ),
    );
  }
}

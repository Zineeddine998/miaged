import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:namer_app/activities_page.dart';
import 'package:namer_app/userProvider.dart';
import 'package:provider/provider.dart';

import 'User.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  Future<void> _submitForm() async {
    final String login = _loginController.text.trim();
    final String password = _passwordController.text;

    if (login == '' || password == '') {
      setState(() {
        _errorMessage = 'Champs vides';
      });
    } else {
      final QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
          .instance
          .collection('user')
          .where('email', isEqualTo: login)
          .limit(1)
          .get();

      if (result.docs.isNotEmpty) {
        final user = result.docs.first;
        final String storedPassword = user['password'];

        if (password == storedPassword) {
          final User currentUser = User(
            id: user.id,
            login: user['email'],
            password: user['password'],
            birthday: user['birthday'],
            address: user['address'],
            postalCode: user['postalCode'],
            city: user['city'],
          );

          Provider.of<UserProvider>(context, listen: false)
              .setUser(currentUser);
              
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ActivitesPage()),
          );
        } else {
          setState(() {
            _errorMessage = 'Erreur de login ou password';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Erreur de login ou password';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'MIAGED',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _loginController,
                  decoration: InputDecoration(
                    labelText: 'Login',
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Se connecter'),
                ),
                if (_errorMessage.isNotEmpty)
                  Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

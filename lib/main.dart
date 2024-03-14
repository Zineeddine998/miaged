import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:namer_app/firebase_options.dart';
import 'package:namer_app/userProvider.dart';
import 'package:provider/provider.dart';
import 'activities_page.dart';
import 'login_page.dart'; 

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(), 
      child: MaterialApp(
        title: 'MIAGED',
        home: LoginPage(),
      ),
    );
  }
}

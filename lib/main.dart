import 'package:decibels/pages/home_page.dart';
import 'package:decibels/pages/library_page.dart';
import 'package:decibels/pages/login_page.dart';
import 'package:decibels/pages/navigation_drawer.dart';
import 'package:decibels/pages/offline_page.dart';
import 'package:decibels/pages/profile_page.dart';
import 'package:decibels/pages/settings_page.dart';
import 'package:decibels/pages/subscriptions_page.dart';
import 'package:decibels/pages/terms_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) => runApp(const MyApp()));
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      routes: <String, WidgetBuilder>{
        DrawerPage.routeName: (BuildContext context) => DrawerPage(),
        Perfil.routeName: (BuildContext context) => Perfil(),
        Biblioteca.routeName: (BuildContext context) => Biblioteca(),
        Terminos.routeName: (BuildContext context) => Terminos(),
        Settings.routeName: (BuildContext context) => Settings(),
        Offline.routeName: (BuildContext context) => Offline(),
        Subscriptions.routeName: (BuildContext context) => Subscriptions(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Algo ha ido mal!!'));
          } else if (snapshot.hasData) {
            return DrawerPage();
          } else {
            return LoginPage();
          }
        },
      ),
    );
    // return Scaffold(
    //   body: DrawerPage(),
    // );
  }
}

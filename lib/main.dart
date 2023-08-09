import 'package:chat_app/screens/user_detail_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import '../screens/chat_screen.dart';
import './screens/auth_screen.dart';

void main() async {
  // final fcmToken = await FirebaseMessaging().getToken();
  // print(fcmToken);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        primaryColor: Colors.pink,
        buttonTheme: ButtonTheme.of(context).copyWith(
          textTheme: ButtonTextTheme.primary,
          buttonColor: Colors.pink,
          colorScheme: ColorScheme.fromSwatch(
            accentColor: Colors.pink,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
        ),
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 16,
            // color: Colors.blue,
            // color: Colors.blue,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.pink,
        ),
        appBarTheme: const AppBarTheme(
          // backgroundColor:
          color: Colors.pink,
        ),
        fontFamily: 'Dosis',
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color.fromARGB(255, 5, 209, 185),
        )
            .copyWith(primary: Colors.pink, background: Colors.pink)
            .copyWith(secondary: Colors.deepPurple),
      ),
      home: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ChatScreen();
          }
          return AuthScreen();
        },
        stream: FirebaseAuth.instance.authStateChanges(),
      ),
      routes: {
        UserDetailScreen.routeName: (context) => UserDetailScreen(),
      },
    );
  }
}

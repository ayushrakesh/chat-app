import 'dart:io';
import 'package:flutter/material.dart';
import '../widgets/auth/auth-form.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final auth = FirebaseAuth.instance;

  var isLoading = false;

  void submitForm(
    String email,
    String userName,
    String password,
    File image,
    bool isLogin,
    BuildContext ctx,

    // BuildContext context,
  ) async {
    UserCredential userCredential;
    setState(() {
      isLoading = true;
    });
    try {
      if (isLogin) {
        userCredential = (await auth.signInWithEmailAndPassword(
            email: email, password: password));
      } else {
        userCredential = await auth.createUserWithEmailAndPassword(
            email: email, password: password);

        final ref = FirebaseStorage.instance
            .ref()
            .child('userImages')
            .child(userCredential.user!.uid + '.jpg');

        await ref.putFile(image);

        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(
          {
            'email': email,
            'username': userName,
            'image_url': url,
          },
        );
      }

      setState(() {
        isLoading = false;
      });
    } on FirebaseException catch (error) {
      var errMsg = 'An error occured ,please check your credentials';
      // print(errMsg);
      if (error.message != null) {
        errMsg = error.message!;
      }
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            'ERROR',
            style: TextStyle(
              color: Theme.of(context).errorColor,
            ),
          ),
          content: Text(errMsg),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Okay',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ],
        ),
        barrierDismissible: false,
      );
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      // print(error);
      setState(
        () {
          isLoading = false;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AuthForm(submitForm, isLoading),
    );
  }
}

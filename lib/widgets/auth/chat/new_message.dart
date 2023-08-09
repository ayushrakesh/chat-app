// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var enteredMsg = '';
  final enteredMsgController = TextEditingController();

  void sendMsg() async {
    FocusScope.of(context).unfocus();

    final user = await FirebaseAuth.instance.currentUser;

    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add(
      {
        'msg': enteredMsg,
        'createdAt': Timestamp.now(),
        'userId': user?.uid,
        'username': userData['username'],
        'userimage': userData['image_url'],
      },
    );

    enteredMsgController.clear();
    setState(() {
      enteredMsg = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 0,
      ),
      padding: EdgeInsets.all(
        12,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: enteredMsgController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    // vertical: 0,
                    ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor.withOpacity(1),
                  ),
                ),
                labelText: 'Send a message...',
                labelStyle: TextStyle(
                  color: Theme.of(context).primaryColor.withRed(1),
                ),
              ),
              onChanged: (value) {
                setState(
                  () {
                    enteredMsg = value;
                  },
                );
              },
            ),
          ),
          IconButton(
            disabledColor: Theme.of(context).primaryColor.withOpacity(0.3),
            onPressed: enteredMsg.trim().isEmpty ? null : sendMsg,
            icon: Icon(
              Icons.send,
              // color: Color.fromARGB(255, 255, 167, 196),
            ),
          ),
        ],
      ),
    );
  }
}

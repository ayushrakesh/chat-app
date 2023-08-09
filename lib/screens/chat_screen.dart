import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

import '../widgets/auth/chat/messages.dart';
import '../widgets/auth/chat/new_message.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Future<void> backgroundMessageHandler(RemoteMessage msg) async {
    await Firebase.initializeApp();
    print(msg);
  }

  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage msg) {
      print(msg);
      return;
    });

    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage msg) {
      print(msg);
      return;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatApp'),
        actions: [
          DropdownButton(
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Logout',
                      ),
                    ],
                  ),
                ),
              )
            ],
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            onChanged: (itemIdentifier) async {
              if (itemIdentifier == 'logout') {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    actions: [
                      TextButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Yes',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'No',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ],
                    title: Text(
                      'Alert',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).errorColor,
                        // color: Theme.of(context).errorColor,
                      ),
                    ),
                    content: Text('Do you really want to logout?'),
                  ),
                );
              }
            },
          )
        ],
      ),
      body: Container(
        // margin: EdgeInsets.only(
        //   top: 16,
        // ),
        // padding: EdgeInsets.only(top: 16),
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}

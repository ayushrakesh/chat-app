import 'package:chat_app/widgets/auth/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('chat')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, chatSnapshot) {
            if (chatSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              reverse: true,
              itemBuilder: (ctx, index) => MessageBubble(
                chatSnapshot.data?.docs[index]['msg'],
                chatSnapshot.data?.docs[index]['username'],
                chatSnapshot.data?.docs[index]['userimage'],
                chatSnapshot.data?.docs[index]['createdAt'],
                chatSnapshot.data?.docs[index]['userId'] ==
                    futureSnapshot.data?.uid,
                key: ValueKey(chatSnapshot.data?.docs[index].id),
              ),
              itemCount: chatSnapshot.data?.docs.length,
            );
          },
        );
      },
      future: Future.value(FirebaseAuth.instance.currentUser),
    );
  }
}

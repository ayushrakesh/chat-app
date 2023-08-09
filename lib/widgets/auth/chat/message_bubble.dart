import 'package:cloud_firestore/cloud_firestore.dart';

import '/screens/user_detail_screen.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

// ignore: must_be_immutable
class MessageBubble extends StatelessWidget {
  final message;
  final isMe;
  final userName;

  final userImage;
  final timeStamp;
  Key? key;

  MessageBubble(
    this.message,
    this.userName,
    this.userImage,
    this.timeStamp,
    this.isMe, {
    this.key,
  });

  String calcTimeDiff(Timestamp timestamp) {
    // timestamp = timeStamp;
    var mlls = timestamp.millisecondsSinceEpoch;
    var date = DateTime.fromMillisecondsSinceEpoch(mlls);
    var d12 = DateFormat('dd-MMM-yyyy, hh:mm a').format(date);
    return d12;
  }

  // Widget time(Timestamp timestamp) {
  //   var str = fun(timestamp.seconds);

  //   return Text(
  //     str,
  //     style: TextStyle(fontSize: 11),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              width: 140,
              decoration: BoxDecoration(
                color: isMe
                    ? Colors.lime.shade300
                    : Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    12,
                  ),
                  topRight: Radius.circular(
                    12,
                  ),
                  bottomLeft: isMe ? Radius.circular(12) : Radius.circular(0),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
              // padding: EdgeInsets.fromLTRB(isMe ? 0 : 0, 10, isMe ? 0 : 0, 0),
              margin: EdgeInsets.symmetric(
                vertical: 26,
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        UserDetailScreen.routeName,
                        arguments: {
                          'username': userName,
                          'userimage': userImage,
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(4),

                      // height: 18,
                      child: Text(
                        userName,
                        style: TextStyle(
                          fontSize: 12,
                          // fontFamily: 'DancingScript-Bold',
                          fontWeight: FontWeight.bold,
                          color: isMe ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color:
                          isMe ? Colors.lime : Color.fromARGB(255, 70, 39, 122),
                      borderRadius: BorderRadius.only(
                          bottomLeft:
                              isMe ? Radius.circular(12) : Radius.circular(0),
                          bottomRight:
                              isMe ? Radius.circular(0) : Radius.circular(12)),
                    ),
                    width: double.infinity,
                    child: Text(
                      message,
                      textAlign: isMe ? TextAlign.end : TextAlign.start,
                      style: TextStyle(
                        // fontFamily: 'DancingScript',
                        color: isMe ? Colors.black : Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 6,
          left: isMe ? null : 124,
          right: isMe ? 124 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          ),
        ),
        Positioned(
          child: Text(
            calcTimeDiff(timeStamp),
            style: TextStyle(
              fontSize: 11,
            ),
          ),
          left: isMe ? null : 24,
          right: isMe ? 24 : null,
          bottom: 10,
        ),
      ],
      clipBehavior: Clip.none,
    );
  }
}

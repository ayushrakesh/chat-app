// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_core/firebase_core.dart';

// class Notification {
//   Future<void> backgroundMsg(RemoteMessage message) async {
//     await Firebase.initializeApp();

//     FirebaseMessaging.onBackgroundMessage((RemoteMessage msg) {
//       print(msg);
//     });
//   }

//   void foregroundMsg() {
//     FirebaseMessaging.onMessage.listen(RemoteMessage message){

//     };
//     print(message);
//   }

//   void appOpenedMsg(RemoteMessage message) {
//     print(message);
//   }
// }

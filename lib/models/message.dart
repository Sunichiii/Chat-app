import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  final String senderID;
  final String senderEmail;
  final String receiverID;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.timestamp,
    required this.message,
    required this.receiverID,
    required this.senderEmail,
    required this.senderID

});

  // converting to a map

  Map<String, dynamic> toMap(){
    return{
      'senderID': senderID,
      'senderEmail': receiverID,
      'receiverID': receiverID,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
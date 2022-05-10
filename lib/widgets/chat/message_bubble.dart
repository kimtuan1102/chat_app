import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/**
 * Created by Trinh Kim Tuan.
 * Date:  5/10/2022
 * Time: 5:22 PM
 */
class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String userId;

  const MessageBubble(
      {Key? key,
      required this.message,
      required this.isMe,
      required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomRight:
                      isMe ? Radius.circular(0) : Radius.circular(12))),
          width: 140,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Column(
            children: [
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(userId)
                    .get(),
                builder: (ctx, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> userSnapshot) {
                  if(userSnapshot.connectionState == ConnectionState.waiting || !userSnapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  return Text(
                    userSnapshot.data!.get('username'),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  );
                },
              ),
              Text(
                message,
                style: TextStyle(
                    color: isMe
                        ? Colors.black
                        : Theme.of(context).accentTextTheme.titleMedium?.color),
              ),
            ],
          ),
        )
      ],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/chat/message_bubble.dart';
/**
 * Created by Trinh Kim Tuan.
 * Date:  5/10/2022
 * Time: 4:51 PM
 */

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chat')
              .orderBy('createAt', descending: true)
              .snapshots(),
          builder: (ctx,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> chatSnapshot) {
            if (chatSnapshot.connectionState == ConnectionState.waiting ||
                !chatSnapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final chatDocuments = chatSnapshot.data!.docs;
            return ListView.builder(
                reverse: true,
                itemBuilder: (ctx, idx) {
                  return MessageBubble(
                    userId: chatDocuments.elementAt(idx).get('userId'),
                    message: chatDocuments.elementAt(idx).get('text'),
                    isMe: chatDocuments.elementAt(idx).get('userId') == FirebaseAuth.instance.currentUser!.uid,
                    key: ValueKey(chatDocuments.elementAt(idx).id),
                  );
                },
                itemCount: chatDocuments.length);
          }),
    );
  }
}

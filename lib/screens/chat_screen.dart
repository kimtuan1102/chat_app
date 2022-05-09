import 'package:flutter/material.dart';

/**
 * Created by Trinh Kim Tuan.
 * Date:  5/9/2022
 * Time: 5:56 PM
 */
class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (ctx, idx) => Container(
          padding: EdgeInsets.all(8),
          child: Text('This works!'),
        ),
        itemCount: 10,
      ),
    );
  }
}

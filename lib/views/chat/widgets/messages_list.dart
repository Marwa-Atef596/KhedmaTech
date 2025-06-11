import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'recieved_message.dart';
import 'send_message.dart';

class MessagesList extends StatelessWidget {
   MessagesList({super.key, this.messages});
  List? messages;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 24),
      child: ListView.separated(
        itemBuilder: (context, index){
          if(messages![index]["owner"]  == FirebaseAuth.instance.currentUser!.uid){
          print("send");
            return  SendMessage(msg:messages![index]["content"]);
          }
          return  ReceiverMessage(msg:messages![index]["content"]);
        },
        separatorBuilder: (context, index){
          return const SizedBox(height: 16,);
        },
        itemCount: messages!.length,
      ),
    );
  }
}

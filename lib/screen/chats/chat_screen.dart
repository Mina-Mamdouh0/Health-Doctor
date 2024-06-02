

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_mate_doctor/bloc/app_cubit.dart';
import 'package:health_mate_doctor/bloc/app_state.dart';
import 'package:health_mate_doctor/resourse/massage_model.dart';
import 'package:health_mate_doctor/resourse/resourse.dart';



class ChatScreen extends StatelessWidget {
  final String uid;
  final String name;
  ChatScreen({Key? key, required this.uid, required this.name}) : super(key: key);

  ScrollController scrollController=ScrollController();
  TextEditingController controller=TextEditingController();


  @override
  Widget build(BuildContext context) {
    var message = FirebaseFirestore.instance.collection('Chats').doc(uid).collection('Massage');
    return StreamBuilder<QuerySnapshot>(
        stream: message.orderBy('created',descending: true).snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            List<MessageModel> messageList=[];
            for(int i=0;i<snapshot.data!.docs.length;i++){
              messageList.add(MessageModel.jsonDate(snapshot.data!.docs[i]));
            }
            return Scaffold(
                backgroundColor: const Color(0XFFF0EAEA),
                appBar: AppBar(
                  backgroundColor: pColor,
                  title: Text(name),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          controller: scrollController,
                          reverse: true,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          itemCount: messageList.length,
                          itemBuilder: (context,index){
                            return  messageList[index].id == FirebaseAuth.instance.currentUser?.uid?
                            BubbleChat(message: messageList[index],):
                            BubbleChatFormFriend(message: messageList[index],);
                          }),
                    ),
                    BlocBuilder<AppCubit,AppState>(
                        builder: (context,state){
                          var cubit =AppCubit.get(context);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                Expanded(
                                  child: TextField(
                                    controller:controller ,
                                    decoration:  InputDecoration(
                                      hintText: 'message',
                                      fillColor: Colors.white,
                                      filled: true,
                                      focusedBorder:   OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                              color:pColor,
                                              width: 2
                                          )
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                              color: Colors.white,
                                              width: 1
                                          )
                                      ),
                                    ),
                                    onSubmitted: (date){
                                      message.add({
                                        'message': date,
                                        'image':'https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=',
                                        'created':DateTime.now(),
                                        'id':FirebaseAuth.instance.currentUser?.uid,
                                      });
                                      FirebaseFirestore.instance.collection('Chats').doc(uid).update({
                                        'TimeLastMsg':Timestamp.now(),
                                        'LastMsg':controller.text,
                                      });
                                      scrollController.animateTo(
                                        0,
                                        duration:const Duration(milliseconds: 400),
                                        curve: Curves.ease,
                                      );
                                      controller.clear();
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                InkWell(
                                  onTap: (){
                                    message.add({
                                      'message': controller.text,
                                      'image':'https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=',
                                      'created':DateTime.now(),
                                      'id':FirebaseAuth.instance.currentUser?.uid,
                                    });

                                    FirebaseFirestore.instance.collection('Chats').doc(uid).update({
                                      'TimeLastMsg':Timestamp.now(),
                                      'LastMsg':controller.text,
                                    });
                                    scrollController.animateTo(
                                      0,
                                      duration:const Duration(milliseconds: 400),
                                      curve: Curves.ease,
                                    );
                                    controller.clear();

                                  },
                                  child: Container(
                                    padding:const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: pColor,
                                    ),
                                    child: const Icon(Icons.send,color: Colors.white,size: 30),
                                  ),
                                ),


                              ],
                            ),
                          );
                        })
                  ],
                )
            );
          }else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }


}

class BubbleChat extends StatelessWidget {
  const BubbleChat({
    Key? key,required this.message,
  }) : super(key: key);
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding:const EdgeInsets.all(12),
            margin:const EdgeInsets.symmetric(
                vertical: 8,horizontal: 12
            ),
            decoration:const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )
            ),
            child: Text(message.message??'',
              style:const TextStyle(
                color: pColor,
                fontSize: 15,
              ),),
          ),
          const SizedBox(width: 2,),
          CircleAvatar(
            backgroundImage: NetworkImage(message?.image??''),
            radius: 20,
          ),
        ],
      ),
    );
  }
}

class BubbleChatFormFriend extends StatelessWidget {
  const BubbleChatFormFriend({
    Key? key,required this.message,
  }) : super(key: key);
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(message?.image??''),
            radius: 20,
          ),
          const SizedBox(width: 2,),
          Container(
            padding:const EdgeInsets.all(12),
            margin:const EdgeInsets.symmetric(
                vertical: 8,horizontal: 12
            ),
            decoration:const BoxDecoration(
                color: pColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )
            ),
            child: Text(message.message??'',
              style:const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),),
          ),

        ],
      ),
    );
  }
}



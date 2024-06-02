
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_mate_doctor/bloc/app_cubit.dart';
import 'package:health_mate_doctor/bloc/app_state.dart';
import 'package:health_mate_doctor/resourse/resourse.dart';
import 'package:health_mate_doctor/screen/chats/chat_screen.dart';

class AllChatsScreen extends StatefulWidget {
  const AllChatsScreen({Key? key}) : super(key: key);

  @override
  State<AllChatsScreen> createState() => _AllChatsScreenState();
}

class _AllChatsScreenState extends State<AllChatsScreen> {

  @override
  void initState() {
    BlocProvider.of<AppCubit>(context).getChats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: pColor,
          title: Text('Chats'),
        ),
      body: BlocBuilder<AppCubit,AppState>(
        builder: (context,state){
          var cubit= AppCubit.get(context);
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child:
              (state is LoadingGetAllChatsState)?
              const Center(child: CircularProgressIndicator()):
              ListView.builder(
                  itemCount:cubit.chatsList.length ,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context,index){
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return ChatScreen(
                              uid: cubit.chatsList[index].uidChat??'',
                              name: ((FirebaseAuth.instance.currentUser?.uid??'') == (cubit.chatsList[index].uid??''))? cubit.chatsList[index].otherName??'' : cubit.chatsList[index].name??'');
                        }));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            child: Image.network('https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o='),
                          ),
                          const SizedBox(width: 10,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(((FirebaseAuth.instance.currentUser?.uid??'') == (cubit.chatsList[index].uid??''))? cubit.chatsList[index].otherName??'' : cubit.chatsList[index].name??'',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        fontFamily: 'KantumruyPro'
                                    ),textAlign: TextAlign.center),
                                const SizedBox(height: 5,),
                                Text(cubit.chatsList[index].lastMsg??'',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        fontFamily: 'KantumruyPro'
                                    ),textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                          Text('${cubit.chatsList[index].timeLastMsg?.toDate().hour} : ${cubit.chatsList[index].timeLastMsg?.toDate().minute}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  fontFamily: 'KantumruyPro'
                              ),textAlign: TextAlign.center),
                          

                        ],
                      ),
                    );
                  }))
            ],
          );
        },
      )
    );
  }
}

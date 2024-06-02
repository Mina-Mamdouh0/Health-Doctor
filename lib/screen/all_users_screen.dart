
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_mate_doctor/bloc/app_cubit.dart';
import 'package:health_mate_doctor/bloc/app_state.dart';
import 'package:health_mate_doctor/resourse/resourse.dart';
import 'package:health_mate_doctor/screen/chats/chat_screen.dart';


class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({Key? key}) : super(key: key);

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {

  @override
  void initState() {
    BlocProvider.of<AppCubit>(context).getAllDoctors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: pColor,
          elevation: 0.0,
          centerTitle: true,
          title: Text('Doctors',style: Styles.textStyle12.copyWith(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600
          )),
        ),
        body: BlocConsumer<AppCubit,AppState>(
          builder: (context,state){
            var cubit= AppCubit.get(context);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child:
                  (state is LoadingGetAllDocState)?
                  const Center(child: CircularProgressIndicator()):
                  ListView.builder(
                      itemCount:cubit.listOfDoc.length ,
                      itemBuilder: (context,index){
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset('assets/image/profile.png',width: 60,height: 60),
                                  ),
                                  const SizedBox(width: 10,),
                                  Text(cubit.listOfDoc[index].name??'',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                          fontFamily: 'KantumruyPro'
                                      ),textAlign: TextAlign.center),


                                ],
                              ),
                              const SizedBox(height: 10,),
                              (state is LoadingCreateChatState)?
                              const Center(child: CircularProgressIndicator(),)
                                  :Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: (){
                                        cubit.createChat(uid: cubit.listOfDoc[index].uId??'',name: cubit.listOfDoc[index].name??'');
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color:  pColor,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: const Text('Chat',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20,
                                                fontFamily: 'KantumruyPro'
                                            ),textAlign: TextAlign.center),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }))
                ],
              ),
            );
          },
          listener: (context,state){
            if(state is SuccessCreateChatState){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return ChatScreen(uid: state.uid??'',name: state.name??'',);
              }));
            }
          },
        )
    );
  }
}

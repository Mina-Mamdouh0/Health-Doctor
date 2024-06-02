
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_mate_doctor/bloc/app_state.dart';
import 'package:health_mate_doctor/resourse/appointment_model.dart';
import 'package:health_mate_doctor/resourse/chat_model.dart';
import 'package:health_mate_doctor/resourse/massage_model.dart';
import 'package:health_mate_doctor/resourse/profile_model.dart';
import 'package:health_mate_doctor/screen/time_screen.dart';
import 'package:uuid/uuid.dart';

class AppCubit extends Cubit<AppState> {

  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);


  void signIn({required String name,required String email , required String password , required String phone,required String age ,bool ? roleDoc}){
    emit(LoadingSignUpState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password).then((value){
          ProfileModel profileModel =ProfileModel(
            createdAt: Timestamp.now(),
            email: email,
            password: password,
            name: name,
            phone: phone,
            uId: value.user?.uid,
            age: age,
            roleIsDoc: roleDoc??false
          );
          FirebaseFirestore.instance.collection('Users').doc(value.user?.uid)
          .set(profileModel.toMap());
          emit(SuccessSignUpState());
    }).onError((error, stackTrace){
      debugPrint('Error SignUp');
      emit(ErrorSignUpState());
    });
  }

  void logout(){
    FirebaseAuth.instance.signOut().whenComplete((){
      emit(LogoutState());
    });
  }


  void login({required String email , required String password}){
    emit(LoadingLoginState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email,
        password: password).then((value){
          emit(SuccessLoginState());
          getProfileData();
    }).onError((error, stackTrace){
      emit(ErrorLoginState());
    });
  }

  ProfileModel ? profileModel;

  void getProfileData(){
    emit(LoadingGetDataUserState());
    if(FirebaseAuth.instance.currentUser?.uid != null ){
      FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser?.uid)
          .get().then((value){
            profileModel = ProfileModel.jsonDate(value);
            emit(SuccessGetDataUserState());
      }).onError((error, stackTrace){
        emit(ErrorGetDataUserState());
      });
    }
  }

  List <ProfileModel> listOfDoc=[];
  void getAllDoctors(){
    emit(LoadingGetAllDocState());
    listOfDoc=[];
      FirebaseFirestore.instance.collection('Users').get().then((value){
        value.docs.forEach((element) {
          if(element.get('RoleIsDoc') ?? false){
            listOfDoc.add(ProfileModel.jsonDate(element));
          }
        });
        emit(SuccessGetAllDocState());
      }).onError((error, stackTrace){
        emit(ErrorGetAllDocState());
      });
  }

  void addAppointment({required String uidDoc , required String date , required String time}){
    emit(LoadingAddAppointmentsState());
    String uid = Uuid().v4();
    ProfileModel? profile ;
    FirebaseFirestore.instance.collection('Users').doc(uidDoc)
    .get().then((value){
      profile = ProfileModel.jsonDate(value);
    }).then((value){
      AppointmentModel appointmentModel =AppointmentModel(
        createdAt: Timestamp.now(),
        uid: uid,
        date: date,
        time: time,
        ageDoc: profile?.age??'',
        nameDoc: profile?.name??'',
        uidDoc: uidDoc,
        uidPoint: FirebaseAuth.instance.currentUser?.uid,
      );
      FirebaseFirestore.instance.collection('Appointment').
      doc(uid).set(appointmentModel.toMap()).then((value){
        emit(SuccessAddAppointmentsState(profileModel: profile,date: date ,time: time));
      });

    }).onError((error, stackTrace){
      debugPrint('Error Add Appointments');
      emit(ErrorAddAppointmentsState());
    });


  }

  List <AppointmentModel> listOfAppointment=[];
  void getAppointment(){
    emit(LoadingGetAppointmentsState());
    listOfAppointment=[];
    FirebaseFirestore.instance.collection('Appointment').
    get().then((value){
      value.docs.forEach((element) {
        if((element.get('UidPoint') == FirebaseAuth.instance.currentUser?.uid) || (element.get('UidDoc') == FirebaseAuth.instance.currentUser?.uid)){
          listOfAppointment.add(AppointmentModel.jsonDate(element));
        }
      });
      emit(SuccessGetAppointmentsState());
    }).onError((error, stackTrace){
      emit(ErrorGetAppointmentsState());
    });
  }

  void deleteAppointment({required String docId , required bool isChangePage}){
    emit(LoadingDeleteAppointmentsState());
    FirebaseFirestore.instance.collection('Appointment').doc(docId)
    .delete().then((value){
      emit(SuccessDeleteAppointmentsState(isChangePage: isChangePage));
      getAppointment();
    }).onError((error, stackTrace){
      emit(ErrorDeleteAppointmentsState());
    });
  }

  void addTime({required List<TimeModel> list}){
    emit(LoadingAddTimeState());
    FirebaseFirestore.instance.collection('Time').get().then((value){
      if(value.docs.isNotEmpty){
        value.docs.forEach((element) {
          if(element.id == FirebaseAuth.instance.currentUser?.uid){
            FirebaseFirestore.instance.collection('Time').doc(FirebaseAuth.instance.currentUser?.uid).delete().then((value){
              FirebaseFirestore.instance.collection('Time').doc(FirebaseAuth.instance.currentUser?.uid)
                  .set({
                'Times':FieldValue.arrayUnion([...list.map((e) => e.toMap())])
              }).then((value){
                emit(SuccessAddTimesState());
              }).onError((error, stackTrace){
                print(error.toString());
                emit(ErrorAddTimesState());
              });
            });
          }else{
            FirebaseFirestore.instance.collection('Time').doc(FirebaseAuth.instance.currentUser?.uid)
                .set({
              'Times':FieldValue.arrayUnion([...list.map((e) => e.toMap())])
            }).then((value){
              emit(SuccessAddTimesState());
            }).onError((error, stackTrace){
              print(error.toString());
              emit(ErrorAddTimesState());
            });
          }
        });
      }else{


          FirebaseFirestore.instance.collection('Time').doc(FirebaseAuth.instance.currentUser?.uid)
              .set({
            'Times':FieldValue.arrayUnion([...list.map((e) => e.toMap())])
          }).then((value){
            emit(SuccessAddTimesState());
          }).onError((error, stackTrace){
            print(error.toString());
            emit(ErrorAddTimesState());
          });

      }



    });
  }


  List<TimeModel> timeList=[];

  void getTimes(){
    emit(LoadingGetTimeState());
    timeList=[];
    FirebaseFirestore.instance.collection('Time').
    get().then((value){
      value.docs.forEach((element) {
        if((element.id == FirebaseAuth.instance.currentUser?.uid) ){
          element['Times'].forEach((e) {
            timeList.add(TimeModel.jsonDate(e));
          });
        }
      });
      emit(SuccessGetTimesState());
    }).onError((error, stackTrace){
      print(error.toString());
      emit(ErrorGetTimesState());
    });
  }

  List<ChatModel > l=[];
  void createChat({required String uid ,required String name ,}){
    emit(LoadingCreateChatState());
    l=[];
   try{
     FirebaseFirestore.instance.collection('Chats').get()
         .then((value){
       if(value.docs.isNotEmpty){
         for (var e in value.docs) {
           l.add(ChatModel.jsonData(e));
         }
         if(l.any((element) => ((element.uid==FirebaseAuth.instance.currentUser?.uid) && (element.otherUid == uid))
             ||  ((element.otherUid==FirebaseAuth.instance.currentUser?.uid) && (element.uid == uid))   )){
           String u = l.firstWhere((element) => ((element.uid==FirebaseAuth.instance.currentUser?.uid)&& (element.otherUid == uid)) || ((element.otherUid == FirebaseAuth.instance.currentUser?.uid) && (element.uid == uid))).uidChat??'';
           emit(SuccessCreateChatState(uid: u,name: name));
         }
         else{
           String uuid = const Uuid().v4();
           ChatModel chatModel = ChatModel(
               uidChat: uuid,
               uid: FirebaseAuth.instance.currentUser?.uid,
               timeLastMsg: Timestamp.now(),
               otherUid: uid,
               name: profileModel?.name??'',
               otherName: name,
               lastMsg: 'Start Chat',
               createdAt: Timestamp.now()
           );
           FirebaseFirestore.instance.collection('Chats').doc(uuid).set(chatModel.toMap()).
           then((value){
             String uuidMassage = const Uuid().v4();
             MessageModel massageModel = MessageModel(
                 message: 'Start Chat',
                 image: 'https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=',
                 id: uuidMassage,
                 created: Timestamp.now()
             );
             FirebaseFirestore.instance.collection('Chats').doc(uuid).collection('Massage')
                 .doc(uuidMassage).set(massageModel.toMap()).then((value){
               emit(SuccessCreateChatState(uid: uuid,name: name));
             }).onError((error, stackTrace){
               emit(ErrorCreateChatState());
             });
           }).onError((error, stackTrace){
             emit(ErrorCreateChatState());
           });
         }
       }else{
         String uuid = const Uuid().v4();
         ChatModel chatModel = ChatModel(
             uidChat: uuid,
             uid: FirebaseAuth.instance.currentUser?.uid,
             timeLastMsg: Timestamp.now(),
             otherUid: uid,
             lastMsg: 'Start Chat',
             name: profileModel?.name??'',
             otherName: name,
             createdAt: Timestamp.now()
         );
         FirebaseFirestore.instance.collection('Chats').doc(uuid)
             .set(chatModel.toMap()).then((value){
           String uuidMassage = const Uuid().v4();
           MessageModel massageModel = MessageModel(
               message: 'Start Chat',
               image: 'https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=',
               id: uuidMassage,
               created: Timestamp.now()
           );
           FirebaseFirestore.instance.collection('Chats').doc(uuid).collection('Massage')
               .doc(uuidMassage).set(massageModel.toMap()).then((value){
             emit(SuccessCreateChatState(uid: uuid,name: name));
           }).onError((error, stackTrace){
             emit(ErrorCreateChatState());
           });
         }).onError((error, stackTrace){
           emit(ErrorCreateChatState());
         });
       }
     });
   }catch(e){
     String uuid = const Uuid().v4();
     ChatModel chatModel = ChatModel(
         uidChat: uuid,
         uid: FirebaseAuth.instance.currentUser?.uid,
         timeLastMsg: Timestamp.now(),
         otherUid: uid,
         lastMsg: 'Start Chat',
         name: profileModel?.name??'',
         otherName: name,
         createdAt: Timestamp.now()
     );
     FirebaseFirestore.instance.collection('Chats').doc(uuid)
         .set(chatModel.toMap()).then((value){
       String uuidMassage = const Uuid().v4();
       MessageModel massageModel = MessageModel(
           message: 'Start Chat',
           image: 'https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=',
           id: uuidMassage,
           created: Timestamp.now()
       );
       FirebaseFirestore.instance.collection('Chats').doc(uuid).collection('Massage')
           .doc(uuidMassage).set(massageModel.toMap()).then((value){
         emit(SuccessCreateChatState(uid: uuid,name: name));
       }).onError((error, stackTrace){
         emit(ErrorCreateChatState());
       });
     }).onError((error, stackTrace){
       emit(ErrorCreateChatState());
     });

   }
  }

  List<ChatModel> chatsList=[];
  void getChats(){
    emit(LoadingGetAllChatsState());
    chatsList=[];
    FirebaseFirestore.instance.collection('Chats').get().
    then((value){
      for (var element in value.docs) {
        ChatModel c = ChatModel.jsonData(element);
        if((FirebaseAuth.instance.currentUser?.uid == c.uid) || (FirebaseAuth.instance.currentUser?.uid == c.otherUid)){
          chatsList.add(c);
        }
      }
      emit(SuccessGetAllChatsState());
    }).onError((error, stackTrace){
      emit(ErrorGetAllChatsState());
    });

  }




}
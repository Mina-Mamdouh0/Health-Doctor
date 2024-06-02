
import 'package:health_mate_doctor/resourse/profile_model.dart';

abstract class AppState{}

class AppInitialState extends AppState{}

class AnyAppState extends AppState{}

class LogoutState extends AppState{}

class LoadingSignUpState extends AppState{}
class SuccessSignUpState extends AppState{}
class ErrorSignUpState extends AppState{}

class LoadingLoginState extends AppState{}
class SuccessLoginState extends AppState{}
class ErrorLoginState extends AppState{}

class LoadingGetDataUserState extends AppState{}
class SuccessGetDataUserState extends AppState{}
class ErrorGetDataUserState extends AppState{}

class LoadingGetAllDocState extends AppState{}
class SuccessGetAllDocState extends AppState{}
class ErrorGetAllDocState extends AppState{}

class LoadingAddAppointmentsState extends AppState{}
class SuccessAddAppointmentsState extends AppState{
  ProfileModel ? profileModel;
  String ? date;
  String ? time;
  SuccessAddAppointmentsState({required this.profileModel ,required this.date,required this.time});
}
class ErrorAddAppointmentsState extends AppState{}

class LoadingGetAppointmentsState extends AppState{}
class SuccessGetAppointmentsState extends AppState{}
class ErrorGetAppointmentsState extends AppState{}

class LoadingDeleteAppointmentsState extends AppState{}
class SuccessDeleteAppointmentsState extends AppState{
  bool ? isChangePage;
  SuccessDeleteAppointmentsState({required this.isChangePage});
}
class ErrorDeleteAppointmentsState extends AppState{}

class LoadingAddTimeState extends AppState{}
class SuccessAddTimesState extends AppState{}
class ErrorAddTimesState extends AppState{}

class LoadingGetTimeState extends AppState{}
class SuccessGetTimesState extends AppState{}
class ErrorGetTimesState extends AppState{}

class LoadingCreateChatState extends AppState{}
class SuccessCreateChatState extends AppState{
  String ? uid;
  String ? name;
  SuccessCreateChatState({this.uid, this.name});
}
class ErrorCreateChatState extends AppState{}

class LoadingGetAllChatsState extends AppState{}
class SuccessGetAllChatsState extends AppState{}
class ErrorGetAllChatsState extends AppState{}

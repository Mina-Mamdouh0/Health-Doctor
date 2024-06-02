
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:group_button/group_button.dart';
import 'package:health_mate_doctor/bloc/app_cubit.dart';
import 'package:health_mate_doctor/bloc/app_state.dart';
import 'package:health_mate_doctor/screen/all_users_screen.dart';
import 'package:health_mate_doctor/screen/auth/loginpage.dart';
import 'package:health_mate_doctor/screen/chats/all_chats_screen.dart';
import 'package:health_mate_doctor/screen/notification_screen.dart';
import 'package:health_mate_doctor/resourse/resourse.dart';
import 'package:health_mate_doctor/screen/time_screen.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {

  GroupButtonController groupButtonController=GroupButtonController(selectedIndex: 1);
  List<String> nameButton=['Add appointments','Appointments'];
  GroupButtonController groupButtonController2=GroupButtonController(selectedIndex: 0);
  final List<String> _nameButton2=['09:00 : 09:30 Am','09:30 : 10:00 Am','10:00 : 10:30 Am','10:30 : 11:00 Am','11:00 : 11:30Am','11:30 : 12:00 Am','12:00 : 01:00 Pm','01:00 : 01:30 Pm','01:30 : 02:00 Pm','02:00 : 02:30 Pm',];
  String time = '09:00 : 09:30 Am';
  String ? date;
  int indexPage =1;

  final DateRangePickerController controller = DateRangePickerController();

  @override
  void initState() {
    BlocProvider.of<AppCubit>(context).getAllDoctors();
    BlocProvider.of<AppCubit>(context).getAppointment();
    BlocProvider.of<AppCubit>(context).getTimes();
    super.initState();
  }

  String ? selectDoc;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        builder: (context,state){
          var cubit = AppCubit.get(context);
          return Scaffold(
            backgroundColor: const Color(0XFFF5F5F5),
            appBar: AppBar(
              backgroundColor: pColor,
              elevation: 0.0,
              centerTitle: false,
              leading: (cubit.profileModel?.roleIsDoc??false) ?InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return TimeScreen();
                  }));

                },
                  child: Icon(Icons.timelapse,color: Colors.white)):Container(),
              title: Text('appointments',style: Styles.textStyle12.copyWith(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600
              )),
              actions: [
                InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return  AllUsersScreen();
                      }));
                    },
                    child: const Icon(Icons.people_alt,color: Colors.white,)),
                const SizedBox(width: 10,),
                InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return  AllChatsScreen();
                      }));
                    },
                    child: const Icon(Icons.chat,color: Colors.white,)),
                const SizedBox(width: 10,),
                InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return const NotificationsScreen();
                      }));
                    },
                    child: const Icon(Icons.notifications,color: Colors.white,)),
                const SizedBox(width: 10,),
                InkWell(
                    onTap: (){
                      cubit.logout();
                    },
                    child: const Icon(Icons.login,color: Colors.white,)),
                const SizedBox(width: 10,),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /*cubit.profileModel?.roleIsDoc??false ? Container():*/

                  Center(
                    child: Container(
                      //width: double.infinity,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: pColor,
                              width: 1
                          ),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: GroupButton(
                          controller: groupButtonController,
                          isRadio: true,
                          enableDeselect: false,
                          buttonIndexedBuilder: (selected,index,context){
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: selected?pColor:Colors.white
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(nameButton[index],style: Styles.textStyle12.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color:selected?Colors.white:const Color(0XFF707070)),
                                    textAlign: TextAlign.center,)
                                ],
                              ),
                            );
                          },
                          options: const GroupButtonOptions(
                            groupRunAlignment: GroupRunAlignment.start,
                            crossGroupAlignment: CrossGroupAlignment.start,
                            direction: Axis.horizontal,
                          ),
                          onSelected: (_,indexx,isSelected){
                            setState(() {
                              indexPage = indexx;
                            });
                          },
                          buttons:nameButton
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  (indexPage==1) ?
                  Expanded(child:

          (state is LoadingGetAppointmentsState)?
          Center(child: CircularProgressIndicator(),):
          ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      itemCount: cubit.listOfAppointment.length,
                      itemBuilder: (context,index){
                        return Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('${cubit.listOfAppointment[index].date} , ${cubit.listOfAppointment[index].time}',style: Styles.textStyle12.copyWith(
                                  color: const Color(0XFF1F2A37),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16
                              ),),
                              const SizedBox(height: 5,),
                              const Divider(height: 1,color: Color(0XFFE5E7EB),),
                              const SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset('assets/image/profile.png',width: 60,height: 60),
                                  ),
                                  const SizedBox(width: 15,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('${cubit.listOfAppointment[index].nameDoc}',style: Styles.textStyle12.copyWith(
                                          color: const Color(0XFF1F2A37),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18
                                      ),),
                                      const SizedBox(height: 5,),
                                      Text('${cubit.listOfAppointment[index].ageDoc}',style: Styles.textStyle12.copyWith(
                                          color: const Color(0XFF4B5563),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16
                                      ),),

                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 5,),
                              const Divider(height: 1,color: Color(0XFFE5E7EB),),
                              const SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  (state is SuccessDeleteAppointmentsState)? Center(child: CircularProgressIndicator(),)
                                      :Expanded(
                                    child: InkWell(
                                      onTap: (){
                                        cubit.deleteAppointment(docId: cubit.listOfAppointment[index].uid??'',isChangePage: false);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: const Color(0XFFE5E7EB),
                                            borderRadius: BorderRadius.circular(18.5)
                                        ),
                                        child: Center(
                                          child: Text('Cancel',style: Styles.textStyle12.copyWith(
                                              color: const Color(0XFF1F2A37),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18
                                          ),),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5,),
                                  (state is SuccessDeleteAppointmentsState)? Center(child: CircularProgressIndicator(),)
                                      :Expanded(
                                    child: InkWell(
                                      onTap: (){
                                        cubit.deleteAppointment(docId: cubit.listOfAppointment[index].uid??'',isChangePage: true);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: pColor,
                                            borderRadius: BorderRadius.circular(18.5)
                                        ),
                                        child: Center(
                                          child: Text('Reschedule',style: Styles.textStyle12.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18
                                          ),),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )

                            ],
                          ),
                        );

                      }))
                      :Expanded(
                      child: RefreshIndicator(
                        onRefresh: ()async{
                          cubit.getTimes();
                        },
                        child: SingleChildScrollView(
                          padding: EdgeInsets.zero,
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [


                              (state is LoadingGetAllDocState)?
                              CircularProgressIndicator():
                              DropdownButtonFormField(
                                  items: [
                                    ...cubit.listOfDoc.map((e){
                                      return DropdownMenuItem(
                                        value: e.uId,
                                        child: Text(e.name??''),
                                      );
                                    })
                                  ],
                                  hint: Text('Doctors'),
                                  value: selectDoc,
                                  onChanged: (val){
                                    if(val!.isNotEmpty){
                                      selectDoc=val;
                                    }
                                  }),

                              const SizedBox(height: 20,),


                              Text('Select Date',style: Styles.textStyle12.copyWith(
                                  color:  pColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18
                              ),),
                              const SizedBox(height: 10,),

                              SizedBox(
                                height: 300,
                                width: double.infinity,
                                child: SfDateRangePicker(
                                  rangeSelectionColor: pColor,
                                  endRangeSelectionColor: pColor,
                                  selectionColor: pColor,
                                  rangeTextStyle: Styles.textStyle12.copyWith(fontSize: 16,color: Colors.black),
                                  headerStyle: DateRangePickerHeaderStyle(
                                    textStyle: Styles.textStyle12.copyWith(fontSize: 16,color: Colors.black),
                                  ),
                                  selectionTextStyle: Styles.textStyle12.copyWith(fontSize: 16,color: Colors.black),
                                  monthCellStyle: DateRangePickerMonthCellStyle(
                                    textStyle: Styles.textStyle12.copyWith(fontSize: 16,color: Colors.black),
                                    todayTextStyle: Styles.textStyle12.copyWith(fontSize: 16,color: Colors.black),
                                    weekendTextStyle: Styles.textStyle12.copyWith(fontSize: 16,color: Colors.black),
                                    disabledDatesTextStyle: Styles.textStyle12.copyWith(fontSize: 16,color: Colors.black),
                                    trailingDatesTextStyle: Styles.textStyle12.copyWith(fontSize: 16,color: Colors.black),
                                  ),
                                  selectableDayPredicate: (DateTime dateTime){
                                    if(dateTime.compareTo(DateTime.now().subtract(const Duration(days: 1)))==1){
                                      return true;
                                    }
                                    else{
                                      return false;
                                    }
                                  },
                                  toggleDaySelection: true,
                                  onSelectionChanged: (DateRangePickerSelectionChangedArgs args){
                                    setState(() {
                                      date = args.value.toString().split(' ').first;
                                    });
                                  },
                                  controller: controller,
                                  selectionMode: DateRangePickerSelectionMode.single,
                                  selectionShape:DateRangePickerSelectionShape.circle ,
                                  showActionButtons:false,

                                ),
                              ),


                              const SizedBox(height: 20,),


                              Text('Select Hour',style: Styles.textStyle12.copyWith(
                                  color:  pColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18
                              ),),
                              const SizedBox(height: 10,),

                              GroupButton(
                                  controller: groupButtonController2,
                                  isRadio: true,
                                  enableDeselect: false,
                                  buttonIndexedBuilder: (selected,index,context){
                                    return Container(
                                      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: selected?pColor:Colors.white
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text((cubit.profileModel?.roleIsDoc??false)? cubit.timeList[index].time??'' : _nameButton2[index],style: Styles.textStyle12.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color:selected?Colors.white:const Color(0XFF707070)),
                                            textAlign: TextAlign.center,)
                                        ],
                                      ),
                                    );
                                  },
                                  options: const GroupButtonOptions(
                                    groupRunAlignment: GroupRunAlignment.start,
                                    crossGroupAlignment: CrossGroupAlignment.start,
                                    mainGroupAlignment: MainGroupAlignment.spaceAround,
                                    groupingType: GroupingType.wrap,
                                    direction: Axis.horizontal,
                                  ),
                                  onSelected: (_,indexx,isSelected){
                                    setState(() {
                                      time=(cubit.profileModel?.roleIsDoc??false)? cubit.timeList[indexx].time??'' : _nameButton2[indexx];
                                    });
                                  },
                                  buttons:(cubit.profileModel?.roleIsDoc??false)? cubit.timeList : _nameButton2
                              ),


                              const SizedBox(height: 20,),


                              (state is LoadingAddAppointmentsState)?
                              Center(child: CircularProgressIndicator()):
                              InkWell(
                                onTap: (){
                                  if(selectDoc!=null || date !=null){
                                    cubit.addAppointment(
                                        uidDoc: selectDoc!,
                                        time:time,
                                        date:date!
                                    );
                                  }else{
                                    Fluttertoast.showToast(
                                      msg: 'Please Select Doctor or Date',
                                      toastLength: Toast.LENGTH_LONG,
                                      backgroundColor: Colors.red,
                                      gravity: ToastGravity.TOP,
                                      fontSize: 18,
                                      textColor: Colors.white,
                                    );
                                  }

                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: pColor,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Center(
                                    child: Text('Save',style: Styles.textStyle12.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18
                                    ),),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            ),
          );
        }, 
        listener: (context,state){
          if(state is LogoutState){
            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return LoginPage();
            }));
          }else if(state is SuccessAddAppointmentsState){
            showDialog(context: context,
                builder: (context){
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: pColor
                          ),
                          child: const Center(
                            child: Icon(Icons.security,color: Colors.white,size: 25),
                          ),

                        ),
                        const SizedBox(height: 15,),
                        Text('Done',style: Styles.textStyle12.copyWith(
                            color: pColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 22
                        ),),
                        const SizedBox(height: 15,),
                        Text('you appointment with Dr ${state.profileModel?.name??''} is Confirmed For ${state.date} ${state.time}',style: Styles.textStyle12.copyWith(
                            color: const Color(0XFF6B7280),
                            fontWeight: FontWeight.w400,
                            fontSize: 16
                        ),textAlign: TextAlign.center),
                        const SizedBox(height: 10,),
                        Text('its Preferable to arrive half an hour eary',style: Styles.textStyle12.copyWith(
                            color: pColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16
                        ),textAlign: TextAlign.center),
                        const SizedBox(height: 10,),
                        InkWell(
                          onTap: (){
                            BlocProvider.of<AppCubit>(context).getAppointment();
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: pColor,
                                borderRadius: BorderRadius.circular(18.5)
                            ),
                            child: Center(
                              child: Text('Done',style: Styles.textStyle12.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18
                              ),),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                });
          }else if (state is SuccessDeleteAppointmentsState){
            if(state.isChangePage??false){
              setState(() {
                indexPage = 0;
                groupButtonController.selectIndex(0);
              });
            }
          }
        });
  }
}

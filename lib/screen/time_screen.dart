
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';
import 'package:health_mate_doctor/bloc/app_cubit.dart';
import 'package:health_mate_doctor/bloc/app_state.dart';
import 'package:health_mate_doctor/resourse/resourse.dart';

class TimeScreen extends StatefulWidget {
  const TimeScreen({Key? key}) : super(key: key);

  @override
  State<TimeScreen> createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {

  GroupButtonController groupButtonController2=GroupButtonController();
  final List<TimeModel> _nameButton2=[
    TimeModel(id: '1',time: '09:00 : 09:30 Am'),
    TimeModel(id: '2',time: '09:30 : 10:00 Am'),
    TimeModel(id: '3',time: '10:00 : 10:30 Am'),
    TimeModel(id: '4',time: '10:30 : 11:00 Am'),
    TimeModel(id: '5',time: '11:00 : 11:30Am'),
    TimeModel(id: '6',time: '11:30 : 12:00 Am'),
    TimeModel(id: '7',time: '12:00 : 01:00 Pm'),
    TimeModel(id: '8',time: '01:00 : 01:30 Pm'),
    TimeModel(id: '9',time: '01:30 : 02:00 Pm'),
    TimeModel(id: '10',time: '02:00 : 02:30 Pm'),
    ];

  final List<TimeModel> timeList=[];



  @override
  void initState() {
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
              centerTitle: true,
              title: Text('Select Time',style: Styles.textStyle12.copyWith(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600
              )),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  const SizedBox(height: 10,),
                  Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Select Hour',style: Styles.textStyle12.copyWith(
                                color:  pColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 18
                            ),),
                            const SizedBox(height: 10,),

                            GroupButton(
                                controller: groupButtonController2,
                                isRadio: false,
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
                                        Text(_nameButton2[index].time??'',style: Styles.textStyle12.copyWith(
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
                                onSelected: (_,index,isSelected){
                                  if(isSelected){
                                    timeList.add(_nameButton2[index]);
                                  }else{
                                    timeList.remove(_nameButton2[index]);
                                  }
                                },
                                buttons:_nameButton2
                            ),


                            const SizedBox(height: 20,),


                            (state is LoadingAddTimeState)?
                            Center(child: CircularProgressIndicator()):
                            InkWell(
                              onTap: (){
                                if(timeList.isNotEmpty){
                                  print('RRFRR');
                                  cubit.addTime(list: timeList);
                                }else{
                                  print('vnjvn');
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: pColor,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Center(
                                  child: Text('Add',style: Styles.textStyle12.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18
                                  ),),
                                ),
                              ),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
          );
        },
        listener: (context,state){

        });
  }
}

class TimeModel{
  String? id;
  String? time;

  TimeModel({this.id,this.time});

  factory TimeModel.jsonDate(date){
    return TimeModel(
      id: date['Id'],
      time: date['Time'],

    );
  }

  Map<String,dynamic> toMap(){
    return {
      'Time':time,
      'Id':id,
    };
  }

}

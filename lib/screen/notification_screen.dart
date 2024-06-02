
import 'package:flutter/material.dart';
import 'package:health_mate_doctor/resourse/resourse.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pColor,
        elevation: 0.0,
        centerTitle: true,
        foregroundColor: Colors.white,
        title: Text('Notifications',style: Styles.textStyle12.copyWith(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600
        )),
      ),
      body:  SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Today',style: Styles.textStyle12.copyWith(
                    color: const Color(0XFF6B7280),
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                )),

                Text('Mark all as read',style: Styles.textStyle12.copyWith(
                    color: const Color(0XFF1C2A3A),
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                )),

              ],
            ),
            const SizedBox(height: 10,),

            ...List.generate(3, (index){
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: pColor.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.calendar_today_rounded,color: Colors.white),
                    ),
                    const SizedBox(width: 20,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Appointment Success',style: Styles.textStyle12.copyWith(
                              color: const Color(0XFF1C2A3A),
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          )),
                          const SizedBox(height: 5,),

                          Text('You have Successfully booked your appointment with Dr Ahmed',style: Styles.textStyle12.copyWith(
                              color: const Color(0XFF6B7280),
                              fontSize: 14,
                              fontWeight: FontWeight.w400
                          )),

                        ],
                      ),
                    )
                  ],
                ),
              );
            }),

            const SizedBox(height: 10,),


            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Yesterday',style: Styles.textStyle12.copyWith(
                    color: const Color(0XFF6B7280),
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                )),

                Text('Mark all as read',style: Styles.textStyle12.copyWith(
                    color: const Color(0XFF1C2A3A),
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                )),

              ],
            ),
            const SizedBox(height: 10,),

            ...List.generate(2, (index){
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: pColor.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.calendar_today_rounded,color: Colors.white),
                    ),
                    const SizedBox(width: 20,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Appointment Success',style: Styles.textStyle12.copyWith(
                              color: const Color(0XFF1C2A3A),
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          )),
                          const SizedBox(height: 5,),

                          Text('You have Successfully booked your appointment with Dr Ahmed',style: Styles.textStyle12.copyWith(
                              color: const Color(0XFF6B7280),
                              fontSize: 14,
                              fontWeight: FontWeight.w400
                          )),

                        ],
                      ),
                    )
                  ],
                ),
              );
            }),


          ],
        ),
      ),
    );
  }
}

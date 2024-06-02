
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_mate_doctor/bloc/app_cubit.dart';
import 'package:health_mate_doctor/screen/appointments_screen.dart';
import 'package:health_mate_doctor/screen/auth/loginpage.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

import 'package:flutter/material.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<splashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {

      if(FirebaseAuth.instance.currentUser!=null){
        BlocProvider.of<AppCubit>(context).getProfileData();
      }
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return FirebaseAuth.instance.currentUser==null? LoginPage():AppointmentsScreen();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(17, 19, 58, 0.882),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          // Health Mate Logo
          const Image(
            image: AssetImage('assets/image/HealthMate_colored_logo.png'),
          ),
          const SizedBox(height: 10),
          SimpleAnimationProgressBar(
            height: 10,
            width: 200,
            backgroundColor: const Color.fromARGB(255, 142, 141, 141),
            foregrondColor: const Color(0xFF55BF98),
            ratio: 0.9,
            direction: Axis.horizontal,
            curve: Curves.decelerate,
            duration: const Duration(seconds: 3),
            borderRadius: BorderRadius.circular(10),

          ),
          const SizedBox(height: 10),
          Image(
            image: const AssetImage('assets/image/Splash_pattern.png'),
            width: MediaQuery.of(context).size.width,
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_mate_doctor/bloc/app_cubit.dart';
import 'package:health_mate_doctor/bloc/app_state.dart';
import 'package:health_mate_doctor/screen/appointments_screen.dart';
import 'package:health_mate_doctor/screen/auth/register.dart';

import '../../resourse/resourse.dart';


class LoginPage extends StatelessWidget {
   LoginPage({super.key});

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
   GlobalKey<FormState> kForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: BlocConsumer<AppCubit,AppState>(
        builder: (context,state){
          var cubit =AppCubit.get(context);
          return SingleChildScrollView(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: kForm,
              child: Column(
                children: [
                  Image.asset(
                    'assets/image/logobackground.png',
                    width: MediaQuery.of(context).size.width,
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: email,
                          validator: (val){
                            if(val!.isEmpty){
                              return 'Please Enter The Email';
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(CupertinoIcons.mail),
                            hintText: 'Email',
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFF55BF98),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.all(12),
                          ),
                        ),

                        const SizedBox(height: 12,),

                        TextFormField(
                          controller: password,
                          validator: (val){
                            if(val!.isEmpty){
                              return 'Please Enter The Password';
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(CupertinoIcons.lock),
                            hintText: 'Password',
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFF55BF98),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.all(12),
                          ),
                        ),// used for Space between content only

                        /*const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'did you forget your password ?',
                            style: TextStyle(
                                color: Color.fromARGB(255, 104, 105, 104),
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),*/


                        const SizedBox(
                          height: 40,
                        ), // used for Space between content only


                        (state is LoadingLoginState)?CircularProgressIndicator():InkWell(
                          onTap: (){
                            if(kForm.currentState!.validate()){
                              cubit.login(email: email.text, password: password.text);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: pColor,
                                borderRadius: BorderRadius.circular(18.5)
                            ),
                            child: Center(
                              child: Text('Login',style: Styles.textStyle12.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18
                              ),),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 104, 105, 104),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              GestureDetector(
                                onTap: ()
                                {
                                  //Navigator.pushNamed(context, 'RegisterPage');
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return RegisterPage();
                                  }));
                                },
                                child: const Text(
                                  " Register",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 31, 160, 31),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context,state){
          if(state is SuccessLoginState){
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
              return  const AppointmentsScreen();
            }),(route) => false,);
          }else if (state is ErrorLoginState){
            Fluttertoast.showToast(
              msg: 'Please Enter Vaild Data',
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.red,
              gravity: ToastGravity.TOP,
              fontSize: 18,
              textColor: Colors.white,
            );
          }

        },
      ),
    );
  }
}

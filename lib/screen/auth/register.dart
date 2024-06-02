

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_mate_doctor/bloc/app_cubit.dart';
import 'package:health_mate_doctor/bloc/app_state.dart';
import 'package:health_mate_doctor/screen/auth/loginpage.dart';

import '../../resourse/resourse.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController phone = TextEditingController();
  GlobalKey<FormState> kForm = GlobalKey<FormState>();

  bool isRoleDoc = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AppCubit,AppState>(
        builder: (context,state){
          var cubit =AppCubit.get(context);
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            child: Form(
              key: kForm,
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/image/RegisterLogo.svg',
                    width: MediaQuery.of(context).size.width,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [

                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: name,
                          keyboardType: TextInputType.name,
                          validator: (val){
                            if(val!.isEmpty){
                              return 'Please Enter The Name';
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(CupertinoIcons.person_2_alt),
                            hintText: 'Name',
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

                        const SizedBox(
                          height: 12,
                        ),

                        TextFormField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (val){
                            if(val!.isEmpty){
                              return 'Please Enter The Email';
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email),
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

                        const SizedBox(
                          height: 12,
                        ),

                        TextFormField(
                          controller: phone,
                          keyboardType: TextInputType.name,
                          validator: (val){
                            if(val!.isEmpty){
                              return 'Please Enter The Phone';
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.phone),
                            hintText: 'Phone',
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

                        const SizedBox(
                          height: 12,
                        ),

                        TextFormField(
                          controller: age,
                          keyboardType: TextInputType.number,
                          validator: (val){
                            if(val!.isEmpty){
                              return 'Please Enter The Age';
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.calendar_month),
                            hintText: 'Age',
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

                        const SizedBox(
                          height: 12,
                        ),

                        TextFormField(
                          controller: password,
                          keyboardType: TextInputType.text,
                          validator: (val){
                            if(val!.isEmpty){
                              return 'Please Enter The Password';
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
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
                        ),

                        const SizedBox(
                          height: 12,
                        ),

                        Row(
                          children: [
                            Checkbox(value: isRoleDoc,
                                onChanged: (val){
                              setState(() {
                                isRoleDoc = val!;
                              });
                                }),
                            SizedBox(width: 5,),

                            Text(
                              "Register To Doctor",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 104, 105, 104),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),



                          ],
                        ),

                        const SizedBox(
                          height: 40,
                        ),

                        (state is LoadingSignUpState)?CircularProgressIndicator():InkWell(
                          onTap: (){
                            if(kForm.currentState!.validate()){
                              cubit.signIn(email: email.text, password: password.text,age: age.text,name: name.text,phone: phone.text,roleDoc: isRoleDoc);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: pColor,
                                borderRadius: BorderRadius.circular(18.5)
                            ),
                            child: Center(
                              child: Text('Register',style: Styles.textStyle12.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18
                              ),),
                            ),
                          ),
                        ),








                        const SizedBox(
                          height: 5,
                        ), // used for Space between content only

                        //Create new account text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 104, 105, 104),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                " Login",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 31, 160, 31),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
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
          if(state is SuccessSignUpState){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
              return LoginPage();
            }),);

          }
          else if(state is ErrorSignUpState){
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
      )
    );
  }
}

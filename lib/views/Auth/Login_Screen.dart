import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:infinity_tow_appliation/Controller/Login_Controller.dart';
import 'package:get/get.dart';
import 'package:infinity_tow_appliation/Utils/constant.dart';
import '../../Utils/imageUtils.dart';
import 'Signup_Screen.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  LoginController logincontroller = Get.find<LoginController>();

  Widget _buildPageContent(BuildContext context) {
    return Container(
      color: Colors.blue.shade100,
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 150.0,
          ),
          _buildLoginForm(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Get.toNamed(ROUTE_REGISTER);
                },
                child: const Text("Sign Up",
                    style: TextStyle(color: Colors.blue, fontSize: 18.0)),
              )
            ],
          )
        ],
      ),
    );
  }

  Container _buildLoginForm() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: RoundedDiagonalPathClipper(),
            child: Container(
              height: 400,
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 90.0,
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        controller: logincontroller.emailText,
                        style: const TextStyle(color: Colors.blue),
                        decoration: InputDecoration(
                            hintText: "Email address",
                            hintStyle: TextStyle(color: Colors.blue.shade200),
                            border: InputBorder.none,
                            icon: const Icon(
                              Icons.email,
                              color: Colors.blue,
                            )),
                      )),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 10.0),
                    child: Divider(
                      color: Colors.blue.shade400,
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        controller: logincontroller.passwordText,
                        style: const TextStyle(color: Colors.blue),
                        decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.blue.shade200),
                            border: InputBorder.none,
                            icon: const Icon(
                              Icons.lock,
                              color: Colors.blue,
                            )),
                      )),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 10.0),
                    child: Divider(
                      color: Colors.blue.shade400,
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: <Widget>[
                  //     Container(
                  //         padding: const EdgeInsets.only(right: 20.0),
                  //         child: const Text(
                  //           "Forgot Password",
                  //           style: TextStyle(color: Colors.black45),
                  //         ))
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 10.0,
                  // ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 45.0,
                backgroundColor: Colors.white,
                child: SizedBox(
                  height: 50,
                  width: 70,
                  child: Image.asset(splashBg),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 420,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GetBuilder<LoginController>(
                init: LoginController(),
                builder: ((controller) {
                  if (controller.isLoading.value) {
                    return const CircularProgressIndicator();
                  } else {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0)),
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        controller.loginApiDio();
                      },
                      child: const Text("Login",
                          style: TextStyle(color: Colors.white70)),
                    );
                  }
                }),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageContent(context),
    );
  }
}

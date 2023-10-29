import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/colorUtils.dart';
import '../Utils/constant.dart';
import '../Utils/imageUtils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  Animation? _logoAnimation;
  AnimationController? _logoAnimationController;
  SharedPreferences? _prefs;
  bool _isLoggedIn = false;
  final bool _initialized = false;
  final bool _error = false;
  String? errorMsg;
  @override
  void initState() {
    super.initState();

    _logoAnimationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _logoAnimation = Tween(begin: 0.0, end: 200.0).animate(CurvedAnimation(
        curve: Curves.bounceOut, parent: _logoAnimationController!));

    _logoAnimationController!.addStatusListener((AnimationStatus status) {});
    _logoAnimationController!.forward();

    //initializeFlutterFire();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, navigationPage);
  }

  void navigationPage() async {
    _prefs = await SharedPreferences.getInstance();
    _isLoggedIn = _prefs!.getBool('isLoggedIn') ?? false;
    if (_isLoggedIn) {
      Get.offAllNamed(ROUTE_HOME);
    } else {
      Get.offAllNamed(ROUTE_LOGIN);
    }
  }

  @override
  void dispose() {
    super.dispose();
    //SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    _logoAnimationController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(color: logoColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            secondChild(),
          ],
        ),
      ),
    );
  }

  Widget secondChild() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final portraitHeight = screenHeight * 0.2;
    final portraitWidth = screenHeight * 0.3;
    final landscapeHeight = screenHeight * 0.4;

    final landscapeWidth = screenWidth * 0.4;

    return AnimatedBuilder(
      animation: _logoAnimationController!,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.only(left: 30, right: 20, bottom: 5),
          width: MediaQuery.of(context).orientation == Orientation.portrait
              ? portraitWidth
              : landscapeWidth,
          height: MediaQuery.of(context).orientation == Orientation.portrait
              ? portraitHeight
              : landscapeHeight,
          child: Center(
            child: Image.asset(
              splashBg,
              width: double.infinity,
              height: MediaQuery.of(context).orientation == Orientation.portrait
                  ? portraitHeight
                  : landscapeHeight,
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    );
  }
}

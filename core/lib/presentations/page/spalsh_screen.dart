import 'dart:async';

import 'package:core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:movies/presentation/pages/home_movie_page.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash_screen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() {
    var _duration = const Duration(seconds: 2);
    return Timer(_duration, navigationRoute);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  void navigationRoute() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const HomeMoviePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kRichBlack,
        body: Center(child: Center(child: Image.asset('assets/muse.png'))));
  }
}

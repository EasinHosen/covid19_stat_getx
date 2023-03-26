import 'dart:async';
import 'dart:math';

import 'package:covid19_stat/constants/page_const.dart';
import 'package:covid19_stat/controllers/rest_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>
    with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();

  @override
  void initState() {
    // TODO: implement initState
    Timer(
      const Duration(seconds: 5),
      () => Get.offNamed(pageWorldStat),
    );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animationController,
              child: const SizedBox(
                height: 200,
                width: 200,
                child: Center(
                  child: Image(
                    image: AssetImage('assets/images/virus.png'),
                  ),
                ),
              ),
              builder: (context, child) {
                return Transform.rotate(
                  angle: _animationController.value * 2.0 * pi,
                  child: child,
                );
              },
            ),
            SizedBox(
              height: Get.height * 0.08,
            ),
            const Center(
              child: Text(
                'Covid19\nStatistics',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

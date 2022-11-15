import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/services/navigation/navigation_service.dart';
import '../../../locator.dart';
import '../../router.gr.dart';

class StartUpView extends StatefulWidget {
  @override
  State<StartUpView> createState() => _StartUpViewState();
}

class _StartUpViewState extends State<StartUpView> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  Future<Timer> startTime() async {
    var duration = Duration(seconds: 1);
    return Timer(duration, route);
  }

  void route() {
    locator<NavigationService>()
        .popAllAndPushNamed(MainPageViewRoute(), context);
  }

  Widget initScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              child: Image.asset(
                'assets/images/popcorn.png',
                width: 75.w,
                height: 75.w,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(
              color: Theme.of(context).colorScheme.onPrimary,
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }
}

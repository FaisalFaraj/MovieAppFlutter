import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:sizer/sizer.dart';

import '../../../core/services/navigation/navigation_service.dart';
import '../../../locator.dart';
import '../../router.gr.dart';

class OnboardingPageView extends StatefulWidget {
  OnboardingPageView();

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingPageView> {
  @override
  void didUpdateWidget(OnboardingPageView oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  // final _log = Logger('OnboardingPageView');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingSlider(
        onFinish: () async {
          Future<void> loadHome() async {
            await locator<NavigationService>()
                .popAllAndPushNamed(MainPageViewRoute(), context);
          }

          await loadHome();
        },
        pageBackgroundColor: Colors.black,
        headerBackgroundColor: Colors.black,
        finishButtonText: 'تسجيل',
        skipTextButton: Text('تخطي',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary, height: 20.h)),
        trailing: Text(
          'دخول',
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary, fontSize: 20.sp),
        ),
        background: [
          Container(
            color: Theme.of(context).colorScheme.primary,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/images/onboarding_image.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Container(
            color: Theme.of(context).colorScheme.primary,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ],
        totalPage: 2,
        speed: 1.8,
        pageBodies: [
          Container(
            padding: EdgeInsets.only(left: 100, top: 20),
            alignment: Alignment.topCenter,
            child: Row(
              children: [
                Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 45,
                ),
                SizedBox(
                  width: 30,
                ),
                Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 45,
                ),
                SizedBox(
                  width: 30,
                ),
                Icon(
                  Icons.notifications,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 45,
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: Text('تابع اخر الافلام',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 35.sp)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Text(
                      'استمتع بمنصة افلام لمتابعة و مشاهدة افلامك  \nالمفضلة',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 20.sp)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Container(
                    height: 300,
                    child: Image.asset('assets/images/popcorn.png',
                        fit: BoxFit.fill),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

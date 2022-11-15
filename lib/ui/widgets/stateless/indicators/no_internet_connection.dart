import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constant/asset_images.dart';

class NoInternetConnection extends StatefulWidget {
  const NoInternetConnection({Key? key}) : super(key: key);

  @override
  _NoInternetConnectionState createState() => _NoInternetConnectionState();
}

class _NoInternetConnectionState extends State<NoInternetConnection> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 50.w,
          height: 50.h,
          child: Column(
            children: [
              Image.asset(
                AssetImages.no_internet_gif,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                AppLocalizations.of(context)!.not_internet_connection,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal),
              ),
            ],
          )),
    );
  }
}

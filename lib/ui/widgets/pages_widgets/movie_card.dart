import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp_flutter/core/services/navigation/navigation_service.dart';
import 'package:movieapp_flutter/locator.dart';
import 'package:rate/rate.dart';
import 'package:sizer/sizer.dart';
import 'package:movieapp_flutter/ui/router.gr.dart';

import '../../../core/models/movie/movie.dart';

// ignore: must_be_immutable
class MovieCard extends StatelessWidget {
  late Movie movie;
  MovieCard(this.movie);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            locator<NavigationService>()
                .pushNamed(MoviePageViewRoute(movie: movie), context);
          },
          child: Container(
              width: 27.w,
              height: 18.h,
              child: CachedNetworkImage(
                  imageUrl: movie.thumb!,
                  imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                              bottom: Radius.circular(20)),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                  placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.onPrimary,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                      ),
                  errorWidget: (context, url, error) =>
                      Center(child: Icon(Icons.error)))),
        ),
        SizedBox(
          height: 1.h,
        ),
        Container(
          width: 27.w,
          child: Text(
            movie.title!,
            maxLines: 1,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                height: 1.4,
                fontSize: 10.0.sp),
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        Rate(
          iconSize: 9.sp,
          color: Theme.of(context).colorScheme.secondary,
          allowHalf: true,
          allowClear: true,
          initialValue: movie.avg_rate != null
              ? movie.avg_rate!.toDouble()
              : Random().nextInt(5).toDouble(),
          readOnly: true,
          onChange: (rating) {},
        ),
      ],
    );
  }
}

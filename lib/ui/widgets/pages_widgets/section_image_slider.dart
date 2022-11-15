import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp_flutter/core/services/navigation/navigation_service.dart';
import 'package:movieapp_flutter/locator.dart';
import 'package:rate/rate.dart';
import 'package:sizer/sizer.dart';

import '../../../core/models/movie/movie.dart';
import 'package:movieapp_flutter/ui/router.gr.dart';

class SecImageSlider extends StatelessWidget {
  final String section;
  final List<Movie> section_movies;
  SecImageSlider(this.section, this.section_movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h,
      width: MediaQuery.of(context).size.width,
      // padding: EdgeInsets.only(bottom: 10, top: 10),
      child: Column(
        children: [
          Container(
            height: 6.h,
            alignment: AlignmentDirectional.topStart,
            child: Text(
              section.replaceFirst(section[0], section[0].toUpperCase()),
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal),
            ),
          ),
          Container(
            height: 14.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: ScrollController(),
              itemCount: section_movies.toList().length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsetsDirectional.only(end: 15.0),
                  child: SizedBox(
                    height: 17.h,
                    width: 20.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            locator<NavigationService>().pushNamed(
                                MoviePageViewRoute(
                                    movie: section_movies[index]),
                                context);
                          },
                          child: Container(
                              height: 10.h,
                              child: CachedNetworkImage(
                                  imageUrl: section_movies[index].thumb!,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20),
                                              bottom: Radius.circular(20)),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                  placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                  errorWidget: (context, url, error) =>
                                      Center(child: Icon(Icons.error)))),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Text(
                            section_movies[index].title!,
                            maxLines: 1,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                                fontSize: 7.sp),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Rate(
                          iconSize: 5.sp,
                          color: Theme.of(context).colorScheme.secondary,
                          allowHalf: true,
                          allowClear: true,
                          initialValue: section_movies[index].avg_rate != null
                              ? section_movies[index].avg_rate!.toDouble()
                              : Random().nextInt(5).toDouble(),
                          readOnly: true,
                          onChange: (value) {},
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

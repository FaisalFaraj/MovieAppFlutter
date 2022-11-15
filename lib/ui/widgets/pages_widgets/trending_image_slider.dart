import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movieapp_flutter/core/services/navigation/navigation_service.dart';
import 'package:movieapp_flutter/locator.dart';
import 'package:movieapp_flutter/ui/router.gr.dart';
import 'package:rate/rate.dart';
import 'package:sizer/sizer.dart';

import '../../../core/models/movie/movie.dart';

class TreImageSlider extends StatelessWidget {
  final List<Movie> movies_trend;
  TreImageSlider(this.movies_trend);

  @override
  Widget build(BuildContext context) {
    List movies_list_shuffle = movies_trend..shuffle();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 30.h,
      child: CarouselSlider(
        options: CarouselOptions(
          padEnds: false,
          autoPlay: false,
          enlargeCenterPage: true,
          disableCenter: true,
          height: 255,
          enableInfiniteScroll: false,
          viewportFraction: 0.5,
        ),
        items: movies_list_shuffle.map<Widget>((i) {
          return Builder(
            builder: (BuildContext context) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      locator<NavigationService>()
                          .pushNamed(MoviePageViewRoute(movie: i!), context);
                    },
                    child: Container(
                        height: 20.h,
                        child: CachedNetworkImage(
                            imageUrl: i.thumb!,
                            imageBuilder: (context, imageProvider) => Container(
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
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
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
                    color: Theme.of(context).colorScheme.primary,
                    child: Text(
                      i.title!,
                      maxLines: 1,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    color: Theme.of(context).colorScheme.primary,
                    child: Rate(
                      iconSize: 14.sp,
                      color: Theme.of(context).colorScheme.secondary,
                      allowHalf: true,
                      allowClear: true,
                      initialValue: i.avg_rate != null
                          ? i.avg_rate!.toDouble()
                          : Random().nextInt(5).toDouble(),
                      readOnly: true,
                      onChange: (rating) {},
                    ),
                  ),
                ],
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

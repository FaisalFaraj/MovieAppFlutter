import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/models/actor/actor.dart';

class ActorsImageSlider extends StatelessWidget {
  final List<Actor> Cast;
  ActorsImageSlider(this.Cast);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 14.h,
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Cast.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: 17.w,
                            height: 9.h,
                            child: CachedNetworkImage(
                                imageUrl: Cast[index].thumb!,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(10),
                                            bottom: Radius.circular(10)),
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
                        SizedBox(
                          height: 1.h,
                        ),
                        Container(
                          width: 17.w,
                          child: Text(
                            Cast[index].name!,
                            maxLines: 2,
                            style: TextStyle(
                                height: 1.2,
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                                fontSize: 8.0.sp),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

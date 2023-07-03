import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:sizer/sizer.dart';

class CarouselHome extends StatefulWidget {
  const CarouselHome({super.key});

  @override
  State<CarouselHome> createState() => _CarouselHomeState();
}

class _CarouselHomeState extends State<CarouselHome> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.625.h),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [buttonColor1, buttonColor2],
                  )),
              height: 14.375.h,
              child: Center(
                child: Text(
                  "Item 1",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: backgroundColor1, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.625.h),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [buttonColor1, buttonColor2],
                  )),
              height: 14.375.h,
              child: Center(
                child: Text(
                  "Item 2",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: backgroundColor1, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.625.h),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [buttonColor1, buttonColor2],
                  )),
              height: 14.375.h,
              child: Center(
                child: Text(
                  "Item 3",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: backgroundColor1, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
        options: CarouselOptions(
            autoPlay: true,
            viewportFraction: 0.8,
            aspectRatio: 2.5,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            onPageChanged: (index, reason) {
              // code here to perform any action when page changes
            }));
  }
}

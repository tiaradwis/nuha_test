import 'package:flutter/material.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fa6_solid.dart';

class ProgressBarView extends StatelessWidget {
  ProgressBarView({this.value});
  final value;
  final _iconSize = 3.5.h;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 2, right: 2),
      child: Stack(fit: StackFit.loose, children: [
        // LinearProgressIndicator(
        //     value: value,
        //     valueColor: AlwaysStoppedAnimation<Color>(buttonColor1),
        //     backgroundColor: grey100,
        //     minHeight: 40),
        Container(
          height: 5.h,
          child: LinearPercentIndicator(
            barRadius: const Radius.circular(40),
            // width: 75.55556.w,
            lineHeight: 2.5.h,
            percent: value,
            backgroundColor: backBar,
            progressColor: buttonColor2,
          ),
        ),

        LayoutBuilder(builder: (context, constrains) {
          // //5 is just the right padding
          // print(constrains.maxWidth);
          var leftPadding = constrains.maxWidth * value - _iconSize;
          // var topPadding = (constrains.maxHeight - _iconSize) / 2;
          return Padding(
            padding: EdgeInsets.only(
              left: leftPadding,
            ),
            child: Iconify(
              Fa6Solid.person_running,
              size: _iconSize.toDouble(),
              color: buttonColor1,
            ),
          );
        }),
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:nuha/app/constant/styles.dart';

class FieldNumber extends StatelessWidget {
  final String labelText;
  final TextEditingController contr;
  final String hintText;

  const FieldNumber(
      {Key? key,
      required this.labelText,
      required this.contr,
      required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: grey900,
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(
          height: 0.75.h,
        ),
        SizedBox(
          height: 5.5.h,
          child: TextField(
            controller: contr,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: grey900,
                ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: grey400,
                  ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 4.583333.w, vertical: 1.h),
              labelStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: grey400, fontWeight: FontWeight.bold),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                borderSide: BorderSide(color: grey100, width: 1),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                borderSide: BorderSide(color: grey100, width: 1),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                borderSide: BorderSide(color: buttonColor1, width: 2),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 1.5.h,
        ),
      ],
    );
  }
}

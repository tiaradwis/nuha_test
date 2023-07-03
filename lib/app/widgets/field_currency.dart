import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:sizer/sizer.dart';
import 'package:nuha/app/constant/styles.dart';

class FieldCurrency extends StatelessWidget {
  final String labelText;
  final TextEditingController contr;
  final String infoText;

  const FieldCurrency(
      {Key? key,
      required this.labelText,
      required this.contr,
      required this.infoText})
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
            inputFormatters: <TextInputFormatter>[
              CurrencyTextInputFormatter(
                locale: 'id',
                decimalDigits: 0,
                symbol: '',
              ),
            ],
            controller: contr,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: grey900,
                ),
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 2.222.w, vertical: 1.h),
                child: Text(
                  "Rp. ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: grey400, fontWeight: FontWeight.bold),
                ),
              ),
              prefixIconConstraints:
                  const BoxConstraints(minWidth: 0, minHeight: 0),
              suffixIcon: PopupMenuButton(
                icon: Iconify(
                  MaterialSymbols.info_outline,
                  color: grey400,
                  size: 12.sp,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text(
                      infoText,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: grey900,
                          ),
                    ),
                  ),
                ],
                offset: Offset(-1.38889.w, 4.375.h),
                shape: const TooltipShape(),
              ),
              hintText: "0",
              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: grey400,
                  ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 2.222.w, vertical: 1.h),
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

class TooltipShape extends ShapeBorder {
  const TooltipShape();

  final BorderSide _side = BorderSide.none;
  final BorderRadiusGeometry _borderRadius = BorderRadius.zero;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(_side.width);

  @override
  Path getInnerPath(
    Rect rect, {
    TextDirection? textDirection,
  }) {
    final Path path = Path();

    path.addRRect(
      _borderRadius.resolve(textDirection).toRRect(rect).deflate(_side.width),
    );

    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();
    final RRect rrect = _borderRadius.resolve(textDirection).toRRect(rect);

    path.moveTo(0, 10);
    path.quadraticBezierTo(0, 0, 10, 0);
    path.lineTo(rrect.width - 30, 0);
    path.lineTo(rrect.width - 20, -10);
    path.lineTo(rrect.width - 10, 0);
    path.quadraticBezierTo(rrect.width, 0, rrect.width, 10);
    path.lineTo(rrect.width, rrect.height - 10);
    path.quadraticBezierTo(
        rrect.width, rrect.height, rrect.width - 10, rrect.height);
    path.lineTo(10, rrect.height);
    path.quadraticBezierTo(0, rrect.height, 0, rrect.height - 10);

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => RoundedRectangleBorder(
        side: _side.scale(t),
        borderRadius: _borderRadius * t,
      );
}

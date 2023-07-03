import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/cashflow/controllers/anggaran_edit_controller.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'package:sizer/sizer.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class UpdateAnggaranView extends GetView<AnggaranEditController> {
  final String id;

  UpdateAnggaranView({Key? key, required this.id}) : super(key: key);
  final c = Get.find<AnggaranEditController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Edit Anggaran",
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: dark,
              ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: titleColor,
            size: 18.sp,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
              onPressed: () => PersistentNavBarNavigator.pushDynamicScreen(
                  context,
                  screen: showDeleteAnggaranDialog(context, id)),
              icon: Icon(
                Icons.delete,
                size: 18.sp,
                color: titleColor,
              ))
        ],
        backgroundColor: backgroundColor1,
        elevation: 0,
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
          future: controller.getAnggaranById(id.toString()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data == null) {
              return const Center(
                child: Text("Tidak dapat mengambil informasi data"),
              );
            } else {
              // print(snapshot.data);
              controller.kategoriC.value = snapshot.data!["kategori"];
              // c.nomAnggaranC.text = snapshot.data!["nominal"].toString();
              controller.nomAnggaranC.text = NumberFormat.currency(
                      locale: 'id', symbol: "", decimalDigits: 0)
                  .format(snapshot.data!["nominal"]);

              return SingleChildScrollView(
                  child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: backgroundColor1),
                margin: EdgeInsets.symmetric(
                  horizontal: 7.77778.w,
                  vertical: 3.5.h,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 5.55556.w,
                  vertical: 2.5.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Kategori*",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: grey900,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        SizedBox(
                          height: 0.75.h,
                        ),
                        Container(
                          height: 5.5.h,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1.sp, color: grey100),
                              borderRadius: BorderRadius.circular(20),
                              color: backgroundColor1),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.53333.w,
                              vertical: 1.h,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(controller.kategoriC.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: grey900,
                                        )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nominal Anggaran*",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
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
                            controller: controller.nomAnggaranC,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              CurrencyTextInputFormatter(
                                locale: 'id',
                                decimalDigits: 0,
                                symbol: '',
                              ),
                            ],
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: grey900,
                                ),
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding:
                                    EdgeInsets.fromLTRB(4.5833.w, 1.h, 0, 1.h),
                                child: Text(
                                  "Rp. ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: grey400),
                                ),
                              ),
                              prefixIconConstraints: const BoxConstraints(
                                  minWidth: 0, minHeight: 0),
                              hintText: "0",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: grey400,
                                  ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 1.w, vertical: 1.h),
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: grey400,
                                      fontWeight: FontWeight.bold),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                borderSide:
                                    BorderSide(color: grey100, width: 1.sp),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                borderSide: BorderSide(
                                    color: buttonColor1, width: 1.sp),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 41.125.h,
                    ),
                    SizedBox(
                      width: 75.55556.w,
                      height: 5.5.h,
                      child: Obx(() => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: buttonColor2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            child: Text(
                              controller.isLoading.isFalse
                                  ? "Simpan"
                                  : "Loading...",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: backgroundColor1),
                            ),
                            onPressed: () {
                              if (controller.isLoading.isFalse) {
                                controller.updateAnggaranById(
                                    context, id.toString());
                              }
                            },
                          )),
                    ),
                  ],
                ),
              ));
            }
          }),
    );
  }
}

showDeleteAnggaranDialog(BuildContext context, docId) {
  final controller = Get.find<AnggaranEditController>();
  // set up the buttons
  Widget batalButton = ElevatedButton(
    style: ElevatedButton.styleFrom(
        elevation: 0,
        side: const BorderSide(width: 1, color: buttonColor2),
        backgroundColor: backgroundColor1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
    child: Text(
      "Batal",
      style:
          Theme.of(context).textTheme.bodyMedium!.copyWith(color: buttonColor2),
    ),
    onPressed: () => Get.back(),
  );
  Widget yaButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      child: Text(
        "Ya",
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: backgroundColor1),
      ),
      onPressed: () {
        // print(docId);
        if (controller.isLoading.isFalse) {
          controller.deleteAnggaranById(context, docId);
        }
      });

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Apakah kamu yakin ingin menghapus anggaran ini?",
      style: Theme.of(context)
          .textTheme
          .headlineMedium!
          .copyWith(color: grey900, fontWeight: FontWeight.w600),
    ),
    titlePadding: EdgeInsets.fromLTRB(7.777778.w, 3.5.h, 7.777778.w, 0.25.h),
    content: Text(
      "Dengan menyetujui ini, maka anggaran ini akan terhapus secara permanen. Apakah kamu yakin?",
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: grey400,
          ),
    ),
    contentPadding: EdgeInsets.symmetric(
      horizontal: 7.777778.w,
    ),
    actions: [
      batalButton,
      yaButton,
    ],
  );
  // show the dialog

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/gridicons.dart';
import 'package:sizer/sizer.dart';
import 'package:nuha/app/modules/cashflow/controllers/anggaran_create_controller.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class FormAnggaranView extends GetView<AnggaranCreateController> {
  FormAnggaranView({Key? key}) : super(key: key);

  final c = Get.find<AnggaranCreateController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Tambah Anggaran",
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
        backgroundColor: backgroundColor1,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: backgroundColor1),
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
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
                  child: GestureDetector(
                    onTap: () {
                      Get.bottomSheet(const BottomSheetPengeluaran());
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.53333.w,
                        vertical: 1.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => Text(controller.kategoriC.toString(),
                                style:
                                    controller.kategoriStat.value == "choosen"
                                        ? Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: grey900,
                                            )
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: grey400)),
                          ),
                          Iconify(
                            Gridicons.dropdown,
                            size: 18.sp,
                            color: controller.kategoriStat.value == "choosen"
                                ? grey900
                                : grey400,
                          )
                        ],
                      ),
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
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: grey900,
                        ),
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.fromLTRB(4.5833.w, 1.h, 0, 1.h),
                        child: Text(
                          "Rp. ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: grey400),
                        ),
                      ),
                      prefixIconConstraints:
                          const BoxConstraints(minWidth: 0, minHeight: 0),
                      hintText: "0",
                      hintStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: grey400,
                              ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                      labelStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                              color: grey400, fontWeight: FontWeight.bold),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        borderSide: BorderSide(color: grey100, width: 1.sp),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        borderSide:
                            BorderSide(color: buttonColor1, width: 1.sp),
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
                      controller.isLoading.isFalse ? "Simpan" : "Loading...",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: backgroundColor1),
                    ),
                    onPressed: () {
                      if (controller.isLoading.isFalse) {
                        controller.addAnggaran(context);
                      }
                    },
                  )),
            ),
          ],
        ),
      )),
    );
  }
}

class BottomSheetPengeluaran extends StatelessWidget {
  const BottomSheetPengeluaran({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 3.125.h, horizontal: 7.77778.w),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          color: backgroundColor1,
        ),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Pilih Kategori Pengeluaran",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: grey900, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Divider(
              color: grey50,
              thickness: 1,
              indent: 4.w,
              endIndent: 4.w,
            ),
            SizedBox(
              height: 2.5.h,
            ),
            Text(
              "Kategori Umum",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: buttonColor1, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 1.25.h,
            ),
            Wrap(
              spacing: 4.166667.w,
              runSpacing: 2.5.h,
              children: [
                CategoryAnggaranWidget(
                  image: const AssetImage('assets/images/Asuransi.png'),
                  text: "Asuransi",
                ),
                CategoryAnggaranWidget(
                    image: const AssetImage('assets/images/Pendidikan.png'),
                    text: "Pendidikan"),
                CategoryAnggaranWidget(
                    image: const AssetImage('assets/images/Transportasi.png'),
                    text: "Transportasi"),
                CategoryAnggaranWidget(
                    image: const AssetImage('assets/images/Sosial.png'),
                    text: "Sosial")
              ],
            ),
            SizedBox(
              height: 2.5.h,
            ),
            Text(
              "Kategori Biaya Hidup",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: buttonColor1, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 1.25.h,
            ),
            Wrap(
              spacing: 4.166667.w,
              runSpacing: 2.5.h,
              children: [
                CategoryAnggaranWidget(
                  image: const AssetImage('assets/images/Makan.png'),
                  text: "Makan",
                ),
                CategoryAnggaranWidget(
                  image: const AssetImage('assets/images/Belanja.png'),
                  text: "Belanja",
                ),
                CategoryAnggaranWidget(
                  image: const AssetImage('assets/images/Hiburan.png'),
                  text: "Hiburan",
                ),
                CategoryAnggaranWidget(
                    image: const AssetImage('assets/images/Tagihan.png'),
                    text: "Tagihan"),
                CategoryAnggaranWidget(
                    image: const AssetImage('assets/images/Kesehatan.png'),
                    text: "Kesehatan")
              ],
            ),
            SizedBox(
              height: 2.5.h,
            ),
            Text(
              "Kategori Lainnya",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: buttonColor1, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 1.25.h,
            ),
            Wrap(
              spacing: 4.166667.w,
              runSpacing: 2.5.h,
              children: [
                CategoryAnggaranWidget(
                  image: const AssetImage('assets/images/Lainnya.png'),
                  text: "Lainnya",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CategoryAnggaranWidget extends StatelessWidget {
  final ImageProvider image;
  final String text;

  CategoryAnggaranWidget({Key? key, required this.image, required this.text})
      : super(key: key);

  final AnggaranCreateController controller =
      Get.put(AnggaranCreateController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 25.27778.w,
      child: GestureDetector(
        onTap: () {
          Get.find<AnggaranCreateController>().checkAnggaranKategori(text);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: image,
              width: 36.sp,
              height: 36.sp,
              // fit: BoxFit.cover,
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: grey500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

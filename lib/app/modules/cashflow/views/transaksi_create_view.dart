import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/gridicons.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:sizer/sizer.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:intl/intl.dart';
import 'package:nuha/app/modules/cashflow/controllers/transaksi_create_controller.dart';

class FormTransaksiView extends GetView<TransaksiCreateController> {
  FormTransaksiView({Key? key}) : super(key: key);

  @override
  final controller = Get.find<TransaksiCreateController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor2,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Tambah Transaksi",
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
              onPressed: () => Navigator.pop(context)),
          backgroundColor: backgroundColor1,
          elevation: 0,
        ),
        body: SingleChildScrollView(
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
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Jenis Transaksi*",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: grey900,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(
                      height: 0.75.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.defaultDialog(
                          radius: 25,
                          title: "Pilih Jenis Transaksi",
                          titleStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: grey900, fontWeight: FontWeight.w600),
                          content: const DialogContent(),
                        );
                      },
                      child: Container(
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
                              Obx(() => Text(
                                    controller.jenisC.value,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: grey900,
                                        ),
                                  )),
                              Iconify(
                                Gridicons.dropdown,
                                size: 18.sp,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama Transaksi*",
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
                        controller: controller.namaTransaksiC,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: grey900,
                            ),
                        decoration: InputDecoration(
                          hintText: "Masukan Nama Transaksi",
                          hintStyle:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: grey400,
                                  ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 4.53333.w,
                            vertical: 1.h,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            borderSide: BorderSide(width: 1.sp, color: grey100),
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
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nominal Transaksi*",
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
                        controller: controller.nominalTransaksiC,
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
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 1.w, vertical: 1.h),
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
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
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
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
                          Get.bottomSheet(
                            controller.jenisC.value == "Pengeluaran"
                                ? BottomSheetPengeluaran()
                                : const BottomSheetPendapatan(),
                          );
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
                                    style: controller.kategoriStat.value ==
                                            "choosen"
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
                                color:
                                    controller.kategoriStat.value == "choosen"
                                        ? grey900
                                        : grey400,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tanggal*",
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
                          controller.chooseDate();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.53333.w,
                            vertical: 1.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() => Text(
                                    DateFormat("dd-MM-yyyy")
                                        .format(controller.selectDate.value)
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: grey900,
                                        ),
                                  )),
                              Iconify(
                                MaterialSymbols.calendar_month,
                                size: 18.sp,
                                color: grey900,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Deskripsi",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: grey900,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(
                      height: 0.75.h,
                    ),
                    SizedBox(
                      height: 14.875.h,
                      child: TextField(
                        controller: controller.deskripsiC,
                        minLines: 5,
                        maxLines: null,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: grey900,
                            ),
                        decoration: InputDecoration(
                          hintText: "Tulis deskripsi...",
                          hintStyle:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: grey400,
                                  ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 4.53333.w,
                            vertical: 1.h,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            borderSide: BorderSide(width: 1.sp, color: grey100),
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
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Unggah Foto",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: grey900,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(
                      height: 0.75.h,
                    ),
                    GetBuilder<TransaksiCreateController>(
                      builder: (c) {
                        return c.image != null
                            ? Stack(
                                children: <Widget>[
                                  Container(
                                    width: 75.55556.w,
                                    height: 14.875.h,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.sp, color: grey100),
                                        borderRadius: BorderRadius.circular(20),
                                        color: backgroundColor1),
                                    child: FullScreenWidget(
                                      disposeLevel: DisposeLevel.Medium,
                                      child: Image(
                                        fit: BoxFit.fitWidth,
                                        image: FileImage(
                                          File(c.image!.path),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      onPressed: () => c.resetImageTransaksi(),
                                      icon: Iconify(
                                        MaterialSymbols.cancel_outline_rounded,
                                        size: 20.sp,
                                        color: backgroundColor2,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : GestureDetector(
                                onTap: () => Get.defaultDialog(
                                  radius: 25,
                                  title: "Unggah Foto",
                                  titleStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: grey900,
                                          fontWeight: FontWeight.w600),
                                  content: DialogCamera(),
                                ),
                                child: Container(
                                  height: 11.375.h,
                                  width: 75.55556.w,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.sp, color: grey100),
                                      borderRadius: BorderRadius.circular(20),
                                      color: backgroundColor1),
                                  child: Center(
                                    child: Iconify(
                                      MaterialSymbols.photo_sharp,
                                      size: 18.sp,
                                      color: grey400,
                                    ),
                                  ),
                                ),
                              );
                      },
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                  ],
                ),
                SizedBox(
                  width: 75.55556.w,
                  height: 5.5.h,
                  child: Obx(
                    () => ElevatedButton(
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
                          controller.addTransaksi(context);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class DialogContent extends StatelessWidget {
  const DialogContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Divider(
            color: grey400,
            thickness: 1,
            indent: 4.w,
            endIndent: 4.w,
          ),
          TextButton(
            onPressed: () {
              Get.find<TransaksiCreateController>().updateToPengeluaran();
            },
            child: Text(
              "Pengeluaran",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: grey900,
                  ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.find<TransaksiCreateController>().updateToPendapatan();
            },
            child: Text(
              "Pendapatan",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: grey900,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class DialogCamera extends StatelessWidget {
  DialogCamera({super.key});

  final TransaksiCreateController controller =
      Get.put(TransaksiCreateController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Divider(
            color: grey400,
            thickness: 1,
            indent: 4.w,
            endIndent: 4.w,
          ),
          TextButton(
            onPressed: () => Get.to(controller.pickImageTransaksi("kamera")),
            child: Text(
              "Kamera",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: grey900,
                  ),
            ),
          ),
          TextButton(
            onPressed: () => Get.to(controller.pickImageTransaksi("galeri")),
            child: Text(
              "Galeri",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: grey900,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomSheetPendapatan extends StatelessWidget {
  const BottomSheetPendapatan({super.key});

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Pilih Kategori Pendapatan",
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
              "Kategori Pendapatan",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: buttonColor1, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 2.5.h,
            ),
            Wrap(
              spacing: 4.166667.w,
              runSpacing: 2.5.h,
              children: const [
                CategoryWidget(
                    image: AssetImage('assets/images/Gaji.png'), text: "Gaji"),
                CategoryWidget(
                    image: AssetImage('assets/images/Bonus.png'),
                    text: "Bonus"),
                CategoryWidget(
                    image: AssetImage('assets/images/Investasi.png'),
                    text: "Investasi"),
                CategoryWidget(
                    image: AssetImage('assets/images/Lainnya.png'),
                    text: "Lainnya")
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BottomSheetPengeluaran extends StatelessWidget {
  BottomSheetPengeluaran({super.key});

  final c = Get.find<TransaksiCreateController>();

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
              children: const [
                CategoryWidget(
                  image: AssetImage('assets/images/Asuransi.png'),
                  text: "Asuransi",
                ),
                CategoryWidget(
                    image: AssetImage('assets/images/Pendidikan.png'),
                    text: "Pendidikan"),
                CategoryWidget(
                    image: AssetImage('assets/images/Transportasi.png'),
                    text: "Transportasi"),
                CategoryWidget(
                    image: AssetImage('assets/images/Sosial.png'),
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
              children: const [
                CategoryWidget(
                  image: AssetImage('assets/images/Makan.png'),
                  text: "Makan",
                ),
                CategoryWidget(
                    image: AssetImage('assets/images/Belanja.png'),
                    text: "Belanja"),
                CategoryWidget(
                    image: AssetImage('assets/images/Hiburan.png'),
                    text: "Hiburan"),
                CategoryWidget(
                    image: AssetImage('assets/images/Tagihan.png'),
                    text: "Tagihan"),
                CategoryWidget(
                    image: AssetImage('assets/images/Kesehatan.png'),
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
                const CategoryWidget(
                  image: AssetImage('assets/images/Lainnya.png'),
                  text: "Lainnya",
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: c.streamData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasData) {
                        List<DocumentSnapshot> documents = snapshot.data!.docs;
                        List<Map<String, dynamic>> data = documents
                            .map((doc) => doc.data() as Map<String, dynamic>)
                            .toList();

                        return Wrap(
                          spacing: 4.166667.w,
                          runSpacing: 2.5.h,
                          children: List.generate(
                            data.length,
                            (index) => CategoryWidget(
                              image: AssetImage(
                                  'assets/images/${data[index]["kategori"]}.png'),
                              text: data[index]['kategori'],
                            ),
                          ),
                        );
                      }

                      return const SizedBox();
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  final ImageProvider image;
  final String text;

  const CategoryWidget({Key? key, required this.image, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 25.27778.w,
      child: GestureDetector(
        onTap: () {
          Get.find<TransaksiCreateController>().updateKategori(text);
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/uil.dart';
import 'package:nuha/app/modules/cashflow/controllers/anggaran_detail_controller.dart';
import 'package:nuha/app/modules/cashflow/controllers/transaksi_create_controller.dart';
import 'package:nuha/app/modules/cashflow/views/anggaran_edit_view.dart';
import 'package:nuha/app/modules/cashflow/views/transaksi_create_view.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sizer/sizer.dart';

class AnggaranDetailView extends GetView<AnggaranDetailController> {
  final String id;

  AnggaranDetailView({Key? key, required this.id}) : super(key: key);

  final c = Get.find<AnggaranDetailController>();
  final TransaksiCreateController co = Get.put(TransaksiCreateController());

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID');
    return Scaffold(
        backgroundColor: backgroundColor2,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Detail Anggaran",
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
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 7.777778.w, vertical: 1.5.h),
          child: ListView(
            children: [
              FutureBuilder<Map<String, dynamic>?>(
                  future: c.getAnggaranById(id.toString()),
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
                      c.kategoriC.value = snapshot.data!["kategori"];
                      c.nomAnggaranC.text =
                          snapshot.data!["nominal"].toString();
                      return GetBuilder<AnggaranDetailController>(
                        builder: (controller) => Column(
                          children: [
                            SizedBox(
                              height: 4.5.h,
                              child: TextField(
                                textAlign: TextAlign.left,
                                controller: controller.searchTransInAnggaranC,
                                onChanged: (value) =>
                                    controller.searchTransInAnggaran(
                                        value, snapshot.data!["kategori"]),
                                // textAlignVertical: TextAlignVertical.center,
                                keyboardType: TextInputType.text,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: grey900,
                                    ),
                                decoration: InputDecoration(
                                  fillColor: grey50,
                                  filled: true,
                                  contentPadding: EdgeInsets.fromLTRB(
                                      2.222.w, 1.25.h, 0, 1.25.h),
                                  suffixIcon: IconButton(
                                    icon: const Iconify(
                                      Uil.search,
                                      color: grey400,
                                    ),
                                    onPressed: () {},
                                    iconSize: 12.sp,
                                  ),
                                  suffixIconColor: grey400,
                                  hintText: "Cari transaksi kamu disini",
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: grey400,
                                      ),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2.5.h,
                            ),
                            Container(
                              height: 16.h,
                              padding:
                                  EdgeInsets.symmetric(horizontal: 4.44444.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Image(
                                                width: 10.555556.w,
                                                image: AssetImage(
                                                    'assets/images/${controller.kategoriC.value}.png'),
                                              ),
                                              SizedBox(
                                                width: 4.44444.w,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    controller.kategoriC
                                                        .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: dark,
                                                        ),
                                                  ),
                                                  SizedBox(
                                                    height: 0.5.h,
                                                  ),
                                                  Text(
                                                    NumberFormat.currency(
                                                            locale: 'id',
                                                            symbol:
                                                                "Tersisa Rp. ",
                                                            decimalDigits: 0)
                                                        .format(snapshot.data![
                                                            "sisaLimit"]),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                          color: grey400,
                                                        ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            PersistentNavBarNavigator
                                                .pushNewScreen(context,
                                                    screen: UpdateAnggaranView(
                                                      id: id.toString(),
                                                    )),
                                        icon: Iconify(
                                          MaterialSymbols.edit,
                                          size: 12.sp,
                                          color: grey400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  LinearPercentIndicator(
                                    barRadius: const Radius.circular(40),
                                    // width: 75.55556.w,
                                    lineHeight: 2.5.h,
                                    percent: double.parse(
                                        snapshot.data!["persentase"]),
                                    backgroundColor: backBar,
                                    progressColor: controller.getProgressColor(
                                        double.parse(
                                            snapshot.data!["persentase"])),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        NumberFormat.currency(
                                                locale: 'id',
                                                symbol: "Limit Rp. ",
                                                decimalDigits: 0)
                                            .format(int.parse(
                                                controller.nomAnggaranC.text)),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: grey400,
                                            ),
                                      )
                                      // Text(
                                      //   "0%",
                                      //   style: Theme.of(context)
                                      //       .textTheme
                                      //       .bodySmall!
                                      //       .copyWith(
                                      //         color: grey400,
                                      //       ),
                                      // )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    height: 0,
                                    color: grey100,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            GetBuilder<AnggaranDetailController>(
                                init: AnggaranDetailController(),
                                initState: (_) {},
                                builder: (_) {
                                  return SizedBox(
                                    child: _.searchTransInAnggaranC.text.isEmpty
                                        ? Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 4.44444.w),
                                            height: 51.25.h,
                                            child: StreamBuilder<
                                                QuerySnapshot<
                                                    Map<String, dynamic>>>(
                                              stream: controller
                                                  .streamTransaksiKategori(
                                                controller.kategoriC.toString(),
                                              ),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }
                                                if (snapshot
                                                    .data!.docs.isEmpty) {
                                                  return SizedBox(
                                                    height: 51.25.h,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          height: 12.1875.h,
                                                        ),
                                                        Image.asset(
                                                          'assets/images/no_records_1.png',
                                                          width: 40.w,
                                                          height: 14.125.h,
                                                        ),
                                                        Text(
                                                          "Kamu belum melakukan pencatatan transaksi, nih. Yuk, catat transaksi dan pantau alur keuanganmu dengan mudah~",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodySmall!
                                                              .copyWith(
                                                                  color:
                                                                      grey400),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        SizedBox(
                                                          height: 2.5.h,
                                                        ),
                                                        SizedBox(
                                                          width: 50.27778.w,
                                                          height: 4.25.h,
                                                          child: ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                                elevation: 0,
                                                                backgroundColor:
                                                                    buttonColor2,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20))),
                                                            child: Text(
                                                              "Tambah transaksi sekarang",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                      color:
                                                                          backgroundColor1),
                                                            ),
                                                            onPressed: () =>
                                                                PersistentNavBarNavigator
                                                                    .pushNewScreen(
                                                                        context,
                                                                        screen:
                                                                            FormTransaksiView()),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                } else {
                                                  return MediaQuery
                                                      .removePadding(
                                                    context: context,
                                                    removeTop: true,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Detail Anggaran",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color:
                                                                        grey500,
                                                                  ),
                                                        ),
                                                        SizedBox(
                                                          height: 1.125.h,
                                                        ),
                                                        Expanded(
                                                          child:
                                                              ListView.builder(
                                                            itemCount: snapshot
                                                                .data!
                                                                .docs
                                                                .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              var docTransaksi =
                                                                  snapshot.data!
                                                                          .docs[
                                                                      index];
                                                              Map<String,
                                                                      dynamic>
                                                                  transaksi =
                                                                  docTransaksi
                                                                      .data();
                                                              // print(transaksi);
                                                              return Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Image(
                                                                            width:
                                                                                10.55556.w,
                                                                            image:
                                                                                AssetImage('assets/images/${transaksi["kategori"]}.png'),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                4.44444.w,
                                                                          ),
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                "${transaksi["namaTransaksi"]}",
                                                                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                                                      fontWeight: FontWeight.w600,
                                                                                      color: dark,
                                                                                    ),
                                                                              ),
                                                                              Text(
                                                                                transaksi["jenisTransaksi"] == "Pengeluaran" ? NumberFormat.currency(locale: 'id', symbol: "- ", decimalDigits: 0).format(transaksi["nominal"]) : NumberFormat.currency(locale: 'id', symbol: "+ ", decimalDigits: 0).format(transaksi["nominal"]),
                                                                                style: transaksi["jenisTransaksi"] == "Pengeluaran"
                                                                                    ? Theme.of(context).textTheme.bodySmall!.copyWith(
                                                                                          color: const Color(0XFFCC444B),
                                                                                        )
                                                                                    : Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                                                          color: const Color(0XFF0096C7),
                                                                                        ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        DateFormat('dd MMMM yyyy',
                                                                                'id')
                                                                            .format(transaksi['tanggalTransaksi'].toDate()),
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodySmall!
                                                                            .copyWith(color: grey400),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        1.5.h,
                                                                  ),
                                                                  const Divider(
                                                                    thickness:
                                                                        1,
                                                                    height: 0,
                                                                    color:
                                                                        grey100,
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        1.5.h,
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          )
                                        : Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 4.44444.w),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Hasil Pencarian",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: grey500,
                                                      ),
                                                ),
                                                SizedBox(
                                                  height: 1.125.h,
                                                ),
                                                controller.querySearch.isEmpty
                                                    ? Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    10.w,
                                                                vertical: 10.h),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Image(
                                                              image: const AssetImage(
                                                                  'assets/images/Empty.png'),
                                                              height: 15.h,
                                                            ),
                                                            SizedBox(
                                                              height: 2.h,
                                                            ),
                                                            Text(
                                                              "Data yang dicari tidak ditemukan. Silahkan coba kata kunci lain!",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                      color:
                                                                          grey500),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : SizedBox(
                                                        height: 60.75.h,
                                                        child: MediaQuery
                                                            .removePadding(
                                                          context: context,
                                                          removeTop: true,
                                                          child:
                                                              ListView.builder(
                                                            itemCount:
                                                                controller
                                                                    .querySearch
                                                                    .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Image(
                                                                            width:
                                                                                10.55556.w,
                                                                            image:
                                                                                AssetImage('assets/images/${controller.querySearch[index]["kategori"]}.png'),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                4.44444.w,
                                                                          ),
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                "${controller.querySearch[index]["namaTransaksi"]}",
                                                                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                                                      fontWeight: FontWeight.w600,
                                                                                      color: dark,
                                                                                    ),
                                                                              ),
                                                                              Text(
                                                                                controller.querySearch[index]["jenisTransaksi"] == "Pengeluaran"
                                                                                    ? NumberFormat.currency(locale: 'id', symbol: "- ", decimalDigits: 0).format(
                                                                                        controller.querySearch[index]["nominal"],
                                                                                      )
                                                                                    : NumberFormat.currency(locale: 'id', symbol: "+ ", decimalDigits: 0).format(
                                                                                        controller.querySearch[index]["nominal"],
                                                                                      ),
                                                                                style: controller.querySearch[index]["jenisTransaksi"] == "Pengeluaran"
                                                                                    ? Theme.of(context).textTheme.bodySmall!.copyWith(
                                                                                          color: const Color(0XFFCC444B),
                                                                                        )
                                                                                    : Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                                                          color: const Color(0XFF0096C7),
                                                                                        ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        DateFormat('dd MMMM yyyy').format(controller
                                                                            .querySearch[index]["tanggalTransaksi"]
                                                                            .toDate()),
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodySmall!
                                                                            .copyWith(color: grey400),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        1.5.h,
                                                                  ),
                                                                  const Divider(
                                                                    thickness:
                                                                        1,
                                                                    height: 0,
                                                                    color:
                                                                        grey100,
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        1.5.h,
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ),
                                  );
                                })
                          ],
                        ),
                      );
                    }
                  }),
            ],
          ),
        ));
  }
}

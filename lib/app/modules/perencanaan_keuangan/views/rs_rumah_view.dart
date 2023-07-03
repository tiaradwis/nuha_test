import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/widgets/progress_bar.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/controllers/pk_rumah_controller.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/controllers/perencanaan_keuangan_controller.dart';
import 'package:screenshot/screenshot.dart';

class RsRumahView extends GetView<PkRumahController> {
  RsRumahView({Key? key}) : super(key: key);

  final c = Get.find<PkRumahController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(5.875.h),
          child: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: titleColor,
                size: 18.sp,
              ),
              onPressed: () => Get.back(),
            ),
            backgroundColor: backgroundColor1,
            elevation: 0,
          ),
        ),
        body: SafeArea(
            child: c.caraPembayaran.value == "Cash"
                ? CashWidget()
                : MurabahahWidget()));
  }
}

class CashWidget extends StatelessWidget {
  CashWidget({super.key});

  final c = Get.find<PkRumahController>();

  final con = Get.find<PerencanaanKeuanganController>();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: 7.778.w,
      ),
      children: [
        SizedBox(
          height: 0.5.h,
        ),
        Screenshot(
          controller: con.screenshotController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GradientText(
                "Hasil Perhitungan ",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
                colors: const [
                  buttonColor1,
                  buttonColor2,
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Text(
                    "Perkiraan Harga Rumah Impian",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: grey900,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    NumberFormat.currency(
                            locale: 'id', symbol: "Rp", decimalDigits: 0)
                        .format(c.perkiraanHarga),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: grey900,
                        ),
                  ),
                  Text(
                    "(Asumsi kenaikan 5% pertahun)",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: grey900,
                        ),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  SizedBox(
                    width: 90.w,
                    height: 5.h,
                    child: ProgressBarView(
                      value: c.persentage,
                    ),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                ],
              ),
              const Divider(),
              SizedBox(
                height: 1.5.h,
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Dana Terkumpul",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: grey900,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        Text(
                          "Rp${c.nomDanaTersedia.text}",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: grey900,
                                  ),
                        ),
                      ],
                    ),
                    const VerticalDivider(
                      thickness: 1,
                      color: grey100,
                    ),
                    Column(
                      children: [
                        Text(
                          "Selisih Dana",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: grey900,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        Text(
                          NumberFormat.currency(
                                  locale: 'id', symbol: "Rp", decimalDigits: 0)
                              .format(c.nomSisa),
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: grey900,
                                  ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 2.5.h,
              ),
              GradientText(
                "Rekomendasi Tabungan",
                style: Theme.of(context).textTheme.displaySmall!,
                colors: const [
                  buttonColor1,
                  buttonColor2,
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                "Dengan dana yang dapat kamu sisihkan:",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: grey900,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Text(
                "Rp${c.nomDanaDisisihkan.text}/bulan",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: grey900,
                    ),
              ),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: grey900,
                      ),
                  children: [
                    const TextSpan(
                      text: 'Perencanaan dana beli rumah ',
                    ),
                    TextSpan(
                      text: c.danaStat,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: c.danaStat == "dapat tercapai"
                            ? buttonColor1
                            : errColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                "Setidaknya, kamu perlu menabung sebesar:",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: grey900,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${NumberFormat.currency(locale: 'id', symbol: "Rp", decimalDigits: 0).format(c.tabunganPerbulan.round())}/bulan",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: grey900,
                        ),
                  ),
                  Text(
                    "selama ${c.bulan.ceil()} bulan",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: grey900,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
              Text(
                "Agar perencanaan dana beli rumah tercapai",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: grey900,
                    ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 0.5.h,
        ),
        const Divider(),
        SizedBox(
          height: 0.5.h,
        ),
        Text(
          "Laporan Hasil Perhitungan",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: grey900,
                fontWeight: FontWeight.w600,
              ),
        ),
        Row(
          children: [
            Iconify(
              Bi.file_pdf_fill,
              color: errColor,
              size: 2.h,
            ),
            SizedBox(
              width: 1.w,
            ),
            TextButton(
              onPressed: () {
                con.screenshotController
                    .capture(delay: const Duration(milliseconds: 10))
                    .then((capturedImage) async {
                  con.getPdf(capturedImage!, "Dana Beli Rumah");
                }).catchError((onError) {
                  print(onError);
                });
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(
                  Size(double.infinity, 1.h),
                ),
              ),
              child: Text(
                "Unduh PDF Hasil Perhitungan",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.lightBlue,
                    ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 39.7222.w,
              height: 5.5.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    side: const BorderSide(width: 1, color: buttonColor1),
                    backgroundColor: backgroundColor1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: Text(
                  "Kembali",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: buttonColor1),
                ),
                onPressed: () => Get.back(),
              ),
            ),
            SizedBox(
              width: 39.7222.w,
              height: 5.5.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: Text(
                  "Simpan",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white),
                ),
                onPressed: () {
                  if (c.isLoading.isFalse) {
                    c.saveData(context);
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class MurabahahWidget extends StatelessWidget {
  MurabahahWidget({super.key});

  final c = Get.find<PkRumahController>();

  final con = Get.find<PerencanaanKeuanganController>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: 7.778.w,
      ),
      children: [
        SizedBox(
          height: 0.5.h,
        ),
        Screenshot(
            controller: con.screenshotController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GradientText(
                  "Hasil Perhitungan",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                  colors: const [
                    buttonColor1,
                    buttonColor2,
                  ],
                ),
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 1.5.h,
                      ),
                      Text(
                        "Harga Rumah Impian",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: grey900,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Text(
                        "Rp${c.nomRumah.text}",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: grey900,
                            ),
                      ),
                      SizedBox(
                        width: 90.w,
                        height: 5.h,
                        child: ProgressBarView(
                          value: c.persentage,
                        ),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                    ],
                  ),
                ),
                const Divider(),
                SizedBox(
                  height: 1.5.h,
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Uang Muka",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: grey900,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                          Text(
                            "Rp${c.nomDanaTersedia.text}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: grey900,
                                ),
                          ),
                          // Text(
                          //   "(Dana terkumpul)",
                          //   style:
                          //       Theme.of(context).textTheme.bodySmall!.copyWith(
                          //             color: grey900,
                          //           ),
                          // ),
                        ],
                      ),
                      const VerticalDivider(
                        thickness: 1,
                        color: grey100,
                      ),
                      Column(
                        children: [
                          Text(
                            "Pokok Pinjaman",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: grey900,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                          Text(
                            NumberFormat.currency(
                                    locale: 'id',
                                    symbol: "Rp",
                                    decimalDigits: 0)
                                .format(c.nomSisa),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: grey900,
                                ),
                          ),
                          // Text(
                          //   "(Selisih dana)",
                          //   style:
                          //       Theme.of(context).textTheme.bodySmall!.copyWith(
                          //             color: grey900,
                          //           ),
                          // ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                GradientText(
                  "Akad Murabahah",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                  colors: const [
                    buttonColor1,
                    buttonColor2,
                  ],
                ),
                Text(
                  "Lembaga keuangan membeli properti yang diinginkan oleh nasabah dan kemudian menjualnya kepada nasabah dengan harga dimargin.",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: grey900,
                      ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Center(
                  child: Container(
                    width: 60.w,
                    height: 9.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: buttonColor2.withOpacity(0.2),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          "Angsuran Perbulan",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: grey900,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        Text(
                          NumberFormat.currency(
                                  locale: 'id', symbol: "Rp", decimalDigits: 0)
                              .format(c.angsuranBulanan),
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: grey900,
                                  ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                GradientText(
                  "Minimal Penghasilan",
                  style: Theme.of(context).textTheme.displaySmall!,
                  colors: const [
                    buttonColor1,
                    buttonColor2,
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "30% dari Penghasilan",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: grey900,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                          Text(
                            NumberFormat.currency(
                                    locale: 'id',
                                    symbol: "Rp",
                                    decimalDigits: 0)
                                .format(c.penghasilan30),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: grey900,
                                ),
                          ),
                        ],
                      ),
                      const VerticalDivider(
                        thickness: 1,
                        color: grey100,
                      ),
                      Column(
                        children: [
                          Text(
                            "40% dari Penghasilan",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: grey900,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                          Text(
                            NumberFormat.currency(
                                    locale: 'id',
                                    symbol: "Rp",
                                    decimalDigits: 0)
                                .format(c.penghasilan40),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: grey900,
                                ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )),
        const Divider(),
        SizedBox(
          height: 0.5.h,
        ),
        Text(
          "Laporan Hasil Perhitungan",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: grey900,
                fontWeight: FontWeight.w600,
              ),
        ),
        Row(
          children: [
            Iconify(
              Bi.file_pdf_fill,
              color: errColor,
              size: 2.h,
            ),
            SizedBox(
              width: 1.w,
            ),
            TextButton(
              onPressed: () {
                con.screenshotController
                    .capture(delay: const Duration(milliseconds: 10))
                    .then((capturedImage) async {
                  con.getPdf(capturedImage!, "Dana Beli Rumah");
                }).catchError((onError) {
                  print(onError);
                });
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(
                  Size(double.infinity, 1.h),
                ),
              ),
              child: Text(
                "Unduh PDF Hasil Perhitungan",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.lightBlue,
                    ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 39.7222.w,
              height: 5.5.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    side: const BorderSide(width: 1, color: buttonColor1),
                    backgroundColor: backgroundColor1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: Text(
                  "Kembali",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: buttonColor1),
                ),
                onPressed: () => Get.back(),
              ),
            ),
            SizedBox(
              width: 39.7222.w,
              height: 5.5.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: Text(
                  "Simpan",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white),
                ),
                onPressed: () {
                  if (c.isLoading.isFalse) {
                    c.saveData(context);
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

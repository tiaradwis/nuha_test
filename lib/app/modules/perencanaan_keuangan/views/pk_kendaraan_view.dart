import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/controllers/pk_kendaraan_controller.dart';
import 'package:nuha/app/widgets/field_currency.dart';
import 'package:nuha/app/widgets/field_number.dart';
import 'package:nuha/app/widgets/field_text.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';
import '../controllers/perencanaan_keuangan_controller.dart';

class PkKendaraanView extends GetView<PkKendaraanController> {
  PkKendaraanView({Key? key}) : super(key: key);

  final c = Get.find<PkKendaraanController>();
  final con = Get.find<PerencanaanKeuanganController>();

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
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 7.778.w,
          ),
          children: [
            SizedBox(
              height: 0.5.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GradientText(
                  "Dana Beli Kendaraan",
                  style: Theme.of(context).textTheme.displaySmall!,
                  colors: const [
                    buttonColor1,
                    buttonColor2,
                  ],
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                Text(
                  "Dana beli kendaraan bertujuan untuk mempersiapkan dan mengatur sumber daya keuangan yang efektif guna membeli kendaraan yang diinginkan.",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: grey400,
                      ),
                ),
                SizedBox(
                  height: 3.125.h,
                ),
                FieldText(
                    labelText: "Nama Kendaraan Impian",
                    contr: c.namaKendaraan,
                    hintText: "Masukkan Nama Kendaraan"),
                FieldCurrency(
                    labelText: "Harga Kendaraan Impian",
                    contr: c.nomKendaraan,
                    infoText:
                        "Harga kendaraan impian adalah harga pasaran kendaraan yang kamu inginkan."),
                Text(
                  "Cara Pembayaran",
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
                  width: 84.44444.w,
                  padding: EdgeInsets.only(top: 1.h, left: 4.583333.w),
                  decoration: BoxDecoration(
                      border: Border.all(color: grey100),
                      borderRadius: BorderRadius.circular(20)),
                  child: Obx(
                    () => DropdownButton(
                      hint: Text(
                        c.caraPembayaran.value,
                        style: c.statusStat.value == "choosen"
                            ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: grey900,
                                )
                            : Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: grey400,
                                ),
                      ),
                      value: null,
                      isDense: true,
                      underline: const SizedBox(),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: grey400,
                      ),
                      onChanged: (value) {
                        c.updateStatus(value);
                      },
                      items: [
                        "Cash",
                        "BSI OTO",
                      ].map((String valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem),
                        );
                      }).toList(),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: dark,
                          ),
                      elevation: 0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                Obx(() => SizedBox(
                    child: c.caraPembayaran.value == "Cash"
                        ? Column(
                            children: [
                              FieldNumber(
                                labelText: "Kapan Kamu Ingin Mencapai Target",
                                contr: c.tahunTercapai,
                                hintText: "5 (tahun)",
                              ),
                              FieldNumber(
                                labelText: "Margin/tahun (%)",
                                contr: c.margin,
                                hintText: "5%",
                              ),
                              FieldCurrency(
                                  labelText: "Dana Yang Sudah Terkumpul",
                                  contr: c.nomDanaTersedia,
                                  infoText:
                                      "Dana yang terkumpul adalah uang yang telah disimpan untuk membeli kendaraan impianmu."),
                              FieldCurrency(
                                  labelText: "Dana Yang Dapat Disisihkan",
                                  contr: c.nomDanaDisisihkan,
                                  infoText:
                                      "Dana yang dapat disisihkan adalah uang yang dapat kamu sisihkan setiap bulannya untuk tabungan dana beli kendaraan."),
                            ],
                          )
                        : c.caraPembayaran.value == "BSI OTO"
                            ? Column(
                                children: [
                                  FieldNumber(
                                      labelText: "Lama Tenor (bulan)",
                                      contr: c.lamaTenor,
                                      hintText: "64 (bulan)"),
                                  FieldNumber(
                                    labelText: "Persentase DP",
                                    contr: c.persenDP,
                                    hintText: "15%",
                                  ),
                                  FieldNumber(
                                    labelText: "Margin/tahun (%)",
                                    contr: c.margin,
                                    hintText: "5%",
                                  ),
                                ],
                              )
                            : Container())),
              ],
            ),
            SizedBox(
              width: 100.w,
              child: Center(
                child: SizedBox(
                  width: 84.1667.w,
                  height: 5.5.h,
                  child: Obx(() => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: buttonColor2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: Text(
                          c.isLoading.isFalse ? "Hitung Dana" : "Loading...",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                        ),
                        onPressed: () {
                          if (c.namaKendaraan.value.text.isNotEmpty &&
                              c.nomKendaraan.value.text.isNotEmpty &&
                              c.margin.value.text.isNotEmpty) {
                            if (c.caraPembayaran.value == "Cash" &&
                                c.tahunTercapai.value.text.isNotEmpty &&
                                c.nomDanaTersedia.value.text.isNotEmpty &&
                                c.nomDanaDisisihkan.value.text.isNotEmpty) {
                              if (c.isLoading.isFalse) {
                                c.countDana(context);
                              }
                            } else if (c.caraPembayaran.value == "BSI OTO" &&
                                c.lamaTenor.value.text.isNotEmpty &&
                                c.persenDP.value.text.isNotEmpty) {
                              if (c.isLoading.isFalse) {
                                c.countDana(context);
                              }
                            } else {
                              con.errMsg("Mohon isi seluruh kolom yang ada!");
                            }
                          } else {
                            con.errMsg("Mohon isi seluruh kolom yang ada!");
                          }
                        },
                      )),
                ),
              ),
            ),
            SizedBox(
              height: 3.h,
            )
          ],
        ),
      ),
    );
  }
}

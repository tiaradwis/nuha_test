import 'package:flutter/material.dart';
import '../controllers/perencanaan_keuangan_controller.dart';
import 'package:get/get.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/controllers/pk_rumah_controller.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/widgets/field_currency.dart';
import 'package:nuha/app/widgets/field_number.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';

class PkRumahView extends GetView<PkRumahController> {
  PkRumahView({Key? key}) : super(key: key);

  final c = Get.find<PkRumahController>();
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
            Container(
              padding: EdgeInsets.only(top: 0.625.w),
              width: 100.w,
              height: 79.625.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 0.5.h,
                  ),
                  GradientText(
                    "Dana Beli Rumah",
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
                    "Dana beli rumah bertujuan mewujudkan impian untuk memiliki tempat tinggal yang nyaman dan sesuai keinginan.",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: grey400,
                        ),
                  ),
                  SizedBox(
                    height: 3.125.h,
                  ),
                  FieldCurrency(
                      labelText: "Harga Rumah",
                      contr: c.nomRumah,
                      infoText: "Harga rumah impian kamu saat ini."),
                  FieldCurrency(
                      labelText: "Dana Yang Sudah Terkumpul",
                      contr: c.nomDanaTersedia,
                      infoText:
                          "Dana yang terkumpul adalah uang yang telah disimpan untuk membeli rumah impianmu."),
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
                              ? Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: grey900,
                                  )
                              : Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
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
                          "KPR Akad Murabahah",
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
                        child: c.caraPembayaran.value == "KPR Akad Murabahah"
                            ? Column(
                                children: [
                                  FieldNumber(
                                    labelText: "Jangka Waktu (tahun)",
                                    contr: c.tahunTercapai,
                                    hintText: "5 (tahun)",
                                  ),
                                  FieldNumber(
                                    labelText: "Margin/tahun (%)",
                                    contr: c.margin,
                                    hintText: "10 %",
                                  ),
                                ],
                              )
                            : c.caraPembayaran.value != "Cash"
                                ? Container()
                                : Column(
                                    children: [
                                      FieldNumber(
                                          labelText:
                                              "Kapan Kamu Ingin Membeli Rumah?",
                                          contr: c.tahunTercapai,
                                          hintText: "5 (tahun)"),
                                      FieldCurrency(
                                          labelText:
                                              "Dana Yang Dapat Disisihkan",
                                          contr: c.nomDanaDisisihkan,
                                          infoText:
                                              "Dana yang dapat disisihkan adalah uang yang dapat kamu sisihkan setiap bulannya untuk tabungan dana beli rumah."),
                                    ],
                                  ),
                      )),
                ],
              ),
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
                          if (c.nomRumah.value.text.isNotEmpty &&
                              c.nomDanaTersedia.value.text.isNotEmpty &&
                              c.tahunTercapai.value.text.isNotEmpty) {
                            if (c.caraPembayaran.value == "Cash" &&
                                c.nomDanaDisisihkan.value.text.isNotEmpty) {
                              if (c.isLoading.isFalse) {
                                c.countCash(context);
                              }
                            } else if (c.caraPembayaran.value ==
                                    "KPR Akad Murabahah" &&
                                c.margin.value.text.isNotEmpty) {
                              if (c.isLoading.isFalse) {
                                c.countKPRMurabahah(context);
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
          ],
        ),
      ),
    );
  }
}

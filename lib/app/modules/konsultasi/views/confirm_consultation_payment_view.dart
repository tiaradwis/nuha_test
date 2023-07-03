import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_screen_image/full_screen_image.dart';

import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:intl/intl.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/konsultasi/controllers/payment_confirmation_controller.dart';

import 'package:sizer/sizer.dart';

class ConfirmConsultationPaymentView extends GetView {
  ConfirmConsultationPaymentView({Key? key}) : super(key: key);
  final c = Get.find<PaymentConfirmationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor1,
        leading: Container(
          width: 100,
          padding: EdgeInsets.only(left: 4.58.w),
          child: IconButton(
            onPressed: () => Get.back(),
            icon: Iconify(
              Mdi.arrow_left,
              size: 3.h,
              color: titleColor,
            ),
          ),
        ),
        iconTheme: const IconThemeData(
          color: titleColor,
        ),
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(left: 4.6.w),
          child: Text(
            'Konfirmasi Pembayaran',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
                color: titleColor),
          ),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: backgroundColor1,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        elevation: 0.5,
        toolbarHeight: 7.375.h,
      ),
      backgroundColor: backgroundColor1,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: FutureBuilder<void>(
          future: c.getDetailData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: EdgeInsets.only(top: 40.h),
                child: const Center(
                  child: CircularProgressIndicator(color: buttonColor1),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 1.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Column(
                      children: [
                        Card(
                          color: Colors.transparent,
                          elevation: 0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: Image.network(
                                    c.confirmConsultationPayment
                                            .consultantImg ??
                                        '',
                                    height: 8.625.h,
                                    width: 8.625.h,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              SizedBox(width: 3.89.w),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      c.confirmConsultationPayment
                                              .consultantName ??
                                          '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0XFF0D4136),
                                              fontSize: 13.sp),
                                    ),
                                    Text(
                                      c.confirmConsultationPayment
                                              .consultantCategory ??
                                          '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: grey500,
                                              fontSize: 11.sp),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Iconify(
                                          Ic.sharp_access_time_filled,
                                          size: 10.sp,
                                          color: grey900,
                                        ),
                                        SizedBox(width: 1.w),
                                        Text(
                                          c.confirmConsultationPayment
                                                  .fixScheduleTime ??
                                              '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  color: grey900,
                                                  fontSize: 10.sp),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  Container(
                    height: 7,
                    color: grey50,
                  ),
                  SizedBox(height: 2.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Biaya Sesi 1 Jam',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Colors.black,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400),
                        ),
                        Text(
                          NumberFormat.currency(locale: 'id', symbol: 'Rp. ')
                              .format(c.confirmConsultationPayment
                                      .consultantPrice ??
                                  0)
                              .replaceAll(",00", ""),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Colors.black,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 0.75.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Biaya Layanan',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Colors.black,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400),
                        ),
                        Text(
                          '+ Rp. 1.500',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Colors.black,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 0.75.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Colors.black,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400),
                        ),
                        Text(
                          NumberFormat.currency(locale: 'id', symbol: 'Rp. ')
                              .format(
                                  c.confirmConsultationPayment.totalPrice ?? 0)
                              .replaceAll(",00", ""),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Colors.black,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  Container(
                    height: 7,
                    color: grey50,
                  ),
                  SizedBox(height: 2.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Text(
                      'Pilih Metode Pembayaran Anda',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 13.sp),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: c.paymentMethodDetails(
                      context,
                      c.mandiriCard,
                      c.paymentMethodList[0],
                      'assets/images/logo-bank-mandiri.png',
                      'Bank Mandiri',
                      "Melalui Aplikasi Livin' By Mandiri:",
                      '1. \n'
                          '2. \n'
                          '3. \n\n'
                          '4. \n'
                          '5. \n'
                          '6. \n',
                      "Buka aplikasi Livin' By Mandiri. \n"
                          'Pilih menu "Transfer Rupiah". \n'
                          'Masukkan nomor rekening tujuan, yaitu 0123456789 a.n. Nuha Financial. \n'
                          'Masukkan nominal transfer. \n'
                          'Verifikasi detail transfer. \n'
                          'Masukkan MPIN dan konfirmasi transfer. \n',
                      "Melalui ATM Mandiri:",
                      '1. \n'
                          '2. \n'
                          '3. \n'
                          '4. \n'
                          '5. \n\n'
                          '6. \n'
                          '7. \n'
                          '8. \n',
                      "Kunjungi mesin ATM Mandiri terdekat. \n"
                          'Masukkan kartu ATM Mandiri dan PIN. \n'
                          'Pilih menu "Transfer". \n'
                          'Pilih "Ke Rekening Mandiri". \n'
                          'Masukkan rekening tujuan, yaitu 0123456789 a.n. Nuha Financial. \n'
                          'Masukkan nominal transfer. \n'
                          'Verifikasi detail transfer. \n'
                          'Konfirmasikan transfer. \n',
                      "Melalui Internet Banking Mandiri:",
                      '1. \n'
                          '2. \n'
                          '3. \n'
                          '4. \n\n'
                          '5. \n'
                          '6. \n'
                          '7.',
                      "Buka situs web Mandiri Internet Banking. \n"
                          'Masukkan username dan password. \n'
                          'Pilih menu "Transfer". \n'
                          'Masukkan rekening tujuan, yaitu 0123456789 a.n. Nuha Financial. \n'
                          'Masukkan nominal transfer. \n'
                          'Verifikasi detail transfer. \n'
                          'Konfirmasikan transfer.',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: c.paymentMethodDetails(
                      context,
                      c.bcaCard,
                      c.paymentMethodList[1],
                      'assets/images/logo-bank-bca.png',
                      'Bank BCA',
                      "Melalui BCA mobile:",
                      '1. \n'
                          '2. \n'
                          '3. \n'
                          '4. \n\n'
                          '5. \n'
                          '6. \n'
                          '7 \n',
                      "Buka aplikasi BCA mobile. \n"
                          'Pilih menu "Transfer" atau "Transfer antarbank". \n'
                          'Pilih bank tujuan (Mandiri). \n'
                          'Masukkan nomor rekening, yaitu 0123456789 a.n. Nuha Financial. \n'
                          'Masukkan nominal transfer. \n'
                          'Verifikasi detail transfer. \n'
                          'Konfirmasikan transfer. \n',
                      "Melalui ATM BCA:",
                      '1. \n'
                          '2. \n'
                          '3. \n\n'
                          '4. \n'
                          '5. \n\n'
                          '6. \n'
                          '7. \n'
                          '8. \n',
                      "Masukkan kartu ATM BCA dan PIN. \n"
                          'Pilih menu "Transfer" atau "Transfer antarbank". \n'
                          'Pilih "Transfer ke Bank Lain" atau "Transfer ke Bank Lain dalam Negeri". \n'
                          'Pilih bank tujuan (Mandiri). \n'
                          'Masukkan nomor rekening tujuan, yaitu 0123456789 a.n. Nuha Financial. \n'
                          'Masukkan nominal transfer. \n'
                          'Verifikasi detail transfer. \n'
                          'Konfirmasikan transfer. \n',
                      "Melalui Internet Banking BCA:",
                      '1. \n'
                          '2. \n'
                          '3. \n\n'
                          '4. \n\n'
                          '5. \n'
                          '6. \n\n'
                          '7. \n'
                          '8. \n'
                          '9.',
                      "Buka situs web Internet Banking BCA. \n"
                          'Masuk ke akun Anda. \n'
                          'Pilih menu "Transfer Dana" atau "Transfer antarbank". \n'
                          'Pilih "Transfer ke Bank Lain" atau "Transfer ke Bank Lain dalam Negeri". \n'
                          'Pilih bank tujuan (Mandiri). \n'
                          'Masukkan nomor rekening tujuan, yaitu 0123456789 a.n. Nuha Financial. \n'
                          'Masukkan nominal transfer. \n'
                          'Verifikasi detail transfer. \n'
                          'Konfirmasikan transfer. ',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: c.paymentMethodDetails(
                      context,
                      c.bniCard,
                      c.paymentMethodList[2],
                      'assets/images/logo-bank-bni.png',
                      'Bank BNI',
                      "Melalui BNI Mobile Banking:",
                      '1. \n'
                          '2. \n'
                          '3. \n'
                          '4. \n\n'
                          '5. \n'
                          '6. \n'
                          '7 \n',
                      "Buka aplikasi BNI Mobile Banking. \n"
                          'Pilih menu "Transfer" atau "Transfer antarbank". \n'
                          'Pilih bank tujuan (Mandiri). \n'
                          'Masukkan nomor rekening, yaitu 0123456789 a.n. Nuha Financial. \n'
                          'Masukkan nominal transfer. \n'
                          'Verifikasi detail transfer. \n'
                          'Konfirmasikan transfer. \n',
                      "Melalui ATM BNI:",
                      '1. \n'
                          '2. \n'
                          '3. \n\n'
                          '4. \n'
                          '5. \n\n'
                          '6. \n'
                          '7. \n'
                          '8. \n',
                      "Masukkan kartu ATM BNI dan PIN. \n"
                          'Pilih menu "Transfer" atau "Transfer antarbank". \n'
                          'Pilih "Transfer ke Bank Lain" atau "Transfer ke Bank Lain dalam Negeri". \n'
                          'Pilih bank tujuan (Mandiri). \n'
                          'Masukkan nomor rekening tujuan, yaitu 0123456789 a.n. Nuha Financial. \n'
                          'Masukkan nominal transfer. \n'
                          'Verifikasi detail transfer. \n'
                          'Konfirmasikan transfer. \n',
                      "Melalui Internet Banking BNI:",
                      '1. \n'
                          '2. \n'
                          '3. \n\n'
                          '4. \n\n'
                          '5. \n'
                          '6. \n\n'
                          '7. \n'
                          '8. \n'
                          '9.',
                      "Buka situs web Internet Banking BNI. \n"
                          'Masuk ke akun Anda. \n'
                          'Pilih menu "Transfer Dana" atau "Transfer antarbank". \n'
                          'Pilih "Transfer ke Bank Lain" atau "Transfer ke Bank Lain dalam Negeri". \n'
                          'Pilih bank tujuan (Mandiri). \n'
                          'Masukkan nomor rekening tujuan, yaitu 0123456789 a.n. Nuha Financial. \n'
                          'Masukkan nominal transfer. \n'
                          'Verifikasi detail transfer. \n'
                          'Konfirmasikan transfer. ',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: c.paymentMethodDetails(
                      context,
                      c.bsiCard,
                      c.paymentMethodList[3],
                      'assets/images/logo-bank-bsi.png',
                      'Bank BSI',
                      "Melalui BSI Mobile:",
                      '1. \n'
                          '2. \n'
                          '3. \n'
                          '4. \n\n'
                          '5. \n'
                          '6. \n'
                          '7 \n',
                      "Buka aplikasi BSI Mobile. \n"
                          'Pilih menu "Transfer" atau "Transfer antarbank". \n'
                          'Pilih bank tujuan (Mandiri). \n'
                          'Masukkan nomor rekening, yaitu 0123456789 a.n. Nuha Financial. \n'
                          'Masukkan nominal transfer. \n'
                          'Verifikasi detail transfer. \n'
                          'Konfirmasikan transfer. \n',
                      "Melalui ATM BSI:",
                      '1. \n'
                          '2. \n'
                          '3. \n\n'
                          '4. \n'
                          '5. \n\n'
                          '6. \n'
                          '7. \n'
                          '8. \n',
                      "Masukkan kartu ATM BSI dan PIN. \n"
                          'Pilih menu "Transfer" atau "Transfer antarbank". \n'
                          'Pilih "Transfer ke Bank Lain" atau "Transfer ke Bank Lain dalam Negeri". \n'
                          'Pilih bank tujuan (Mandiri). \n'
                          'Masukkan nomor rekening tujuan, yaitu 0123456789 a.n. Nuha Financial. \n'
                          'Masukkan nominal transfer. \n'
                          'Verifikasi detail transfer. \n'
                          'Konfirmasikan transfer. \n',
                      "Melalui Internet Banking BSI:",
                      '1. \n'
                          '2. \n'
                          '3. \n\n'
                          '4. \n\n'
                          '5. \n'
                          '6. \n\n'
                          '7. \n'
                          '8. \n'
                          '9.',
                      "Buka situs web Internet Banking BSI \n"
                          'Masuk ke akun Anda. \n'
                          'Pilih menu "Transfer Dana" atau "Transfer antarbank". \n'
                          'Pilih "Transfer ke Bank Lain" atau "Transfer ke Bank Lain dalam Negeri". \n'
                          'Pilih bank tujuan (Mandiri). \n'
                          'Masukkan nomor rekening tujuan, yaitu 0123456789 a.n. Nuha Financial. \n'
                          'Masukkan nominal transfer. \n'
                          'Verifikasi detail transfer. \n'
                          'Konfirmasikan transfer. ',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: c.paymentMethodDetails(
                      context,
                      c.briCard,
                      c.paymentMethodList[4],
                      'assets/images/logo-bank-bri.png',
                      'Bank BRI',
                      "Melalui Aplikasi BRImo BRI:",
                      '1. \n'
                          '2. \n'
                          '3. \n'
                          '4. \n\n'
                          '5. \n'
                          '6. \n'
                          '7 \n',
                      "Buka aplikasi BRImo BRI. \n"
                          'Pilih menu "Transfer" atau "Transfer antarbank". \n'
                          'Pilih bank tujuan (Mandiri). \n'
                          'Masukkan nomor rekening, yaitu 0123456789 a.n. Nuha Financial. \n'
                          'Masukkan nominal transfer. \n'
                          'Verifikasi detail transfer. \n'
                          'Konfirmasikan transfer. \n',
                      "Melalui ATM BRI:",
                      '1. \n'
                          '2. \n'
                          '3. \n\n'
                          '4. \n'
                          '5. \n\n'
                          '6. \n'
                          '7. \n'
                          '8. \n',
                      "Masukkan kartu ATM BRI dan PIN. \n"
                          'Pilih menu "Transfer" atau "Transfer antarbank". \n'
                          'Pilih "Transfer ke Bank Lain" atau "Transfer ke Bank Lain dalam Negeri". \n'
                          'Pilih bank tujuan (Mandiri). \n'
                          'Masukkan nomor rekening tujuan, yaitu 0123456789 a.n. Nuha Financial. \n'
                          'Masukkan nominal transfer. \n'
                          'Verifikasi detail transfer. \n'
                          'Konfirmasikan transfer. \n',
                      "Melalui Internet Banking BRI:",
                      '1. \n'
                          '2. \n'
                          '3. \n\n'
                          '4. \n\n'
                          '5. \n'
                          '6. \n\n'
                          '7. \n'
                          '8. \n'
                          '9.',
                      "Buka situs web Internet Banking BRI. \n"
                          'Masuk ke akun Anda. \n'
                          'Pilih menu "Transfer Dana" atau "Transfer antarbank". \n'
                          'Pilih "Transfer ke Bank Lain" atau "Transfer ke Bank Lain dalam Negeri". \n'
                          'Pilih bank tujuan (Mandiri). \n'
                          'Masukkan nomor rekening tujuan, yaitu 0123456789 a.n. Nuha Financial. \n'
                          'Masukkan nominal transfer. \n'
                          'Verifikasi detail transfer. \n'
                          'Konfirmasikan transfer. ',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: c.paymentMethodDetails(
                      context,
                      c.gopayCard,
                      c.paymentMethodList[5],
                      'assets/images/logo-gopay.png',
                      'GoPay',
                      "Berikut langkah-langkah menggunakan GoPay:",
                      '1. \n'
                          '2. \n'
                          '3. \n'
                          '4. \n\n'
                          '5. \n'
                          '6. \n\n\n'
                          '7 \n'
                          '8 ',
                      "Buka aplikasi Gojek. \n"
                          'Pastikan akun telah terhubung dengan GoPay. \n'
                          'Pilih menu "Bayar" atau "Pay". \n'
                          'Pilih menu "Ke Rekening Bank" atau "To Bank Account". \n'
                          'Pilih ke Bank Mandiri. \n'
                          'Masukkan nomor rekening tujuan, yaitu 0123456789 a.n. Nuha Financial dan lakukan verifikasi. \n'
                          'Masukkan nominal transfer. \n'
                          'Konfirmasi dan masukkan PIN. ',
                      null,
                      null,
                      null,
                      null,
                      null,
                      null,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: c.paymentMethodDetails(
                      context,
                      c.danaCard,
                      c.paymentMethodList[6],
                      'assets/images/logo-dana.png',
                      'DANA',
                      "Berikut langkah-langkah menggunakan DANA:",
                      '1. \n'
                          '2. \n'
                          '3. \n'
                          '4. \n\n'
                          '5. \n'
                          '6. \n\n'
                          '7 \n\n'
                          '8 \n'
                          '9 ',
                      "Buka aplikasi DANA. \n"
                          'Pilih menu "Kirim" atau "Send". \n'
                          'Pilih menu "Kirim ke Bank" atau "Send to Bank". \n'
                          'Klik "Tambah akun bank baru" atau "Add new bank account". \n'
                          'Pilih ke Bank Mandiri. \n'
                          'Masukkan nomor rekening tujuan, yaitu 0123456789 a.n Nuha Financial. \n'
                          'Klik "Simpan & Lanjutkan" atau "Save & Continue". \n'
                          'Masukkan nominal transfer. \n'
                          'Konfirmasi dan masukkan PIN. ',
                      null,
                      null,
                      null,
                      null,
                      null,
                      null,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: c.paymentMethodDetails(
                      context,
                      c.linkajaCard,
                      c.paymentMethodList[7],
                      'assets/images/logo-linkaja.png',
                      'LinkAja',
                      "Berikut langkah-langkah menggunakan LinkAja:",
                      '1. \n'
                          '2. \n'
                          '3. \n\n'
                          '4. \n\n'
                          '5. \n'
                          '6. ',
                      "Buka aplikasi LinkAja. \n"
                          'Pilih menu "Kirim Uang". \n'
                          'Pilih metode Rekening Bank dan pilih Bank Tujuan (Mandiri). \n'
                          'Masukkan nomor rekening tujuan, yaitu 0123456789 a.n Nuha Financial. \n'
                          'Masukkan nominal transfer. \n'
                          'Konfirmasi dan masukkan PIN. ',
                      null,
                      null,
                      null,
                      null,
                      null,
                      null,
                    ),
                  ),
                  SizedBox(height: 2.h),
                ],
              );
            }
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 135,
        padding: EdgeInsetsDirectional.symmetric(
          vertical: 1.5.h,
          horizontal: 3.w,
        ),
        decoration: const BoxDecoration(
          color: backgroundColor1,
          boxShadow: [
            BoxShadow(
              color: grey400,
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Pembayaran Anda',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 11.sp,
                      color: grey400),
                ),
                SizedBox(height: 0.5.h),
                Obx(
                  () => Text(
                    NumberFormat.currency(locale: 'id', symbol: 'Rp. ')
                        .format(c.totalFixedPrice.value)
                        .replaceAll(",00", ""),
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            Obx(
              () => c.isPaymentMethodSelected.isTrue
                  ? SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (c.isLoading.isFalse) {
                            Get.bottomSheet(
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 4.w,
                                  vertical: 3.h,
                                ),
                                child:
                                    GetBuilder<PaymentConfirmationController>(
                                  init: PaymentConfirmationController(),
                                  builder: (choose) {
                                    return choose.image != null
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Center(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: SizedBox(
                                                    height: 180,
                                                    width: double.infinity,
                                                    child: FullScreenWidget(
                                                      disposeLevel:
                                                          DisposeLevel.High,
                                                      child: Image(
                                                        fit: BoxFit.fitWidth,
                                                        image: FileImage(
                                                          File(choose
                                                              .image!.path),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Berhasil diunggah!',
                                                    style:
                                                        Theme.of(Get.context!)
                                                            .textTheme
                                                            .headlineMedium!
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 15.sp,
                                                              color: grey900,
                                                            ),
                                                  ),
                                                  SizedBox(height: 0.5.h),
                                                  Text(
                                                    'Kamu bisa simpan bukti pembayaran tersebut, namun kamu juga bisa mengambil ulang bukti pembayaranmu!',
                                                    style:
                                                        Theme.of(Get.context!)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                              fontSize: 11.sp,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    height: 50,
                                                    width: double.infinity,
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            buttonColor1,
                                                      ),
                                                      onPressed: () => c
                                                          .uploadProofOfPayment(),
                                                      child: Text(
                                                        'Simpan Bukti Pembayaran',
                                                        style: Theme.of(
                                                                Get.context!)
                                                            .textTheme
                                                            .labelMedium!
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13.sp,
                                                              color:
                                                                  backgroundColor1,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 1.h),
                                                  SizedBox(
                                                    height: 50,
                                                    width: double.infinity,
                                                    child: OutlinedButton(
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        foregroundColor:
                                                            buttonColor1,
                                                        backgroundColor:
                                                            backgroundColor1,
                                                        side: const BorderSide(
                                                            color: buttonColor1,
                                                            width: 1),
                                                      ),
                                                      onPressed: () =>
                                                          choose.resetImage(),
                                                      child: Text(
                                                        'Unggah Ulang',
                                                        style: Theme.of(
                                                                Get.context!)
                                                            .textTheme
                                                            .labelMedium!
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13.sp,
                                                              color:
                                                                  buttonColor1,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Center(
                                                  child: Image.asset(
                                                      'assets/images/found_error.png')),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Unggah bukti pembayaranmu!',
                                                    style:
                                                        Theme.of(Get.context!)
                                                            .textTheme
                                                            .headlineMedium!
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 15.sp,
                                                              color: grey900,
                                                            ),
                                                  ),
                                                  SizedBox(height: 1.h),
                                                  Text(
                                                    'Kamu bisa milih untuk mengambil gambar langsung dengan kamera atau dari galeri kamu.',
                                                    style:
                                                        Theme.of(Get.context!)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                              fontSize: 11.sp,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    height: 50,
                                                    width: double.infinity,
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            buttonColor1,
                                                      ),
                                                      onPressed: () => c
                                                          .pickProofOfPaymentImage(
                                                              'galeri'),
                                                      child: Text(
                                                        'Buka Galeri',
                                                        style: Theme.of(
                                                                Get.context!)
                                                            .textTheme
                                                            .labelMedium!
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13.sp,
                                                              color:
                                                                  backgroundColor1,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 1.h),
                                                  SizedBox(
                                                    height: 50,
                                                    width: double.infinity,
                                                    child: OutlinedButton(
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        foregroundColor:
                                                            buttonColor1,
                                                        backgroundColor:
                                                            backgroundColor1,
                                                        side: const BorderSide(
                                                            color: buttonColor1,
                                                            width: 1),
                                                      ),
                                                      onPressed: () => c
                                                          .pickProofOfPaymentImage(
                                                              'kamera'),
                                                      child: Text(
                                                        'Buka Kamera',
                                                        style: Theme.of(
                                                                Get.context!)
                                                            .textTheme
                                                            .labelMedium!
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13.sp,
                                                              color:
                                                                  buttonColor1,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                  },
                                ),
                              ),
                              backgroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor1,
                        ),
                        child: c.isLoading.isFalse
                            ? Text(
                                'Konfirmasi Pembayaran',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.sp,
                                        color: backgroundColor1),
                              )
                            : SizedBox(
                                height: 1.5.h,
                                width: 1.5.h,
                                child: const CircularProgressIndicator(
                                  color: backgroundColor1,
                                ),
                              ),
                      ),
                    )
                  : SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: grey400,
                          foregroundColor: grey400,
                          disabledBackgroundColor: grey400,
                          disabledForegroundColor: grey400,
                        ),
                        child: c.isLoading.isFalse
                            ? Text(
                                'Konfirmasi Pembayaran',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.sp,
                                        color: backgroundColor1),
                              )
                            : SizedBox(
                                height: 1.5.h,
                                width: 1.5.h,
                                child: const CircularProgressIndicator(
                                  color: backgroundColor1,
                                ),
                              ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

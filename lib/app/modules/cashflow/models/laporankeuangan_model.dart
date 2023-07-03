import 'package:flutter/material.dart';

class ChartData {
  ChartData({this.kategori, this.nominalTerpakai});
  final String? kategori;
  final int? nominalTerpakai;
}

class LineChart {
  LineChart({
    this.jenisTransaksi,
    this.nominal,
    this.tanggalTransaksi,
    this.color,
  });
  final String? jenisTransaksi;
  final int? nominal;
  final DateTime? tanggalTransaksi;
  final Color? color;
}

class ChartPemasukan {
  ChartPemasukan({
    this.kategori,
    this.nominal,
  });
  final String? kategori;
  final int? nominal;
}

class ChartPengeluaran {
  ChartPengeluaran({
    this.kategori,
    this.nominal,
  });
  final String? kategori;
  final int? nominal;
}

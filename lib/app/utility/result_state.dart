// ignore_for_file: constant_identifier_names

// import 'package:get/get.dart';

// enum Status {LOADING, HASDATA, ERROR, EMPTY}
enum ResultStatus { loading, hasData, noData, error }

class ResultState<T> {
  ResultStatus status;
  T? data;
  String? message;

  ResultState.loading() : status = ResultStatus.loading;
  ResultState.hasData(this.data) : status = ResultStatus.hasData;
  ResultState.noData() : status = ResultStatus.noData;
  ResultState.error(this.message) : status = ResultStatus.error;
}
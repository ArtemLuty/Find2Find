import 'dart:convert';
import 'dart:io';


import 'package:dio/dio.dart';
import 'package:find_me/ui/utils/utils.dart';

import 'dio_manager.dart';
import 'exception_manager.dart';
import 'package:get/get.dart';

void handleErrorApp(dynamic error, {JsonDecoder? decoder}) async {
  if (error is DioError) {
    // print(error.response.statusCode);
    if (error.error is SocketException)
      showToast("SocketException");
    else if (error.type == DioErrorType.receiveTimeout ||
        error.type == DioErrorType.sendTimeout ||
        error.type == DioErrorType.connectTimeout) {
      showToast("Internet connection");
    }
    else if (error.response != null &&
        error.response!.statusCode != null &&
        exceptions.containsKey(error.response!.statusCode)) {
      if (error.response!.statusCode == DioManager.UNAUTHORIZED_ERROR_CODE) {
        showToast("UNAUTHORIZED_ERROR_CODE");
      }
      if (error.response!.statusCode == DioManager.INTERNAL_SERVER_ERROR_CODE) {

      }
      if (error.response!.statusCode == DioManager.BAD_REQUEST_ERROR_CODE) {
        if(error.type == DioErrorType.response){

        }
      }
      if (error.response!.statusCode == DioManager.SERVER_DO_NOT_WORK) {
        showToast("SERVER_DO_NOT_WORK");
      }
    }
    else if(error.type == DioErrorType.other){
      showToast("Default error");
    }
  }
  else{
    showToast("Unexpected error");
  }
}


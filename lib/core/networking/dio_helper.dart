import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:news_app/core/networking/api_endpoints.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper{
 static Dio? dio;
 static void initDio(){
    if(dio == null) {
      dio = Dio(
          BaseOptions(
            baseUrl: ApiEndpoints.baseUrl,
            receiveDataWhenStatusError: true,
          )
      );
    }
    dio!.interceptors.add(PrettyDioLogger());
 }


 static Future<Response?> getrequest({required String endpoint,required Map<String,dynamic> query}) async {
   try{
     final Response response = await dio!.get(endpoint,queryParameters: query);
     return response;
   }catch(e){
     log(e.toString());
     return null;
   }
 }

 static Future<Response?> postRequest({required String endpoint,required Map<String,dynamic> query}) async {
   try {
     final Response response = await dio!.post(endpoint,queryParameters: query);
     return response;
   } catch (e) {
     log(e.toString());
     return null;
   }
 }
}
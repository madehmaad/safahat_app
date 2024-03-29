import 'package:dio/dio.dart';

abstract class Service {
  Dio dio = Dio();
  late Response response;
  
}
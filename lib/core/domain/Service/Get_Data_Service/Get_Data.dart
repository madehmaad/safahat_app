import 'package:dio/dio.dart';
import 'package:pages_app/core/domain/model/Student_model.dart';


late List<StudentModel> Students = [];


abstract class dbService {
  Dio dio = Dio();
  late Response raw;
}



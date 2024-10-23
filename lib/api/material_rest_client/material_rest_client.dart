import 'package:dio/dio.dart';
import 'package:dr_alshaal/config/env.dart';
import 'package:dr_alshaal/models/base_response/base_response.dart';
import 'package:dr_alshaal/models/material/material.dart';
import 'package:dr_alshaal/models/pagination_model/pagination_model.dart';
import 'package:retrofit/http.dart';

import '../../models/seriese/seriese.dart';

part 'material_rest_client.g.dart';

@RestApi()
abstract class MaterialRestClient {
  factory MaterialRestClient(Dio dio, {String baseUrl}) = _MaterialRestClient;

  @GET("${Env.material}{slug}")
  Future<BaseResponse<MaterialModel>> getMaterial({@Path('slug') required String slug});

  @GET(Env.seriesesPaginate)
  Future<BaseResponse<PaginationModel<Seriese>>> getSeries({
    @Query('page') required int page,
    @Query('type') String? type,
    @Query('topic') String? topic,
    @Query('order_by') String? orderBy,
  });
  @GET(Env.getSeriesMaterials)
  Future<BaseResponse<PaginationModel<MaterialModel>>> getMaterials({
    @Query('page') required int page,
    @Query('series_id') String? seriesId,
    @Query('order_by') String? orderBy,
    @Query('type_id') String? type,
    @Query('topic_id') String? topic,
  });
}

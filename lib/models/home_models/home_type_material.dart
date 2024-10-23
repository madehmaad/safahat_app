import 'package:dr_alshaal/models/material/material.dart';
import 'package:dr_alshaal/models/pagination_model/pagination_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'home_type.dart';

part 'home_type_material.g.dart';

@JsonSerializable()
class HomeTypeMaterial {
  HomeType? type;
  PaginationModel<MaterialModel>? materials;

  HomeTypeMaterial(this.type, this.materials);

  factory HomeTypeMaterial.fromJson(Map<String, dynamic> json) => _$HomeTypeMaterialFromJson(json);

  Map<String, dynamic> toJson() => _$HomeTypeMaterialToJson(this);
}

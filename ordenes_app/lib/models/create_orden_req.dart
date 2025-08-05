import 'package:json_annotation/json_annotation.dart';
import 'package:ordenes_app/models/examen_req.dart';

part 'create_orden_req.g.dart';

@JsonSerializable()
class CreateOrdenReq {
  final DateTime fechaAtencion;
  final List<ExamenReq> examenes;

  CreateOrdenReq({
    required this.fechaAtencion,
    required this.examenes,
  });

  factory CreateOrdenReq.fromJson(Map<String, dynamic> json) => _$CreateOrdenReqFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrdenReqToJson(this);
}

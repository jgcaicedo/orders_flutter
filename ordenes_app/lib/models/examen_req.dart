import 'package:json_annotation/json_annotation.dart';

part 'examen_req.g.dart';

@JsonSerializable()
class ExamenReq {
  final String nombre;
  final String codigo;
  final String descripcion;
  final DateTime fecha;

  ExamenReq({
    required this.nombre,
    required this.codigo,
    required this.descripcion,
    required this.fecha,
  });

  factory ExamenReq.fromJson(Map<String, dynamic> json) => _$ExamenReqFromJson(json);

  Map<String, dynamic> toJson() => _$ExamenReqToJson(this);
}
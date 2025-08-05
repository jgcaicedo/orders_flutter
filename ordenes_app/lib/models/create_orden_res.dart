import 'package:json_annotation/json_annotation.dart';
import 'package:ordenes_app/models/examen.dart';

part 'create_orden_res.g.dart';

@JsonSerializable()
class OrdenRes {
  final int id;
  final String nombre;
  final List<Examen> examenes;

  OrdenRes({
    required this.id,
    required this.nombre,
    required this.examenes,
  });

  factory OrdenRes.fromJson(Map<String, dynamic> json) => _$OrdenResFromJson(json);
  Map<String, dynamic> toJson() => _$OrdenResToJson(this);
}
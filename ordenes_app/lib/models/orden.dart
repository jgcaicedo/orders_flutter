

import 'package:json_annotation/json_annotation.dart';
import 'package:ordenes_app/models/examen.dart';

part 'orden.g.dart';

@JsonSerializable()
class Orden{
  final int id;
  final DateTime fechaAtencion;
  final List<Examen> examenes;

  Orden({
    required this.id,
    required this.fechaAtencion,
    required this.examenes,
  });

  factory Orden.fromJson(Map<String, dynamic> json) => _$OrdenFromJson(json);

  Map<String, dynamic> toJson() => _$OrdenToJson(this);
}
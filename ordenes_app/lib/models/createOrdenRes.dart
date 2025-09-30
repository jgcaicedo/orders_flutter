import 'package:json_annotation/json_annotation.dart';
import 'package:ordenes_app/models/examen.dart';

part 'createOrdenRes.g.dart';

@JsonSerializable()
class CreateOrdenRes {
  final int id;
  final DateTime fechaAtencion;
  final List<Examen> examenes;

  CreateOrdenRes({
    required this.id,
    required this.fechaAtencion,
    required this.examenes,
  });

  factory CreateOrdenRes.fromJson(Map<String, dynamic> json) => _$CreateOrdenResFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrdenResToJson(this);
}
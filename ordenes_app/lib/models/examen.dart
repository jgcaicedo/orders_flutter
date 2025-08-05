
import 'package:json_annotation/json_annotation.dart';

part 'examen.g.dart';

@JsonSerializable()
class Examen {
  final int id;
  final String nombre;
  final String codigo;

  Examen({
    required this.id,
    required this.nombre,
    required this.codigo,
  });

  factory Examen.fromJson(Map<String, dynamic> json) => _$ExamenFromJson(json);
  Map<String, dynamic> toJson() => _$ExamenToJson(this);
}
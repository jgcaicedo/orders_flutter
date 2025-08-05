// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orden.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Orden _$OrdenFromJson(Map<String, dynamic> json) => Orden(
      id: (json['id'] as num).toInt(),
      fechaAtencion: DateTime.parse(json['fechaAtencion'] as String),
      examenes: (json['examenes'] as List<dynamic>)
          .map((e) => Examen.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrdenToJson(Orden instance) => <String, dynamic>{
      'id': instance.id,
      'fechaAtencion': instance.fechaAtencion.toIso8601String(),
      'examenes': instance.examenes,
    };

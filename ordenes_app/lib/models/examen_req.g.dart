// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'examen_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamenReq _$ExamenReqFromJson(Map<String, dynamic> json) => ExamenReq(
      nombre: json['nombre'] as String,
      codigo: json['codigo'] as String,
      descripcion: json['descripcion'] as String,
      fecha: DateTime.parse(json['fecha'] as String),
    );

Map<String, dynamic> _$ExamenReqToJson(ExamenReq instance) => <String, dynamic>{
      'nombre': instance.nombre,
      'codigo': instance.codigo,
      'descripcion': instance.descripcion,
      'fecha': instance.fecha.toIso8601String(),
    };

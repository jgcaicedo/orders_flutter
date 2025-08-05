// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_orden_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrdenReq _$CreateOrdenReqFromJson(Map<String, dynamic> json) =>
    CreateOrdenReq(
      fechaAtencion: DateTime.parse(json['fechaAtencion'] as String),
      examenes: (json['examenes'] as List<dynamic>)
          .map((e) => ExamenReq.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreateOrdenReqToJson(CreateOrdenReq instance) =>
    <String, dynamic>{
      'fechaAtencion': instance.fechaAtencion.toIso8601String(),
      'examenes': instance.examenes,
    };

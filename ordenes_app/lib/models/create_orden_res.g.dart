// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_orden_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdenRes _$OrdenResFromJson(Map<String, dynamic> json) => OrdenRes(
      id: (json['id'] as num).toInt(),
      nombre: json['nombre'] as String,
      examenes: (json['examenes'] as List<dynamic>)
          .map((e) => Examen.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrdenResToJson(OrdenRes instance) => <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'examenes': instance.examenes,
    };

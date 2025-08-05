// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'examen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Examen _$ExamenFromJson(Map<String, dynamic> json) => Examen(
      id: (json['id'] as num).toInt(),
      nombre: json['nombre'] as String,
      codigo: json['codigo'] as String,
    );

Map<String, dynamic> _$ExamenToJson(Examen instance) => <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'codigo': instance.codigo,
    };

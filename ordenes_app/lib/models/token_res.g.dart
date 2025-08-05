// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenRes _$TokenResFromJson(Map<String, dynamic> json) => TokenRes(
      token: json['token'] as String,
      expiracion: (json['expiracion'] as num).toInt(),
    );

Map<String, dynamic> _$TokenResToJson(TokenRes instance) => <String, dynamic>{
      'token': instance.token,
      'expiracion': instance.expiracion,
    };

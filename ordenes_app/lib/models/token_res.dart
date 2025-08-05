import 'package:json_annotation/json_annotation.dart';

part 'token_res.g.dart';

@JsonSerializable()
class TokenRes{
  final String token;
  final int expiracion;

  TokenRes({
    required this.token,
    required this.expiracion,
  });

  factory TokenRes.fromJson(Map<String, dynamic> json) => _$TokenResFromJson(json);

  Map<String, dynamic> toJson() => _$TokenResToJson(this);
}
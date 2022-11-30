// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_servers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiServer _$ApiServerFromJson(Map<String, dynamic> json) => ApiServer(
      api: json['api'] == null
          ? null
          : Api.fromJson(json['api'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApiServerToJson(ApiServer instance) => <String, dynamic>{
      'api': instance.api,
    };

Api _$ApiFromJson(Map<String, dynamic> json) => Api(
      firebase: json['firebase'] == null
          ? null
          : Firebase.fromJson(json['firebase'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApiToJson(Api instance) => <String, dynamic>{
      'firebase': instance.firebase,
    };

Firebase _$FirebaseFromJson(Map<String, dynamic> json) => Firebase(
      url: json['url'] as String?,
      signupNewUser: json['signupNewUser'] as String?,
    );

Map<String, dynamic> _$FirebaseToJson(Firebase instance) => <String, dynamic>{
      'url': instance.url,
      'signupNewUser': instance.signupNewUser,
    };

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
      firebaseSetting: json['firebaseSetting'] == null
          ? null
          : FirebaseSetting.fromJson(
              json['firebaseSetting'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApiToJson(Api instance) => <String, dynamic>{
      'firebaseSetting': instance.firebaseSetting,
    };

FirebaseSetting _$FirebaseSettingFromJson(Map<String, dynamic> json) =>
    FirebaseSetting(
      url: json['url'] as String?,
      signupNewUser: json['signupNewUser'] as String?,
      signinUser: json['signinUser'] as String?,
    )..apiKey = json['apiKey'] as String?;

Map<String, dynamic> _$FirebaseSettingToJson(FirebaseSetting instance) =>
    <String, dynamic>{
      'signinUser': instance.signinUser,
      'signupNewUser': instance.signupNewUser,
      'url': instance.url,
      'apiKey': instance.apiKey,
    };

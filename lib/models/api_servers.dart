import 'package:json_annotation/json_annotation.dart';

part 'api_servers.g.dart';

@JsonSerializable()
class ApiServer {
  ApiServer({this.api});

  factory ApiServer.fromJson(Map<String, dynamic> json) =>
      _$ApiServerFromJson(json);

  Api? api;

  Map<String, dynamic> toJson() => _$ApiServerToJson(this);
}

@JsonSerializable()
class Api {
  Api({this.firebaseSetting});

  factory Api.fromJson(Map<String, dynamic> json) => _$ApiFromJson(json);

  FirebaseSetting? firebaseSetting;

  Map<String, dynamic> toJson() => _$ApiToJson(this);
}

@JsonSerializable()
class FirebaseSetting {
  FirebaseSetting({this.url, this.signupNewUser, this.signinUser});

  factory FirebaseSetting.fromJson(Map<String, dynamic> json) =>
      _$FirebaseSettingFromJson(json);

  String? signinUser;
  String? signupNewUser;
  String? url;
  String? apiKey;

  Map<String, dynamic> toJson() => _$FirebaseSettingToJson(this);
}

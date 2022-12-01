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
  Api({this.firebase});

  factory Api.fromJson(Map<String, dynamic> json) => _$ApiFromJson(json);

  Firebase? firebase;

  Map<String, dynamic> toJson() => _$ApiToJson(this);
}

@JsonSerializable()
class Firebase {
  Firebase({this.url, this.signupNewUser, this.signinUser});

  factory Firebase.fromJson(Map<String, dynamic> json) =>
      _$FirebaseFromJson(json);

  String? signinUser;
  String? signupNewUser;
  String? url;

  Map<String, dynamic> toJson() => _$FirebaseToJson(this);
}

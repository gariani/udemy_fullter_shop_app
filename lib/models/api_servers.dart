import 'package:json_annotation/json_annotation.dart';

part 'api_servers.g.dart';

@JsonSerializable()
class ApiServer {
  Api? api;

  ApiServer({this.api});

  factory ApiServer.fromJson(Map<String, dynamic> json) =>
      _$ApiServerFromJson(json);
  Map<String, dynamic> toJson() => _$ApiServerToJson(this);
}

@JsonSerializable()
class Api {
  Firebase? firebase;

  Api({this.firebase});

  factory Api.fromJson(Map<String, dynamic> json) => _$ApiFromJson(json);

  Map<String, dynamic> toJson() => _$ApiToJson(this);
}

@JsonSerializable()
class Firebase {
  String? url;
  String? signupNewUser;

  Firebase({this.url, this.signupNewUser});

  factory Firebase.fromJson(Map<String, dynamic> json) =>
      _$FirebaseFromJson(json);

  Map<String, dynamic> toJson() => _$FirebaseToJson(this);
}

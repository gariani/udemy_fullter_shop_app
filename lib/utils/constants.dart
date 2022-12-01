import '../main.dart';
import '../models/api_servers.dart';

class Constants {
  static Firebase? firebaseSetting = getIt<ApiServer>().api?.firebase;
  static String orderBaseURL = '${firebaseSetting!.url}/orders';
  static String productBaseURL = '${firebaseSetting!.url}/products';
  static String signinURL = '${firebaseSetting!.signinUser}';
  static String signupURL = '${firebaseSetting!.signupNewUser}';
}

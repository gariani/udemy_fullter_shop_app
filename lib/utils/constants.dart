import 'package:shop_app/main.dart';
import 'package:shop_app/models/api_servers.dart';

class Constants {
  static Firebase? firebaseSetting = getIt<ApiServer>().api?.firebase;

  static String productBaseURL = '${firebaseSetting!.url}/products';
  static String orderBaseURL = '${firebaseSetting!.url}/orders';
  static String signupURL = '${firebaseSetting!.signupNewUser}';
  static String signinURL = '${firebaseSetting!.signinUser}';
}

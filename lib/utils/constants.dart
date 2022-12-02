import '../main.dart';
import '../models/api_servers.dart';

class Constants {
  static FirebaseSetting? firebaseSetting =
      getIt<ApiServer>().api?.firebaseSetting;
  static String orderBaseURL =
      '${firebaseSetting!.url}/${firebaseSetting!.apiKey}/orders';
  static String productBaseURL =
      '${firebaseSetting!.url}/${firebaseSetting!.apiKey}/products';
  static String signinURL =
      '${firebaseSetting!.signinUser}${firebaseSetting!.apiKey}';
  static String signupURL =
      '${firebaseSetting!.signupNewUser}}${firebaseSetting!.apiKey}';
}

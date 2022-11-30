import 'package:shop_app/main.dart';
import 'package:shop_app/models/api_servers.dart';

class Constants {
  static String productBaseURL =
      '${getIt<ApiServer>().api?.firebase?.url}/products';
  static String orderBaseURL =
      '${getIt<ApiServer>().api?.firebase?.url}/orders';
  static String signupURL =
      '${getIt<ApiServer>().api?.firebase?.signupNewUser}';
}

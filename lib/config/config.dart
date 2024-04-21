import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'network/network_constants.dart';

class Config {
  Config._();

  static final String env = dotenv.env['ENVIRONMENT'] ?? '';
  static final String baseAPIUrl = dotenv.env[NetworkConstants.baseUrl] ?? '';

  static const String live = "assets/env/.env";
  static const String uat = "assets/env/.env.uat";
  static const String dev = "assets/env/.env.dev";

  ///
  static bool isUAT() => (env == "uat"); // When shared with client

  static bool isDEV() => (env == "dev"); //When worked internally

  static bool isLIVE() => (env == "live"); // When shared in PLAY-STORE
}

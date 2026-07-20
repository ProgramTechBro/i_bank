enum AppEnvironment { development, staging, production }

class AppConfig {
  AppConfig._();

  static AppEnvironment environment = AppEnvironment.development;
  static String baseUrl = '';
}

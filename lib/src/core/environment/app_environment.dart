enum AppEnvironment { dev, staging, prod }

abstract final class EnvironmentConfig {
  static const AppEnvironment current = AppEnvironment.dev;
}

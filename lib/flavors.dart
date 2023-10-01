enum Flavor {
  LOCAL,
  DEV,
  PROD,
}

class F {
  static Flavor? appFlavor;

  static String get title {
    switch (appFlavor) {
      case Flavor.LOCAL:
        return 'Template（local）';
      case Flavor.DEV:
        return 'Template（dev）';
      case Flavor.PROD:
        return 'Template';
      default:
        return 'title';
    }
  }
}

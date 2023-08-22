class AppConstants {
  static const String MOVIES_API_BASE_URL = "https://api.themoviedb.org/3";
  static const String MOVIES_API_KEY = "3e903ab8fdca01af7623fbe76398669d";
  static const String IMAGE_ROOT_PATH = "https://image.tmdb.org/t/p/w500";
  static String getImageFullPath(String subPath,) => "$IMAGE_ROOT_PATH$subPath";
}
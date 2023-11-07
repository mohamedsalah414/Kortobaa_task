class AppStrings {
  static const String appName = 'Kortobaa task';

  static const String login = 'تسجيل الدخول';
  static const String loginButton = 'الدخول';
  static const String pleaseLoginToBuy = 'من فضلك قم بالدخول لإتمام الشراء';
  static const String userName = 'اسم المستخدم';
  static const String password = 'كلمة السر';
  static const String doNotHaveAccount = 'ليس لديك حساب ؟';
  static const String register = 'التسجيل';
  static const String required = 'هذا الحقل مطلوب';
  static const String newAccount = 'حساب جديد';
  static const String welcomeAndFillData =
      'مرحبا بك ، قم بملأ البيانات للتسجيل';
  static const String email = 'البريد الالكتروني';
  static const String firstName = 'الاسم الأول';
  static const String lastName = 'الاسم الأخير';
  static const String confirmPassword = 'تأكيد كلمة السر';
  static const String haveAccount = 'لديك حساب ؟';
  static const String home = 'الرئيسية';
  static const String categories = 'التصنيفات';
  static const String favourites = 'المفضلة';
  static const String profile = 'الحساب';
  static const String search = 'عم تبحث ؟';
  static const String newArrival = 'وصل حديثا';
  static const String viewAll = 'عرض الكل';
  static const String popular = 'الأكثر شعبية';
  static const String addToCart = 'نقل إلى سلة التسوق';
  static const String cart = 'سلة التسوق';

  static const noRouteFound = 'no Route Found';
  static const serverFailure = 'Server Failure';
  static const cacheFailure = 'Cache Failure';
  static const errorDuringCommunication = "Error During Communication";
  static const badRequest = "Bad Request";
  static const unauthorized = "Unauthorized";
  static const requestedInfoNotFound = "Requested Info Not Found";
  static const conflictOccurred = "Conflict Occurred";
  static const internalServerError = "Internal Server Error";
  static const noInternetConnection = 'No Internet connection';
  static const errorOccurredDuringReadingData =
      "Error Occurred During Reading Data";
  static const unexpectedError = 'Unexpected Error';
  static const somethingWentWrong = 'Something Went Wrong';
  static const appFont = 'Tajawal';
}

class ApiUrls {
  static const baseUrl = 'https://flutterapi.kortobaa.net';
  static const baseUrlEndpoint = '$baseUrl/api/v1';

  /// Api Endpoints
  static const String getProducts = '$baseUrlEndpoint/products/';

  static String getProductsById(int id) => '$baseUrlEndpoint/products/$id/';

  static String getProductsByCategoryId(int catId) =>
      '$baseUrlEndpoint/products/category/$catId/';
  static const String getCategories = '$baseUrlEndpoint/categories/';

  static String getCategoriesById(int id) => '$baseUrlEndpoint/categories/$id/';
  static const String postLogin = '$baseUrl/users/login/';
  static const String postRegister = '$baseUrl/users/register/';
}

import 'package:get/get.dart';
import '../controller/feed_controller.dart';
import '../controller/home_controller.dart';
import '../controller/likes_controller.dart';
import '../controller/profile_controller.dart';
import '../controller/search_controller.dart';
import '../controller/signin_controller.dart';
import '../controller/signup_controller.dart';
import '../controller/splash_controller.dart';
import '../controller/upload_controller.dart';


class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => SignUpController(), fenix: true);
    Get.lazyPut(() => SignInController(), fenix: true);
    Get.lazyPut(() => MyFeedController(), fenix: true);
    Get.lazyPut(() => MySearchController(), fenix: true);
    Get.lazyPut(() => MyUploadController(), fenix: true);
    Get.lazyPut(() => MyLikesController(), fenix: true);
    Get.lazyPut(() => MyProfileController(), fenix: true);
  }
}

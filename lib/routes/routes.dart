import 'package:get/get.dart';
import 'package:social_media_o/app/pages/register_screen/bindings/register_bindings.dart';
import '../app/pages/earned_screen/ui/earned_screen.dart';
import '../app/pages/graph_screen/binding/graph_binding.dart';
import '../app/pages/graph_screen/ui/graph_screen.dart';
import '../app/pages/home_screen/binding/home_binding.dart';
import '../app/pages/home_screen/ui/home_screen.dart';
import '../app/pages/login_screen/UI/login_screen.dart';
import '../app/pages/login_screen/binding/login_binding.dart';
import '../app/pages/profile_screen/binding/profile_binding.dart';
import '../app/pages/profile_screen/ui/profile_screen.dart';
import '../app/pages/register_screen/ui/register_screen.dart';
import '../app/pages/spend_screen/ui/spent_screen.dart';
import '../app/pages/splash_screen/binding/splash_binding.dart';
import '../app/pages/splash_screen/ui/splash_screen.dart';

class AppRoutes {
  static final String initial = '/';
  static final String home = '/home';
  static final String login = '/login';
  static final String register = '/register';
  static final String earned = '/earned';
  static final String spent = '/spent';
  static final String graph = '/graph';
  static final String profile = '/profile';

  static final routes = [
    GetPage(
      name: initial,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(name: login, page: () => LoginScreen(), binding: LoginBinding()),
    GetPage(name: home, page: () => HomeScreen(), binding: HomeBinding()),
    GetPage(name: login, page: () => LoginScreen(), binding: LoginBinding()),
    GetPage(
      name: register,
      page: () => RegisterScreen(),
      binding: RegisterBindings(),
    ),
    GetPage(name: earned, page: () => EarnedScreen()),
    GetPage(name: spent, page: () => SpentScreen()),
    GetPage(name: graph, page: () => GraphScreen(), binding: GraphBinding()),
    GetPage(name: profile, page: () => ProfileScreen(),binding: ProfileBinding()),
  ];
}

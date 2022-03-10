import 'package:template/src/config/routes/routes.dart';
import 'package:template/src/modules/main_screen/view/main_screen_view.dart';
export 'package:template/src/modules/main_screen/view/main_screen_view.dart';

class MainRouteHelper extends ParameterlessRouteHelper {
  static const path = '/';
  static const widget = MainScreenWidget;
  const MainRouteHelper() : super(path: path);
}

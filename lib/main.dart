import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoapp/core/string_lbl.dart';
import 'package:todoapp/service_locator.dart';
 import 'core/routing/route_paths.dart';
import 'core/routing/router.dart';
import 'core/utils/hive_keys.dart';
import 'core/utils/hive_paramter.dart';
import 'service_locator.dart' as serviceLocator;

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
   await serviceLocator.init();
  await sl<HiveParamter>().hive.openBox(HiveKeys.userBox);
  await sl<HiveParamter>().hive.openBox(HiveKeys.taskBox);
  runApp(Phoenix(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(393, 852),
        minTextAdapt: true,
        useInheritedMediaQuery: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? widget) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: StringLbl.appName,
            initialRoute: RoutePaths.splashPage,
            onGenerateRoute: AppRouter.generateRoute,
          );
        });
  }
}

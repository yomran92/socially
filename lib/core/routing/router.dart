import 'package:flutter/material.dart';
import 'package:socially/core/routing/route_paths.dart';

import '../../features/account/presentation/screens/login_screen.dart';
import '../../features/home/domain/entities/get_story_entity.dart';
import '../../features/home/presentation/screens/story_view_widget.dart';
import '../../features/navigation/presentation/screens/nav_main_screen.dart';
import '../../features/navigation/presentation/screens/splash_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.LogIn:
        return MaterialPageRoute(builder: (_) => LogInScreen());

      case RoutePaths.splashPage:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case RoutePaths.NavMainScreen:
        return MaterialPageRoute(builder: (_) => NavMainScreen());
      case RoutePaths.stroyViewPage:
        return MaterialPageRoute(
            builder: (_) => StoryViewer(
                  story: settings as GetStoryEntity,
                ));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}

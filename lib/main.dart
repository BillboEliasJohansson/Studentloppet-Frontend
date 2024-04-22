import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studentloppet/routes/app_routes.dart';
import 'package:studentloppet/theme/theme_helper.dart';
import 'package:studentloppet/utils/size_utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  ThemeHelper().changeTheme('primary');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
            theme: theme,
            title: "Studentloppet",
            routes: AppRoutes.routes,
            initialRoute: AppRoutes.initialRoute,
        );
      },
    );
  }
}

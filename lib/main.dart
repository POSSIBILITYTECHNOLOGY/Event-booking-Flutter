import 'package:event_booking/routes/app_routes.dart';
import 'package:event_booking/utils/initial_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialBinding: InitialBindings(),
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.black,
              useMaterial3: true,
              visualDensity: VisualDensity.standard,
            ),
            title: "What's Poppin",
            // home: HomeDetailsScreen(
            //     // controller: ,
            //     ),
            initialRoute: AppRoutes.splash,
            getPages: AppRoutes.pages,

            builder: (context, child) {
              final mediaQueryData = MediaQuery.of(context);
              final scale = mediaQueryData.copyWith(textScaleFactor: 1.0);
              child = MediaQuery(data: scale, child: child!);
              return child;
            },
          );
        });
  }
}

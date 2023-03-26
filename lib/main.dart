import 'package:covid19_stat/constants/page_const.dart';
import 'package:covid19_stat/pages/country_details_page.dart';
import 'package:covid19_stat/pages/country_list_page.dart';
import 'package:covid19_stat/pages/splash_screen_page.dart';
import 'package:covid19_stat/pages/world_stat_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: pageSplashScreen,
      getPages: [
        GetPage(
          name: pageSplashScreen,
          page: () => const SplashScreenPage(),
        ),
        GetPage(
          name: pageWorldStat,
          page: () => const WorldStatPage(title: 'World Statistics'),
        ),
        GetPage(
          name: pageCountryList,
          page: () => CountryListPage(title: 'Track Country'),
        ),
        GetPage(
          name: pageCountryDetails,
          page: () => CountryDetailsPage(),
        ),
      ],
    );
  }
}

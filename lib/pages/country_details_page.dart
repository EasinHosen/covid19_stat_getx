import 'package:covid19_stat/constants/page_const.dart';
import 'package:covid19_stat/models/country_stat_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountryDetailsPage extends StatelessWidget {
  CountryDetailsPage({Key? key}) : super(key: key);

  final CountryStatModel countryStatModel = Get.arguments[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(countryStatModel.country!),
        centerTitle: true,
      ),
    );
  }
}

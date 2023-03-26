import 'package:covid19_stat/constants/page_const.dart';
import 'package:covid19_stat/models/country_stat_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/helper_functions.dart';
import '../widgets/custom_data_row.dart';

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Center(
                  child: Image(
                    width: Get.width * 0.5,
                    height: Get.height * 0.2,
                    image: NetworkImage(countryStatModel.countryInfo!.flag!),
                  ),
                ),
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        const Text('Last updated'),
                        Text(
                          getFormattedDateTime(
                            DateTime.fromMillisecondsSinceEpoch(
                                countryStatModel.updated!.toInt()),
                            'dd-MMM-yyyy \n hh:mm a',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        CustomDataRow(
                          title: 'Total tests',
                          data: countryStatModel.tests.toString(),
                        ),
                        CustomDataRow(
                          title: 'Total case',
                          data: countryStatModel.cases.toString(),
                        ),
                        CustomDataRow(
                            title: 'Total Recovered',
                            data: countryStatModel.recovered.toString()),
                        CustomDataRow(
                            title: 'Total Dead',
                            data: countryStatModel.deaths!.toString()),
                        const Divider(),
                        CustomDataRow(
                            title: 'Today\'s case',
                            data: countryStatModel.todayCases.toString()),
                        CustomDataRow(
                            title: 'Today\'s recovered',
                            data: countryStatModel.todayRecovered.toString()),
                        CustomDataRow(
                            title: 'Today\'s death',
                            data: countryStatModel.todayDeaths.toString()),
                        const Divider(),
                        CustomDataRow(
                            title: 'Active cases',
                            data: countryStatModel.active.toString()),
                        CustomDataRow(
                            title: 'Critical cases',
                            data: countryStatModel.critical.toString()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

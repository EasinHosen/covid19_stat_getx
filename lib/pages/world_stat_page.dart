import 'package:covid19_stat/constants/page_const.dart';
import 'package:covid19_stat/controllers/rest_data_controller.dart';
import 'package:covid19_stat/utils/helper_functions.dart';
import 'package:covid19_stat/widgets/custom_data_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatPage extends StatefulWidget {
  const WorldStatPage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<WorldStatPage> createState() => _WorldStatPageState();
}

class _WorldStatPageState extends State<WorldStatPage> {
  // late final AnimationController _animationController = AnimationController(
  //   duration: const Duration(seconds: 3),
  //   vsync: this,
  // )..repeat();

  final colorList = [
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GetBuilder<RestDataController>(
          init: RestDataController(),
          builder: (controller) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: controller.fetched
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Today\'s case',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: PieChart(
                                  dataMap: {
                                    'Total': controller
                                        .worldStatModel.todayCases!
                                        .toDouble(),
                                    'Recovered': controller
                                        .worldStatModel.todayRecovered!
                                        .toDouble(),
                                    'Dead': controller
                                        .worldStatModel.todayDeaths!
                                        .toDouble(),
                                  },
                                  animationDuration:
                                      const Duration(milliseconds: 1200),
                                  colorList: colorList,
                                  chartType: ChartType.ring,
                                  chartRadius: Get.width / 3.2,
                                  legendOptions: const LegendOptions(
                                    legendPosition: LegendPosition.left,
                                  ),
                                  chartValuesOptions: const ChartValuesOptions(
                                    showChartValuesInPercentage: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //today's case card with pi chart
                        const SizedBox(height: 12),
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
                                    controller.date!,
                                    'dd-MMM-yyyy \n hh:mm a',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                CustomDataRow(
                                  title: 'Total tests',
                                  data: controller.worldStatModel.tests!
                                      .toString(),
                                ),
                                CustomDataRow(
                                  title: 'Total case',
                                  data: controller.worldStatModel.cases!
                                      .toString(),
                                ),
                                CustomDataRow(
                                    title: 'Total Recovered',
                                    data: controller.worldStatModel.recovered!
                                        .toString()),
                                CustomDataRow(
                                    title: 'Total Dead',
                                    data: controller.worldStatModel.deaths!
                                        .toString()),
                                const Divider(),
                                CustomDataRow(
                                    title: 'Today\'s case',
                                    data: controller.worldStatModel.todayCases!
                                        .toString()),
                                CustomDataRow(
                                    title: 'Today\'s recovered',
                                    data: controller
                                        .worldStatModel.todayRecovered!
                                        .toString()),
                                CustomDataRow(
                                    title: 'Today\'s death',
                                    data: controller.worldStatModel.todayDeaths!
                                        .toString()),
                                const Divider(),
                                CustomDataRow(
                                    title: 'Active cases',
                                    data: controller.worldStatModel.active!
                                        .toString()),
                                CustomDataRow(
                                    title: 'Critical cases',
                                    data: controller.worldStatModel.critical!
                                        .toString()),
                              ],
                            ),
                          ),
                        ),
                        //total statistics
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            Get.toNamed(pageCountryList);
                          },
                          child: const Text('Track Country'),
                        ),
                      ],
                    )
                  : SizedBox(
                      width: Get.width,
                      height: Get.height,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(),
                            Text('Loading...'),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

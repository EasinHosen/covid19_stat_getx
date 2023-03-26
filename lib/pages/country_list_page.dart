import 'package:covid19_stat/controllers/rest_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountryListPage extends StatelessWidget {
  CountryListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  final RestDataController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.getStatListOfCountries();
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GetBuilder<RestDataController>(
          builder: (controller) {
            return controller.listFetched
                ? ListView.builder(
                    itemCount: controller.list.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(controller.list[index].country!),
                        subtitle: Text(
                            'total cases: ${controller.list[index].cases!.toString()}'),
                        leading: Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image(
                            image: NetworkImage(
                                controller.list[index].countryInfo!.flag!),
                          ),
                        ),
                      );
                    },
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
                  );
          },
        ),
      ),
    );
  }
}

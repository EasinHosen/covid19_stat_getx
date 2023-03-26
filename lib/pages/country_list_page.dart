import 'package:covid19_stat/controllers/rest_data_controller.dart';
import 'package:covid19_stat/models/country_stat_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/page_const.dart';

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
        actions: [
          IconButton(
              onPressed: () => showSearch(
                    context: context,
                    delegate: MySearchDelegate(controller.list),
                  ),
              icon: const Icon(Icons.search))
        ],
      ),
      body: SafeArea(
        child: GetBuilder<RestDataController>(
          builder: (controller) {
            return controller.listFetched
                ? ListView.builder(
                    itemCount: controller.list.length,
                    itemBuilder: (context, index) {
                      return ListTile(
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
                        onTap: () => Get.toNamed(pageCountryDetails,
                            arguments: [controller.list[index]]),
                        subtitle: Text(
                            'total cases: ${controller.list[index].cases!.toString()}'),
                        title: Text(controller.list[index].country!),
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

class MySearchDelegate extends SearchDelegate {
  List<CountryStatModel> suggestion = [];
  MySearchDelegate(List<CountryStatModel> countryList) {
    suggestion = countryList;
  }

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query.isEmpty ? close(context, null) : query = '',
        )
      ];

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<CountryStatModel> suggestedCountry = suggestion.where((element) {
      final res = element.country!.toLowerCase();
      final input = query.toLowerCase();

      return res.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: suggestedCountry.length,
      itemBuilder: (context, index) {
        final countryName = suggestedCountry[index].country!;
        return ListTile(
          title: Text(countryName),
          onTap: () {
            query = countryName;
            close(context, null);
            Get.toNamed(pageCountryDetails,
                arguments: [suggestedCountry[index]]);
          },
        );
      },
    );
  }
}

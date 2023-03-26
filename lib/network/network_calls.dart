import 'dart:convert';

import 'package:covid19_stat/constants/urls.dart';
import 'package:covid19_stat/models/country_stat_model.dart';
import 'package:covid19_stat/models/world_stat_model.dart';
import 'package:http/http.dart';

class NetworkCalls {
  Future<WorldStatModel> getAllStat() async {
    final uri = Uri.parse(allStatUrl);

    try {
      final response = await get(uri);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return WorldStatModel.fromJson(json);
      } else {
        throw Exception('Error Fetching data');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CountryStatModel>> getCountryListStat() async {
    final uri = Uri.parse(countryListStatUrl);

    try {
      final response = await get(uri);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        List<CountryStatModel> list = [];
        for (Map i in json) {
          CountryStatModel model = CountryStatModel.fromJson(i);
          list.add(model);
        }
        return list;
      } else {
        throw Exception('Error Fetching data');
      }
    } catch (e) {
      rethrow;
    }
  }
}

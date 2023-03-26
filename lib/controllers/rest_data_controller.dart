import 'package:covid19_stat/models/country_stat_model.dart';
import 'package:covid19_stat/models/world_stat_model.dart';
import 'package:covid19_stat/network/network_calls.dart';
import 'package:get/get.dart';

class RestDataController extends GetxController {
  WorldStatModel worldStatModel = WorldStatModel();
  List<CountryStatModel> list = [];
  NetworkCalls networkCalls = NetworkCalls();
  bool fetched = false;
  bool listFetched = false;
  DateTime? date;

  @override
  void onInit() {
    _getWorldStat();
    super.onInit();
  }

  _getWorldStat() async {
    worldStatModel = await networkCalls.getAllStat();
    fetched = true;
    // print(worldStatModel.toString());
    date = DateTime.fromMillisecondsSinceEpoch(worldStatModel.updated!.toInt());
    // print(date);
    update();
  }

  getStatListOfCountries() async {
    // print('list called');
    list = await networkCalls.getCountryListStat();
    // print(list.length);
    listFetched = true;
    update();
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:truckle_drivers/src/Models/get/citiesModel.dart';
import 'package:truckle_drivers/src/Repository/appLocalization.dart';
import 'package:truckle_drivers/src/Repository/networkUtlisGenral.dart';

class CitiesProvider with ChangeNotifier {
  List<Cities> _cities = [];

  List<Cities> get coties {
    return [..._cities];
  }

  NetworkUtil _utils = new NetworkUtil();
  CitiesModel categoriesModel;
  Future<CitiesModel> getCities() async {
    final List<Cities> loadedCountries = [];
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString()
    };
    Response response = await _utils.get("cities", headers: headers);
    if (response.statusCode == 200) {
      print("get cities sucsseful");

      categoriesModel = CitiesModel.fromJson(response.data);

      categoriesModel.data.forEach((element) {
        loadedCountries.add(Cities(
          country: element.country,
          countryId: element.countryId,
          createdAt: element.createdAt,
          id: element.id,
          name: element.name,
          selected: false
        ));
      });
      _cities = loadedCountries.reversed.toList();
      notifyListeners();
      return CitiesModel.fromJson(response.data);
    } else {
      print("error get cities data");
      return CitiesModel.fromJson(response.data);
    }
  }
}

class Cities {
  Cities({
    @required this.id,
    @required this.name,
    @required this.countryId,
    @required this.country,
    @required this.createdAt,
    @required this.selected
  });

  int id;
  String name;
  int countryId;
  String country;
  bool selected;
  DateTime createdAt;
}

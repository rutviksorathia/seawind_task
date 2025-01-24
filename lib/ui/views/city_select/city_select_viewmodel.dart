import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:new_mobile_otp/models/city/city.dart';
import 'package:new_mobile_otp/models/country/country.dart';
import 'package:new_mobile_otp/ui/views/home/home_view.dart';
import 'package:stacked/stacked.dart';
import 'package:dio/dio.dart';

class CitySelectViewModel extends BaseViewModel {
  final Country selectedCountry;

  CitySelectViewModel({required this.selectedCountry});

  CityData? responseData;
  List<City> cities = [];
  TextEditingController searchCityController = TextEditingController();
  List<City> filteredItems = [];
  City? selectedCity;

  Future<void> fetchCities() async {
    setBusyForObject(fetchCities, true);
    try {
      Dio dio = Dio();
      var response = await dio.get(
        'https://www.bme.seawindsolution.ae/api/f/city/${selectedCountry.Id}',
      );

      responseData = CityData.fromMap(response.data);

      if (responseData != null) {
        cities = responseData!.responsedata;
        filteredItems = cities;
      }
      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      setBusyForObject(fetchCities, false);
    }
  }

  void filterItems(String query) {
    if (query.isEmpty) {
      filteredItems = cities;
    } else {
      filteredItems = cities
          .where(
              (item) => item.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    notifyListeners();
  }

  void handleCityCardTap(City city) {
    selectedCity = city;
    notifyListeners();
  }

  void handleContinueButtonTap() {
    if (selectedCity == null) return;
    Get.to(() => HomeView(
          cities: cities,
          selectedCity: selectedCity!,
          selectedCountry: selectedCountry,
        ));
  }
}

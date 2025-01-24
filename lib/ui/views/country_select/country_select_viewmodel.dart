import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:new_mobile_otp/models/country/country.dart';
import 'package:new_mobile_otp/ui/views/city_select/city_select_view.dart';
import 'package:stacked/stacked.dart';

class CountrySelectViewModel extends BaseViewModel {
  List<Country> counties = [];
  Data? responseData;
  TextEditingController searchCountryController = TextEditingController();
  List<Country> filteredItems = [];

  Future<void> fetchCountries() async {
    setBusyForObject(fetchCountries, true);
    try {
      Dio dio = Dio();
      var response = await dio.get(
        'https://www.bme.seawindsolution.ae/api/f/country',
      );

      responseData = Data.fromMap(response.data);

      if (responseData != null) {
        counties = responseData!.responsedata;
        filteredItems = counties;
      }
      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      setBusyForObject(fetchCountries, false);
    }
  }

  void filterItems(String query) {
    if (query.isEmpty) {
      filteredItems = counties;
    } else {
      filteredItems = counties
          .where(
              (item) => item.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    notifyListeners();
  }

  void handleCountryCardTap(Country selectedCountry) {
    Get.to(() => CitySelectView(selectedCountry: selectedCountry));
  }
}

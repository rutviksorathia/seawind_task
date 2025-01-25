import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:new_mobile_otp/models/category/category.dart';
import 'package:new_mobile_otp/models/city/city.dart';
import 'package:new_mobile_otp/models/slider/slider.dart';
import 'package:stacked/stacked.dart';

enum BottomNavigationBarTab {
  home,
  event,
  list_show,
  profile;

  String get content {
    switch (this) {
      case BottomNavigationBarTab.home:
        return "Home";
      case BottomNavigationBarTab.event:
        return "Event";
      case BottomNavigationBarTab.list_show:
        return "List Show";
      default:
        return "Profile";
    }
  }
}

class HomeViewModel extends BaseViewModel {
  SliderData? responseData;
  List<SliderItem> sliders = [];

  City selectedCity;
  int activeImageIndex = 0;
  List<String> movieCategory = [
    "Comedy",
    "Romantic",
    "Kid",
    "Gujarati",
    "Action"
  ];
  BottomNavigationBarTab selectedTab = BottomNavigationBarTab.home;

  HomeViewModel({required this.selectedCity}) {
    profilesScrollController.addListener(handleProfilesScrollView);
  }

  bool isScrollEventDispatched = false;
  ScrollController profilesScrollController = ScrollController();

  void handleProfilesScrollView() {
    if (profilesScrollController.position.extentAfter <= 100) {
      if (!isScrollEventDispatched) {
        isScrollEventDispatched = true;
      }
    } else {
      isScrollEventDispatched = false;
    }
    notifyListeners();
  }

  void postImagesIndicator(int index) {
    activeImageIndex = index;
    notifyListeners();
  }

  // Fetch Slider

  Future<void> fetchSliderList() async {
    setBusyForObject(fetchSliderList, true);
    try {
      Dio dio = Dio();
      var response = await dio.get(
        'https://www.bme.seawindsolution.ae/api/f/slider',
      );

      responseData = SliderData.fromMap(response.data);

      if (responseData != null) {
        sliders = responseData!.responsedata;
        notifyListeners();
      }

      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      setBusyForObject(fetchSliderList, false);
    }
  }

  // Fetch Category

  CategoryData? responseCategoryData;
  List<Category> categories = [];

  Future<void> fetchCategoryList() async {
    setBusyForObject(fetchSliderList, true);
    try {
      Dio dio = Dio();
      var response = await dio.get(
        'https://www.bme.seawindsolution.ae/api/f/category',
      );

      print(response);

      responseCategoryData = CategoryData.fromMap(response.data);

      if (responseCategoryData != null) {
        categories = responseCategoryData!.responsedata;
        notifyListeners();
      }

      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      setBusyForObject(fetchSliderList, false);
    }
  }

  void handleTabBarButtonTap(BottomNavigationBarTab tab) {
    selectedTab = tab;
    notifyListeners();
  }
}

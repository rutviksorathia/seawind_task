import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:new_mobile_otp/models/city/city.dart';
import 'package:new_mobile_otp/models/country/country.dart';
import 'package:new_mobile_otp/ui/views/base_page_indicator.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  final List<City> cities;
  final City selectedCity;
  final Country selectedCountry;

  const HomeView({
    Key? key,
    required this.cities,
    required this.selectedCity,
    required this.selectedCountry,
  }) : super(key: key);

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    viewModel.selectedCity = selectedCity;
    viewModel.fetchSliderList();
    viewModel.fetchCategoryList();
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel(selectedCity: selectedCity);
  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    decoration: ShapeDecoration(
                      shape: SmoothRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                      ),
                      color: Colors.pink,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).padding.top),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 25,
                                    width: 50,
                                    decoration: ShapeDecoration(
                                      shape: SmoothRectangleBorder(
                                        smoothness: 1,
                                        borderRadius: BorderRadius.circular(5),
                                        side: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Container(
                                        height: 30,
                                        width: 40,
                                        decoration: ShapeDecoration(
                                          shape: SmoothRectangleBorder(
                                            smoothness: 1,
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            side: BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Stack(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                        child: Text(
                                          "BooK My",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: -2,
                                        child: Center(
                                          child: Text(
                                            "Event",
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Container(
                                  color: Colors.transparent,
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Stack(
                                      children: [
                                        DropdownButton<City>(
                                          items: cities.map((City value) {
                                            return DropdownMenuItem<City>(
                                              value: value,
                                              child: Text(value.title),
                                            );
                                          }).toList(),
                                          hint: Text(
                                            "Current Location",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                          onChanged: (city) {
                                            if (city != null) {
                                              viewModel.selectedCity = city;
                                            }
                                            viewModel.notifyListeners();
                                          },
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          child: Row(
                                            children: [
                                              Text(
                                                viewModel.selectedCity.title,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 18,
                                                width: 40,
                                                child: Image.network(
                                                  selectedCountry.image,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                child: Icon(
                                  Icons.notifications_active,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 20),
                              GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  Icons.menu,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Row(
                            children: [
                              Flexible(
                                child: TextField(
                                  style: TextStyle(height: 0.5),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Colors.pink,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelText: "Search Country",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(28),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Container(
                                decoration: ShapeDecoration(
                                  shape: SmoothRectangleBorder(
                                    smoothness: 1,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 12),
                                  child: Text(
                                    "ListYourShow",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Container(
                                decoration: ShapeDecoration(
                                  shape: SmoothRectangleBorder(
                                    smoothness: 1,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 12),
                                  child: Text(
                                    "Offers",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!viewModel.isScrollEventDispatched)
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: CarouselSlider.builder(
                              options: CarouselOptions(
                                aspectRatio: 9,
                                autoPlay: true,
                                enableInfiniteScroll: true,
                                viewportFraction: 0.4,
                                autoPlayInterval: const Duration(seconds: 5),
                              ),
                              itemCount: viewModel.movieCategory.length,
                              itemBuilder: (context, index, realIndex) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Container(
                                      width: double.infinity,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        shape: SmoothRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          smoothness: 1,
                                        ),
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                        child: Text(
                                          viewModel.movieCategory[index],
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.pink,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: viewModel.profilesScrollController,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        if (viewModel.busy(viewModel.fetchSliderList) ||
                            viewModel.busy(viewModel.fetchCategoryList))
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: SizedBox(
                              width: double.infinity,
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.pink,
                                )),
                              ),
                            ),
                          ),
                        SizedBox(height: 30),
                        if (viewModel.sliders.isNotEmpty)
                          CarouselSlider.builder(
                            options: CarouselOptions(
                              aspectRatio: 2.5,
                              autoPlay: true,
                              enableInfiniteScroll: true,
                              viewportFraction: 1,
                              autoPlayInterval: const Duration(seconds: 15),
                              onPageChanged: (index, reason) {
                                viewModel.postImagesIndicator(index);
                              },
                            ),
                            itemCount: viewModel.sliders.length,
                            itemBuilder: (context, index, realIndex) {
                              return GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Container(
                                    width: double.infinity,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      shape: SmoothRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        smoothness: 1,
                                      ),
                                    ),
                                    child: Image.network(
                                      viewModel.sliders[index].image,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: BasePageIndicator(
                              indicatorList: viewModel.sliders,
                              activeIndicatorIndex: viewModel.activeImageIndex,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        if (viewModel.categories.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "P R E M I E R E",
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Icon(
                                          Icons.play_circle,
                                          color: Colors.pink,
                                          size: 30,
                                        )
                                      ],
                                    ),
                                    Text(
                                      "Watch new popular events",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "See All",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.pink,
                                      ),
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      color: Colors.pink,
                                      size: 30,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        SizedBox(height: 10),
                        if (viewModel.categories.isNotEmpty)
                          CarouselSlider.builder(
                            options: CarouselOptions(
                              aspectRatio: 1.2,
                              autoPlay: true,
                              enableInfiniteScroll: true,
                              viewportFraction: 0.4,
                              autoPlayInterval: const Duration(seconds: 5),
                            ),
                            itemCount: viewModel.categories.length,
                            itemBuilder: (context, index, realIndex) {
                              return GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: ShapeDecoration(
                                          shape: SmoothRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            smoothness: 1,
                                          ),
                                        ),
                                        child: Image.network(
                                          viewModel.categories[index].image,
                                          fit: BoxFit.cover,
                                          height: 250,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        width: double.infinity,
                                        decoration: ShapeDecoration(
                                          shape: SmoothRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          color: Colors.grey.shade100,
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              viewModel.categories[index].title,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        SizedBox(height: 200),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              decoration: ShapeDecoration(
                shape: SmoothRectangleBorder(),
                shadows: [
                  BoxShadow(
                    color: Colors.greenAccent,
                    offset: const Offset(
                      5.0,
                      5.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  ), //BoxShadow
                  BoxShadow(
                    color: Colors.white,
                    offset: const Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  ),
                ],
                color: Colors.white,
              ),
              child: Row(
                children: [
                  ...BottomNavigationBarTab.values.map((e) {
                    IconData getIcon(BottomNavigationBarTab selectedTab) {
                      switch (selectedTab) {
                        case BottomNavigationBarTab.home:
                          return Icons.home;
                        case BottomNavigationBarTab.event:
                          return Icons.event;
                        case BottomNavigationBarTab.list_show:
                          return Icons.insert_page_break;

                        default:
                          return Icons.person;
                      }
                    }

                    return Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Center(
                        child: GestureDetector(
                          onTap: () => viewModel.handleTabBarButtonTap(e),
                          child: Container(
                            color: Colors.transparent,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  getIcon(e),
                                  size: 30,
                                  color: e == viewModel.selectedTab
                                      ? Colors.pink
                                      : Colors.black,
                                ),
                                Text(
                                  e.content,
                                  style: TextStyle(
                                    color: e == viewModel.selectedTab
                                        ? Colors.pink
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

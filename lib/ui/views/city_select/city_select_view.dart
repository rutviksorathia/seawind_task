import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:new_mobile_otp/models/country/country.dart';
import 'package:stacked/stacked.dart';

import 'city_select_viewmodel.dart';

class CitySelectView extends StackedView<CitySelectViewModel> {
  final Country selectedCountry;

  const CitySelectView({Key? key, required this.selectedCountry})
      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CitySelectViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(
            left: 25.0,
            right: 25.0,
            top: MediaQuery.of(context).padding.top + 10),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: Get.back,
                      child: Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                    ),
                    SizedBox(width: 40),
                    Text(
                      "Pick a Region",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30),
                TextField(
                  controller: viewModel.searchCityController,
                  keyboardType: TextInputType.text,
                  onChanged: (value) => viewModel.filterItems(value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.pink,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Search for your city",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(28),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                if (!viewModel.busy(viewModel.fetchCities))
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pick a Region",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 3,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 40.0,
                            mainAxisSpacing: 40.0,
                            children: <Widget>[
                              ...viewModel.filteredItems.map(
                                (e) => GestureDetector(
                                  onTap: () => viewModel.handleCityCardTap(e),
                                  child: Column(
                                    children: [
                                      Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                          border: Border.all(
                                            width: 1,
                                            color: e == viewModel.selectedCity
                                                ? Colors.pink
                                                : Colors.black,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.network(
                                            e.image,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                      GestureDetector(
                                        onTap: () =>
                                            viewModel.handleCityCardTap(e),
                                        child: Text(e.title,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: e == viewModel.selectedCity
                                                  ? Colors.pink
                                                  : Colors.black,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  SizedBox(
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
                //
              ],
            ),
            if (viewModel.selectedCity != null)
              Positioned(
                left: 0,
                right: 0,
                bottom: MediaQuery.of(context).padding.bottom + 10,
                child: GestureDetector(
                  onTap: () => viewModel.handleContinueButtonTap(),
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      color: Colors.pink,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  "Continue",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                color: Colors.pink.shade800,
                              ),
                              child: Icon(
                                Icons.chevron_right,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  CitySelectViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CitySelectViewModel(selectedCountry: selectedCountry);

  @override
  void onViewModelReady(CitySelectViewModel viewModel) {
    viewModel.fetchCities();
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
  }
}

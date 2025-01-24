import 'package:flutter/material.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:stacked/stacked.dart';

import 'country_select_viewmodel.dart';

class CountrySelectView extends StackedView<CountrySelectViewModel> {
  const CountrySelectView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(CountrySelectViewModel viewModel) {
    viewModel.fetchCountries();
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    CountrySelectViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        padding: EdgeInsets.only(
          left: 25.0,
          right: 25.0,
          top: MediaQuery.of(context).padding.top,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Country",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: viewModel.searchCountryController,
              keyboardType: TextInputType.text,
              onChanged: (value) => viewModel.filterItems(value),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
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
            SizedBox(height: 10),
            if (!viewModel.busy(viewModel.fetchCountries))
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      ...viewModel.filteredItems.map((e) => GestureDetector(
                            onTap: () => viewModel.handleCountryCardTap(e),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Container(
                                    height: 200,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                        shape: SmoothRectangleBorder(
                                      smoothness: 1,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    )),
                                    child: Image.network(
                                      e.image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  e.title,
                                  style: TextStyle(
                                      color: Colors.pink,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ))
                    ],
                  ),
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
              )
          ],
        ),
      ),
    );
  }

  @override
  CountrySelectViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CountrySelectViewModel();
}

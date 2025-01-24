import 'package:flutter_test/flutter_test.dart';
import 'package:new_mobile_otp/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('CitySelectViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}

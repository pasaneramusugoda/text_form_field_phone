import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:stacked/stacked.dart';

class TextFormFieldPhoneViewModel extends BaseViewModel {
  final TextEditingController controller = TextEditingController();

  String _defaultCountryCode = 'LK';

  String get defaultCountryCode => _defaultCountryCode;

  set defaultCountryCode(String defaultCountryCode) {
    _defaultCountryCode = defaultCountryCode;
    notifyListeners();
  }

  CountryWithPhoneCode _countryWithPhoneCode;

  CountryWithPhoneCode get countryWithPhoneCode => _countryWithPhoneCode;

  set countryWithPhoneCode(CountryWithPhoneCode countryWithPhoneCode) {
    _countryWithPhoneCode = countryWithPhoneCode;
    notifyListeners();
  }

  CountryCode _countryCode;

  CountryCode get countryCode => _countryCode;

  set countryCode(CountryCode countryCode) {
    _countryCode = countryCode;
    notifyListeners();
  }

  void init() {
    countryWithPhoneCode = CountryManager().countries.singleWhere((element) =>
        element.countryCode ==
        (DateTime.now().timeZoneName == '+0530'
            ? 'LK'
            : CountryManager().deviceLocaleCountryCode));

    if (countryWithPhoneCode != null)
      defaultCountryCode = countryWithPhoneCode.countryCode;
  }

  void onCountryCodeChanged(CountryCode value) {
    controller.clear();
    countryCode = value;
    countryWithPhoneCode = CountryManager()
        .countries
        .singleWhere((element) => element.countryCode == countryCode.code);
  }
}

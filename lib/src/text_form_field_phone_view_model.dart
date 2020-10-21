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

  void init(String initialPhoneNumber) {
    var _code1 = CountryManager().countries.singleWhere((element) =>
        element.countryCode ==
        (DateTime.now().timeZoneName == '+0530'
            ? 'LK'
            : CountryManager().deviceLocaleCountryCode));

    if (_code1 != null) {
      countryWithPhoneCode = _code1;
      defaultCountryCode = _code1.countryCode;
    }

    if (initialPhoneNumber != null) {
      FlutterLibphonenumber().parse(initialPhoneNumber).then((value) {
        print(value);
        var _code2 = CountryManager().countries.singleWhere(
            (element) => element.phoneCode == value['country_code'],
            orElse: null);

        if (_code2 != null) {
          countryWithPhoneCode = _code2;
          defaultCountryCode = _code2.countryCode;
          controller.text = value['national_number'];
        }
      }, onError: (error) => print(error));
    }
  }

  void onCountryCodeChanged(CountryCode value) {
    if (countryWithPhoneCode.countryCode != value.code) controller.clear();

    countryCode = value;
    countryWithPhoneCode = CountryManager()
        .countries
        .singleWhere((element) => element.countryCode == countryCode.code);
  }
}

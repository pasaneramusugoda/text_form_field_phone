import 'dart:async';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:stacked/stacked.dart';
import 'package:text_form_field_phone/src/text_form_field_phone_view_model.dart';
import 'package:text_form_field_phone/src/validators.dart';

class TextFormFieldPhone
    extends ViewModelBuilderWidget<TextFormFieldPhoneViewModel> {
  final FutureOr Function(String val) onFormatFinished;

  TextFormFieldPhone({@required this.onFormatFinished});

  @override
  Widget builder(
      BuildContext context, TextFormFieldPhoneViewModel model, Widget child) {
    return IntrinsicHeight(
      child: Container(
        child: Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          mainAxisAlignment: MainAxisAlignment.center,
          textBaseline: TextBaseline.alphabetic,
          children: [
            CountryListPick(
              onChanged: model.onCountryCodeChanged,
              initialSelection: model.defaultCountryCode,
              pickerBuilder: (context, countryCode) {
                return Flex(
                  direction: Axis.horizontal,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Image.asset(
                          countryCode.flagUri,
                          package: 'country_list_pick',
                          width: 32.0,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        '',
                        style: TextStyle(color: Colors.transparent),
                      ),
                    ),
                    Flexible(
                      child: Icon(Icons.keyboard_arrow_down,
                          color: Colors.black54),
                    )
                  ],
                );
              },
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: Container(
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: Validators.validateRequired,
                  controller: model.controller,
                  inputFormatters: [
                    LibPhonenumberTextFormatter(
                      onFormatFinished: onFormatFinished,
                      overrideSkipCountryCode:
                          model.countryCode?.code ?? model.defaultCountryCode,
                    ),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Enter Mobile Number',
                    hintText:
                        model.countryWithPhoneCode?.exampleNumberMobileNational,
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
  TextFormFieldPhoneViewModel viewModelBuilder(BuildContext context) =>
      TextFormFieldPhoneViewModel();

  @override
  void onViewModelReady(TextFormFieldPhoneViewModel model) => model.init();
}

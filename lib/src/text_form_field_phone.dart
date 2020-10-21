import 'dart:async';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:stacked/stacked.dart';
import 'package:text_form_field_phone/src/text_form_field_phone_view_model.dart';
import 'package:text_form_field_phone/src/validators.dart';

class TextFormFieldPhone
    extends ViewModelBuilderWidget<TextFormFieldPhoneViewModel> {
  final FutureOr Function(String val) onFormatFinished;
  final String initialPhoneNumber;
  final bool enabled;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final InputDecoration decoration;

  final Color downIconColor;

  TextFormFieldPhone(
      {@required this.onFormatFinished,
      this.initialPhoneNumber,
      this.enabled = true,
      this.focusNode,
      this.textInputAction,
      this.decoration,
      this.downIconColor = Colors.black54});

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
            IgnorePointer(
              ignoring: !enabled,
              child: CountryCodePicker(
                onChanged: model.onCountryCodeChanged,
                initialSelection: model.defaultCountryCode,
                builder: (countryCode) {
                  return Flex(
                    direction: Axis.horizontal,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Image.asset(
                            countryCode.flagUri,
                            package: 'country_code_picker',
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
                      // Flexible(
                      //   child: Icon(
                      //     Icons.keyboard_arrow_down,
                      //     color: downIconColor,
                      //   ),
                      // )
                    ],
                  );
                },
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: Container(
                child: TextFormField(
                  focusNode: focusNode,
                  enabled: enabled,
                  maxLines: 1,
                  keyboardType: TextInputType.phone,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: Validators.validateRequired,
                  controller: model.controller,
                  textInputAction: textInputAction,
                  inputFormatters: [
                    LibPhonenumberTextFormatter(
                      onFormatFinished: (val) {
                        onFormatFinished(
                            '+${model.countryWithPhoneCode.phoneCode} $val');
                      },
                      phoneNumberFormat: PhoneNumberFormat.national,
                      phoneNumberType: PhoneNumberType.mobile,
                      overrideSkipCountryCode:
                          model.countryCode?.code ?? model.defaultCountryCode,
                    ),
                  ],
                  decoration: decoration.copyWith(
                    labelText:
                    decoration.labelText ?? 'Enter Mobile Number',
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
  void onViewModelReady(TextFormFieldPhoneViewModel model) =>
      model.init(initialPhoneNumber);
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_theme.dart';

class UiComponent {
  bool obscureText = false;



  Widget textFildeComponent(
      {int? maxLength,
      TextInputType? inputType,
      required BuildContext context,
      required String fildeName,
      required TextEditingController? controller,
      Widget? prfixIcon,
      Widget? sufixIcon,
      bool? readOnly,
      double? symmetricPadding = 30,
      double? radiusAll = 20,
      var value}) {
    bool temp = true;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: symmetricPadding!),
      child: Directionality(
        textDirection: TextDirection.rtl, // set this property
        child: PhysicalModel(
          shadowColor: AppColors.secondary,
          borderRadius: BorderRadius.circular(radiusAll!),
          color: Colors.white,
          elevation: 3.0,
          child: Container(
            child: TextFormField(
              readOnly: readOnly ?? false,
              autofocus: false,
              keyboardType: inputType,
              controller: controller,
              inputFormatters: [
                LengthLimitingTextInputFormatter(maxLength),
              ],
              style:AppTextTheme.textTheme.bodyLarge,
              decoration: InputDecoration(
                filled: true,
                fillColor:AppColors.secondary,
                hintText: fildeName,
                hintStyle: AppTextTheme.textTheme.bodyLarge,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(5),
                  child: prfixIcon,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radiusAll),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radiusAll),
                  borderSide: BorderSide(
                    width: 2,
                    color: AppColors.secondary,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textFildePassComponent({
    int? maxLength,
    TextInputType? inputType,
    required BuildContext context,
    required String fildeName,
    required TextEditingController? controller,
    required Widget prfixIcon,
    required Widget sufixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Directionality(
        textDirection: TextDirection.rtl, // set this property
        child: PhysicalModel(
          shadowColor: AppColors.secondary,
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          elevation: 3.0,
          child: Container(
            child: TextField(
              controller: controller,
              autofocus: false,
              keyboardType: inputType,
              inputFormatters: [
                LengthLimitingTextInputFormatter(maxLength),
              ],
              style: AppTextTheme.textTheme.bodyLarge,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.primary,
                hintText: fildeName,
                hintStyle:AppTextTheme.textTheme.bodyLarge,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(5),
                  // add padding to adjust icon
                  child: prfixIcon,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(5),
                  // add padding to adjust icon
                  child: sufixIcon,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    width: 2,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  checkInternet(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        return true;
      } else {
        print('not connected');
        return showDialogCuotom(
            const Icon(
              Icons.wifi_off,
              size: 40,
            ),
            'عدم اتصال به اینترنت',
            'اتصال شما به اینترنت برقرار نیست برای استفاده از سرویس هیرا باید به اینترنت متصل شوید',
            [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                      //  AppSettings.openAppSettingsPanel(AppSettingsPanelType.internetConnectivity);
                        print('------------------click  internet I1');
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xff2278ba),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(31.0),
                          ),
                        ),
                        height: 60,
                        child: const Center(
                          child: Text(
                            'اینترنت موبایل',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        //AppSettings.openAppSettingsPanel(AppSettingsPanelType.wifi);
                        print('------------------click  internet w1');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff09b87b),
                          borderRadius: new BorderRadius.only(
                            bottomRight: const Radius.circular(31.0),
                          ),
                        ),
                        height: 60,
                        child: const Center(
                          child: Text(
                            ' wi-fi اینترنت ',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            context);
      }
    } on SocketException catch (_) {
      print('not connected');
      return showDialogCuotom(
          const Icon(
            Icons.wifi_off,
            size: 40,
          ),
          'عدم اتصال به اینترنت',
          'اتصال شما به اینترنت برقرار نیست برای استفاده از سرویس هیرا باید به اینترنت متصل شوید',
          [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      //AppSettings.openAppSettingsPanel(AppSettingsPanelType.internetConnectivity);
                      print('------------------click  internet I2');
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xff2278ba),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(31.0),
                        ),
                      ),
                      height: 60,
                      child: const Center(
                        child: Text(
                          'اینترنت موبایل',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      //AppSettings.openAppSettingsPanel(AppSettingsPanelType.wifi);
                      print('------------------click  internet w2');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff09b87b),
                        borderRadius: new BorderRadius.only(
                          bottomRight: const Radius.circular(31.0),
                        ),
                      ),
                      height: 60,
                      child: const Center(
                        child: Text(
                          ' wi-fi اینترنت ',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
          context);
    }
  }

  showDialogCuotom(Icon icon, String title, String body, List<Widget> list,
      BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              insetPadding: const EdgeInsets.all(20),
              elevation: 4,
              iconColor: const Color(0xff09b87b),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0))),
              actionsOverflowButtonSpacing: 0,
              clipBehavior: Clip.none,
              icon: icon,
              title: Text(
                title,
                textAlign: TextAlign.center,
              ),
              content: Text(
                body,
                textAlign: TextAlign.center,
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: list);
        });
  }


}

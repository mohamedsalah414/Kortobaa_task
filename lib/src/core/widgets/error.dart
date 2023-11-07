import 'package:flutter/material.dart';
import 'package:krtobaa_task/src/core/utils/helper_extenstions.dart';

import '../utils/app_colors.dart';
import 'text_widget.dart';

class ErrorHandling {
  static Widget errorHandling({String? txt }) {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline,
            size: 50,
            color: AppColor.black,
          ),
          10.ph,
           TextWidget(txt: txt??'Error'),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:krtobaa_task/src/core/utils/helper_extenstions.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_values.dart';
import '../../../../core/widgets/text_widget.dart';

class FormFieldWithTitle extends StatefulWidget {
 final String title;
 final TextEditingController controller;
 final TextInputType textInputType;
 final bool obscureText;
  const FormFieldWithTitle({super.key, required this.title, required this.controller, required this.textInputType, required this.obscureText});

  @override
  State<FormFieldWithTitle> createState() => _FormFieldWithTitleState();
}

class _FormFieldWithTitleState extends State<FormFieldWithTitle> {
  bool _hidePassword = true;
  @override
  void initState() {
    super.initState();
    _hidePassword = widget.obscureText;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          txt: widget.title,
          fontSize: 14,
          fontWeight: FontWeightManger.bold,
          color: AppColor.textGrey,
        ),
        10.ph,
        TextFormField(
          controller: widget.controller,
          validator: (value) {
            if (value!.isEmpty ) {
              return AppStrings.required;
            }
            return null;
          },
          style: const TextStyle(
              color: AppColor.cyan,
              fontSize: 14,
              fontWeight: FontWeightManger.bold),
          obscureText: widget.obscureText ? _hidePassword : false,
          obscuringCharacter: '*',
          decoration: InputDecoration(
            prefixIcon:  widget.obscureText
                ? InkWell(
              onTap: () {
                setState(() {
                  _hidePassword = !_hidePassword;
                });
              },
              child: const Icon(
                Icons.remove_red_eye,
                color: AppColor.grey,
              ),
            )
                : null,
            filled: true,
            fillColor: AppColor.white,
            hintTextDirection: TextDirection.rtl,
            hintText: widget.title,
            hintStyle: const TextStyle(
                color: AppColor.cyan,
                fontSize: 14,
                fontWeight: FontWeightManger.bold),
          ),
          textDirection: TextDirection.rtl,
          keyboardType: widget.textInputType,
        ),
      ],
    );
  }
}

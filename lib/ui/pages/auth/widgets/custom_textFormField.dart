import 'package:flutter/material.dart';

class CustomTextformfield extends StatelessWidget {
  final String title;
  final IconData iconData;
  final bool obscureText;
  final bool isDarkMode;
  final BuildContext buildContext;
  final FormFieldValidator validator;
  final FormFieldSetter onSaved;
  final TextInputType? keyboardType;
  final bool? enabled;
  final TextEditingController? controller;
  final ValueChanged? onChanged;
  final VoidCallback? onPressed;

  const CustomTextformfield({
    required this.title,
    required this.iconData,
    required this.obscureText,
    required this.isDarkMode,
    required this.buildContext,
    required this.validator,
    required this.onSaved,
    this.keyboardType,
    this.enabled,
    this.controller,
    this.onChanged,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(buildContext).textTheme.labelMedium,
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          obscureText: obscureText,
          validator: validator,
          onSaved: onSaved,
          autofocus: false,
          autovalidateMode: AutovalidateMode.onUnfocus,
          keyboardType: keyboardType,
          enabled: enabled ?? true,
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
              hintText: title,
              hintStyle: Theme.of(buildContext).textTheme.labelLarge,
              prefixIcon: Icon(
                iconData,
                color: !isDarkMode ? Colors.grey : Colors.white,
                size: 20,
              ),
              // 기본 TextFormField 디자인을 설정한다.
              enabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: !isDarkMode ? Colors.grey : Colors.white),
              ),
              // 터치 시 활성화된 디자인 설정
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color:
                        !isDarkMode ? const Color(0xFF4D77B2) : Colors.white),
              ),
              // 유효성 검사 실패 시 사용되는 디자인 설정
              errorBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: !isDarkMode ? Colors.red : Colors.white),
              ),
              // 에러 발생 후 터치 시 사용되는 디자인 설정
              focusedErrorBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: !isDarkMode ? Colors.red : Colors.white),
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: !isDarkMode ? Colors.grey : Colors.grey),
              )),
        ),
      ],
    );
  }
}

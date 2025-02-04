import 'package:flutter/material.dart';

class CustomTextformfield extends StatelessWidget {
  final String title;
  final IconData iconData;
  final bool obscureText;
  final TextEditingController controller;
  final bool isDarkMode;
  final BuildContext buildContext;

  const CustomTextformfield({
    required this.title,
    required this.iconData,
    required this.obscureText,
    required this.controller,
    required this.isDarkMode,
    required this.buildContext,
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
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '$title를 입력해주세요';
            }
            return null;
          },
          autofocus: false,
          decoration: InputDecoration(
            hintText: title,
            hintStyle: Theme.of(buildContext).textTheme.labelLarge,
            prefixIcon: Icon(
              iconData,
              color: !isDarkMode ? Colors.grey : Colors.white,
              size: 20,
            ),
            // 기본 TextFormField 디자인을 설정한다.
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide:
                  BorderSide(color: !isDarkMode ? Colors.grey : Colors.white),
            ),
            // 터치 시 활성화된 디자인 설정
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide:
                  BorderSide(color: !isDarkMode ? Colors.grey : Colors.white),
            ),
            // 유효성 검사 실패 시 사용되는 디자인 설정
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide:
                  BorderSide(color: !isDarkMode ? Colors.grey : Colors.white),
            ),
            // 에러 발생 후 터치 시 사용되는 디자인 설정
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide:
                  BorderSide(color: !isDarkMode ? Colors.grey : Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

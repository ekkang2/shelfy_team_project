import 'package:flutter/material.dart';

class CustomModalBottomSheet extends StatefulWidget {
  const CustomModalBottomSheet({super.key});

  @override
  State<CustomModalBottomSheet> createState() => _CustomModalBottomSheetState();
}

class _CustomModalBottomSheetState extends State<CustomModalBottomSheet> {
  // 서비스 이용약관 동의 여부
  bool _isTerm1Agreed = false;

  // 개인정보수집 및 이용 동의 여부
  bool _isTerm2Agreed = false;

  // 라디오 버튼 선택 : 'over14' 는 만 14세 이상, 'under14'는 만 14세 미만
  String? _selectedAge;

  // 세 가지 조건을 모두 충족하면 true를 반환하는 bool
  bool get _isAllAgreed {
    return _isTerm1Agreed && _isTerm2Agreed && _selectedAge == 'over14';
  }

  @override
  Widget build(BuildContext context) {
    // 화면 크기 조정을 위해 미리 준비
    final mediaQuery = MediaQuery.of(context);
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCheckBoxListTile(
                  title: '(필수) 서비스 이용약관 동의',
                  value: _isTerm1Agreed,
                  url: '/terms1',
                  onChanged: (newValue) {
                    setState(() {
                      _isTerm1Agreed = newValue ?? false;
                    });
                  }),
              buildCheckBoxListTile(
                title: '(필수) 개인정보 수집 및 이용 동의',
                value: _isTerm2Agreed,
                url: '/terms2',
                onChanged: (newValue) {
                  setState(() {
                    _isTerm2Agreed = newValue ?? false;
                  });
                },
              ),
              Divider(color: Colors.grey[300]),
              Text('최소 연령 확인', style: Theme.of(context).textTheme.titleMedium),
              // radio 선택지 1 ( 만 14세 이상 )
              buildRadioListTile(
                title: '만 14세 이상',
                valueText: 'over14',
                groupValue: _selectedAge,
                onChanged: (value) {
                  setState(() {
                    _selectedAge = value;
                  });
                },
              ),
              // radio 선택지 2 ( 만 14세 미만 )
              buildRadioListTile(
                title: '만 14세 미만',
                valueText: 'under14',
                groupValue: _selectedAge,
                onChanged: (value) {
                  setState(() {
                    _selectedAge = value;
                  });
                },
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      !_isAllAgreed
                          ? Colors.grey[500]
                          : !isDarkMode
                              ? const Color(0xFF4D77B2)
                              : Colors.white,
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    minimumSize: WidgetStatePropertyAll(
                      Size(double.infinity, 35.0),
                    ),
                  ),
                  onPressed: _isAllAgreed
                      ? () {
                          // 모두 동의되었다면?
                          Navigator.pushNamed(context, '/join');
                        }
                      : null,
                  child: Text(
                    '시작하기',
                    style: TextStyle(
                      color: !isDarkMode ? Colors.white : Colors.grey[800],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  RadioListTile<String> buildRadioListTile({
    required String title,
    required String valueText,
    required String? groupValue,
    required onChanged,
  }) {
    return RadioListTile(
      title: Text(title),
      value: valueText,
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }

  CheckboxListTile buildCheckBoxListTile({
    required bool value,
    required String title,
    required String url,
    required onChanged,
  }) {
    return CheckboxListTile(
      title: Row(
        children: [
          Expanded(
            flex: 9,
            child: Text(title),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              highlightColor: Colors.transparent,
              onPressed: () {
                if (mounted) {
                  Navigator.pushNamed(context, url);
                }
                return;
              },
              icon: Icon(Icons.keyboard_arrow_right),
            ),
          ),
        ],
      ),
      value: value,
      onChanged: onChanged,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}

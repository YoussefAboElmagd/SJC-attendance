import 'package:flutter/material.dart';
import 'package:madarj/Feature/LanguageOption/Ui/widgets/arabic_language.dart';
import 'package:madarj/Feature/LanguageOption/Ui/widgets/english_language.dart';
import 'package:madarj/Feature/LanguageOption/Ui/widgets/lang_custom_appbar.dart';

class LanguageOptionsBody extends StatelessWidget {
  const LanguageOptionsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomAppbar(),
          Container(
            height: 1,
            width: double.infinity,
            color: const Color.fromRGBO(217, 217, 217, 1),
          ),
          const EnglishLanguage(),
          Container(
            height: 1,
            width: double.infinity,
            color: const Color.fromRGBO(217, 217, 217, 1),
          ),
          const ArabicLanguage(),
          Container(
            height: 1,
            width: double.infinity,
            color: const Color.fromRGBO(217, 217, 217, 1),
          ),
          // const ArabicLanguage(),
        ],
      ),
    );
  }
}

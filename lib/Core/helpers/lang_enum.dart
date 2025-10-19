import 'package:flutter/material.dart';
import 'package:madarj/Core/helpers/extensions.dart';

enum LangEnum { en, ar }

extension AppLanguageExtension on LangEnum {
  String displayName(BuildContext context) {
    switch (this) {
      case LangEnum.ar:
        return context.s.arabic;
      case LangEnum.en:
        return context.s.english;
    }
  }
}

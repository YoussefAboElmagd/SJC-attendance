// -----------------------------------------------------------------------------
// File: lang_enum.dart
// Description: Enum for lang
// Author(s): Ahmed Eid Ibrahim
// Changes:
// 2025-10-19: Ahmed Eid Ibrahim – Created file
// -----------------------------------------------------------------------------

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

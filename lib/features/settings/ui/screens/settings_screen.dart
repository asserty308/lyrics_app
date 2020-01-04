import 'package:flutter/material.dart';
import 'package:flutter_core/ui/widgets/center_text.dart';
import 'package:flutter_core/modules/i18n/context_localization.dart';


class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CenterText(context.localize('under_construction'));
  }
}
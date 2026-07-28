import 'package:flutter/material.dart';
import '../settings/app_settings.dart';

mixin SettingsAwareWidget {
  AppSettings get settings => AppSettings.instance;
}

// ویجت کمکی برای اعمال تنظیمات به هر صفحه
class SettingsAwareBuilder extends StatelessWidget {
  final Widget Function(BuildContext, AppSettings) builder;

  const SettingsAwareBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return builder(context, AppSettings.instance);
  }
}
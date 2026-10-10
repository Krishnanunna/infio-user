import 'package:flutter/material.dart';

import 'router/app_router.dart';
import 'theme/app_theme.dart';
import 'widgets/responsive_phone_frame.dart';

void main() {
  runApp(const InfioApp());
}

class InfioApp extends StatelessWidget {
  const InfioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'InFio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: appRouter,
      builder: (context, child) =>
          ResponsivePhoneFrame(child: child ?? const SizedBox.shrink()),
    );
  }
}

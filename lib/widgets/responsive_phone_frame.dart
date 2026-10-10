import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// InFio is built mobile-first (matching the Stitch phone mockups) with no
/// responsive breakpoints of its own. Viewed in a normal wide desktop
/// browser window — e.g. via `flutter run -d chrome`, which doesn't open a
/// phone-sized window — every screen's fixed-ish paddings, grids, and
/// `Positioned`/`Stack` layouts stretch across the full width, so hit
/// targets end up somewhere completely different from where a phone build
/// would put them. This clamps content to a phone-width column, centered,
/// on anything wider — the standard fix for previewing a mobile app in a
/// desktop browser. Native iOS/Android/desktop builds are unaffected (their
/// window/viewport is already phone-sized or the app is meant to fill it).
class ResponsivePhoneFrame extends StatelessWidget {
  const ResponsivePhoneFrame({super.key, required this.child});

  final Widget child;

  static const double maxContentWidth = 480;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.surfaceDim,
      child: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth < maxContentWidth
                ? constraints.maxWidth
                : maxContentWidth;
            // Re-clamp the ambient MediaQuery so descendants (SafeArea,
            // MediaQuery.sizeOf, etc.) see the actual on-screen width rather
            // than the full browser window — a raw ConstrainedBox alone only
            // clips the paint, it doesn't change what layout code measures.
            final outer = MediaQuery.of(context);
            return MediaQuery(
              data: outer.copyWith(size: Size(width, outer.size.height)),
              child: SizedBox(
                width: width,
                height: constraints.maxHeight,
                child: child,
              ),
            );
          },
        ),
      ),
    );
  }
}

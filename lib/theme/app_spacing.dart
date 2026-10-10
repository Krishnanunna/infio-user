/// Spacing & radius tokens from
/// design_reference/hyperlocal_glass_modern/DESIGN.md.
class AppSpacing {
  AppSpacing._();

  static const double unit = 4;
  static const double containerMargin = 20;
  static const double stackGapSm = 8;
  static const double stackGapMd = 16;
  static const double stackGapLg = 24;
  static const double gridGutter = 12;
}

class AppRadius {
  AppRadius._();

  static const double sm = 4; // 0.25rem
  static const double base = 8; // 0.5rem — buttons, inputs, small cards
  static const double md = 12; // 0.75rem
  static const double lg = 16; // 1rem — main containers, bottom sheets
  static const double xl = 24; // 1.5rem — featured cards
  static const double full = 9999;
}

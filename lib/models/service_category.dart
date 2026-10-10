import 'package:flutter/material.dart';

/// A top-level service category shown on Home / Categories / booking flow
/// (design_reference/user_home_integrated_quick_quote_section,
/// design_reference/user_booking_step_1_selection).
class ServiceCategory {
  const ServiceCategory({
    required this.id,
    required this.name,
    required this.icon,
    this.imageUrl,
    this.subCategories = const [],
  });

  final String id;
  final String name;
  final IconData icon;

  /// Photo from the Stitch export's category icon (design_reference/
  /// user_home_integrated_quick_quote_section); null falls back to [icon].
  final String? imageUrl;

  /// Sub-service chips shown once a category is selected in the get-a-quote flow.
  final List<String> subCategories;
}

import 'package:flutter/material.dart';

/// A service provider ("Business"/"Partner") card, as shown in Home's
/// "Near You" rail, Search Results and the Business Profile page.
class Business {
  const Business({
    required this.id,
    required this.name,
    required this.tagline,
    required this.icon,
    required this.accentColor,
    required this.rating,
    required this.reviewCount,
    required this.distanceLabel,
    this.experienceYears,
    this.startingPrice,
    this.isVerified = true,
    this.about =
        'Premium, verified local service provider. Our certified team ensures '
        'reliable, on-time service with a satisfaction guarantee.',
    this.hours = 'Mon-Sat: 9:00 AM - 8:00 PM',
    this.services = const [],
    this.photoUrl,
    this.portfolioUrls = const [],
  });

  final String id;
  final String name;
  final String tagline;
  final IconData icon;
  final Color accentColor;
  final double rating;
  final int reviewCount;
  final String distanceLabel;
  final int? experienceYears;
  final String? startingPrice;
  final bool isVerified;
  final String about;
  final String hours;
  final List<BusinessService> services;

  /// Photo from the Stitch export; null falls back to an icon placeholder.
  final String? photoUrl;

  /// "Recent Work" gallery photos (design_reference/business_profile_page).
  final List<String> portfolioUrls;

  /// Single-letter fallback used for avatar placeholders without a photo.
  String get initial => name.isNotEmpty ? name[0].toUpperCase() : '?';
}

class BusinessService {
  const BusinessService({
    required this.name,
    required this.priceLabel,
    required this.icon,
  });

  final String name;
  final String priceLabel;
  final IconData icon;
}

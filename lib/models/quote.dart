/// A single partner's quote against a [QuoteRequest]
/// (design_reference/available_quotes_refined_view,
/// design_reference/user_quote_comparison_refined).
class Quote {
  const Quote({
    required this.id,
    required this.providerName,
    required this.rating,
    required this.reviewCount,
    required this.price,
    required this.isFixedPrice,
    required this.message,
    required this.availability,
    this.highlights = const [],
    this.badge,
    this.avatarUrl,
  });

  final String id;
  final String providerName;
  final double rating;
  final int reviewCount;
  final int price;
  final bool isFixedPrice;
  final String message;
  final String availability;

  /// Photo from the Stitch export; null falls back to an initial-letter
  /// avatar — the original design itself mixes both (e.g. "FixIt Now
  /// Services" has no photo even in the source HTML).
  final String? avatarUrl;

  /// Short bullet points shown on the Available Quotes card
  /// (e.g. "Includes gas check & filter cleaning").
  final List<String> highlights;

  /// e.g. "Top Rated", "Best Value", "Most Reliable".
  final String? badge;

  String get initial =>
      providerName.isNotEmpty ? providerName[0].toUpperCase() : '?';
}

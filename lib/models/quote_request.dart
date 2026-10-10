import 'package:flutter/material.dart';

import 'quote.dart';

enum QuoteRequestStatus { active, completed, canceled }

/// A user's "get a quote" request, created via the booking flow
/// (design_reference/user_booking_step_1_selection through step_3) and
/// tracked on design_reference/user_quotes_requests_hub.
class QuoteRequest {
  QuoteRequest({
    required this.id,
    required this.title,
    required this.icon,
    required this.locationLabel,
    required this.requestedLabel,
    required this.status,
    this.quotes = const [],
    this.description,
    this.hiredProvider,
    this.outcomeLabel,
  });

  final String id;
  final String title;
  final IconData icon;
  final String locationLabel;
  final String requestedLabel;
  final QuoteRequestStatus status;
  final List<Quote> quotes;
  final String? description;

  /// Set once a quote has been accepted (past requests).
  final String? hiredProvider;

  /// e.g. "Completed Oct 15, 2023" / "Canceled Sep 02, 2023".
  final String? outcomeLabel;
}

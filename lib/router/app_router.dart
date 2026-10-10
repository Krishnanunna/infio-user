import 'package:go_router/go_router.dart';

import '../screens/auth/login_screen.dart';
import '../screens/auth/otp_screen.dart';
import '../screens/booking/booking_step1_screen.dart';
import '../screens/booking/booking_step2_screen.dart';
import '../screens/booking/booking_step3_screen.dart';
import '../screens/business/business_profile_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/home/home_shell.dart';
import '../screens/onboarding/landing_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/quotes/available_quotes_screen.dart';
import '../screens/quotes/quote_comparison_screen.dart';
import '../screens/quotes/quotes_hub_screen.dart';
import '../screens/search/search_results_screen.dart';
import '../screens/splash/splash_screen.dart';

/// App-wide navigation graph. The 4-tab bottom-nav shell (Home / Categories /
/// Orders / Profile) is a [StatefulShellRoute] so each tab keeps its own
/// scroll/nav state; every other flow (search, business profile, the
/// get-a-quote booking steps, quotes) is pushed on top of it.
final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/onboarding', builder: (context, state) => const LandingScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/otp',
      builder: (context, state) => OtpScreen(phoneNumber: state.extra as String?),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => HomeShell(shell: navigationShell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/categories',
            builder: (context, state) => const SearchResultsScreen(embedded: true),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/orders', builder: (context, state) => const QuotesHubScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()),
        ]),
      ],
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => SearchResultsScreen(
        query: state.uri.queryParameters['q'],
      ),
    ),
    GoRoute(
      path: '/business/:id',
      builder: (context, state) =>
          BusinessProfileScreen(businessId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/booking/step1',
      builder: (context, state) => const BookingStep1Screen(),
    ),
    GoRoute(
      path: '/booking/step2',
      builder: (context, state) =>
          BookingStep2Screen(selection: state.extra as BookingSelection),
    ),
    GoRoute(
      path: '/booking/step3',
      builder: (context, state) =>
          BookingStep3Screen(details: state.extra as BookingDetails),
    ),
    GoRoute(
      path: '/quotes/:requestId/available',
      builder: (context, state) =>
          AvailableQuotesScreen(requestId: state.pathParameters['requestId']!),
    ),
    GoRoute(
      path: '/quotes/:requestId/compare',
      builder: (context, state) =>
          QuoteComparisonScreen(requestId: state.pathParameters['requestId']!),
    ),
  ],
);

import 'package:go_router/go_router.dart';
import 'package:tapella/features/cllients/presentation/screens/client_profile.dart';
import 'package:tapella/features/cllients/presentation/screens/client_profile_edit.dart';
import 'package:tapella/features/cllients/presentation/screens/client_requestpage.dart';
import 'package:tapella/features/cllients/presentation/screens/client_homepage.dart';

import '../../features/screens.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/client/login',
    routes: [
      GoRoute(path: '/', redirect: (_, _) => '/client/login'),
      GoRoute(
        path: '/client/login',
        builder: (context, state) => const ClientLoginScreen(),
      ),
      GoRoute(
        path: '/client/forgot-password',
        builder: (context, state) => const PlaceHolderScreen(),
      ),
      GoRoute(
        path: '/client/signup',
        builder: (context, state) => const ClientSignupScreen(),
      ),
      GoRoute(
        path: '/client/home',
        builder: (context, state) => const ClientHomePage(),
      ),
      GoRoute(
        path: '/client/requests',
        builder: (context, state) => const ClientRequestpage(),
      ),
      GoRoute(
        path: '/client/requests/service',
        builder: (context, state) => const PlaceHolderScreen(),
      ),
      GoRoute(
        path: '/client/profile',
        builder: (context, state) => const ClientProfile(),
      ),
      GoRoute(
        path: '/client/profile/edit',
        builder: (context, state) => const ClientProfileEdit(),
      ),
      GoRoute(
        path: '/business/login',
        builder: (context, state) => const BusinessLoginScreen(),
      ),
      GoRoute(
        path: '/business/signup',
        builder: (context, state) => const BusinessSignupScreen(),
      ),
      GoRoute(
        path: '/business/forgot-password',
        builder: (context, state) => const PlaceHolderScreen(),
      ),
      GoRoute(
        path: '/business/home',
        builder: (context, state) => const PlaceHolderScreen(),
      ),
      GoRoute(
        path: '/business/requests',
        builder: (context, state) => const PlaceHolderScreen(),
      ),
      GoRoute(
        path: '/business/new-listing',
        builder: (context, state) => const PlaceHolderScreen(),
      ),
      GoRoute(
        path: '/service/detail',
        builder: (context, state) => const PlaceHolderScreen(),
      ),
      GoRoute(
        path: '/service/detail/alt-1',
        builder: (context, state) => const ServiceDetail(),
      ),
      GoRoute(
        path: '/service/detail/alt-2',
        builder: (context, state) => const PlaceHolderScreen(),
      ),
      GoRoute(
        path: '/business/profile-edit',
        builder: (context, state) => const ProviderEditScreen(),
      ),
    ],
  );
}

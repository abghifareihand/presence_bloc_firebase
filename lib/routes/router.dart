import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:presence_bloc_firebase/presentation/pages/all_presence_page.dart';
import 'package:presence_bloc_firebase/presentation/pages/bottomnav_page.dart';
import 'package:presence_bloc_firebase/presentation/pages/detail_presence_page.dart';
import 'package:presence_bloc_firebase/presentation/pages/edit_profile_page.dart';
import 'package:presence_bloc_firebase/presentation/pages/home_page.dart';
import 'package:presence_bloc_firebase/presentation/pages/login_page.dart';
import 'package:presence_bloc_firebase/presentation/pages/profile_page.dart';
import 'package:presence_bloc_firebase/presentation/pages/register_page.dart';
import 'package:presence_bloc_firebase/presentation/pages/splash_page.dart';
part 'route_name.dart';

final router = GoRouter(
  initialLocation: '/splash',
  //debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/splash',
      name: Routes.splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/navbar',
      name: Routes.navbar,
      builder: (context, state) => const BottomnavPage(),
    ),
    GoRoute(
      path: '/home',
      name: Routes.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/login',
      name: Routes.login,
      //builder: (context, state) => const LoginPage(),
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/register',
      name: Routes.register,
      //builder: (context, state) => const RegisterPage(),
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const RegisterPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/profile',
      name: Routes.profile,
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: '/editProfile',
      name: Routes.editProfile,
      builder: (context, state) => const EditProfilePage(),
    ),
    // GoRoute(
    //   path: '/detailPresence',
    //   name: Routes.detailPresence,
    //   builder: (context, state) {
    //     final Map<String, dynamic> presenceData =
    //         state.pathParameters['presenceData'] as Map<String, dynamic>;
    //     return DetailPresencePage(presenceData: presenceData);
    //   },
    // ),
    GoRoute(
      path: '/allPresence',
      name: Routes.allPresence,
      builder: (context, state) => const AllPresencePage(),
    ),
  ],
);

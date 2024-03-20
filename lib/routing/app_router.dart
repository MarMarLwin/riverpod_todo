import 'dart:js';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_todo/common_widgets/not_found_page.dart';
import 'package:riverpod_todo/features/auth/presentation/account/account_screen.dart';
import 'package:riverpod_todo/features/auth/presentation/sigin/email_password_formtype.dart';
import 'package:riverpod_todo/features/auth/presentation/sigin/signin_screen.dart';
import 'package:riverpod_todo/features/products/presentation/product_screen/product_screen.dart';
import 'package:riverpod_todo/features/products/presentation/products_list/product_list_screen.dart';
import 'package:riverpod_todo/shell_route/shell_route_navigation.dart';

enum AppRoute {
  home,
  product,
  leaveReview,
  cart,
  checkout,
  orders,
  account,
  signIn,
  //shell router
  shellRouteNavigation,
  sectionA,
  sectionADetail,
  sectionB,
  sectionBDetail
}

final goRouter = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
          path: '/',
          name: AppRoute.home.name,
          builder: (context, state) => const ProductListScreen(),
          routes: [
            GoRoute(
                path: 'product/:id',
                name: AppRoute.product.name,
                builder: (context, state) {
                  final productId = state.pathParameters['id']!;
                  return ProductScreen(productId: productId);
                })
          ]),
      GoRoute(
          path: '/signin',
          name: AppRoute.signIn.name,
          pageBuilder: (context, state) => MaterialPage(
              fullscreenDialog: true,
              child: SignInScreen(
                  formType: EmailPasswordSignInFormType.signIn,
                  onSignedIn: () => GoRouter.of(context).go('/')))),
      GoRoute(
          path: '/register',
          name: 'register',
          builder: (context, state) => const AccountScreen())
    ],
    errorBuilder: (context, state) => const NotFoundPage());

//shell router navigation
// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');

final shellRoute = GoRouter(
  initialLocation: '/a',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNestedNavigation(
            navigationShell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(navigatorKey: _shellNavigatorAKey, routes: [
            GoRoute(
                path: '/a',
                name: AppRoute.sectionA.name,
                pageBuilder: (context, state) => NoTransitionPage(
                        child: RootScreen(
                      label: 'Screen A',
                      detailsPath: AppRoute.sectionADetail.name,
                    ))),
            GoRoute(
                path: '/details',
                name: AppRoute.sectionADetail.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                    child: DetailScreen(label: 'Detail A')))
          ]),
          StatefulShellBranch(navigatorKey: _shellNavigatorBKey, routes: [
            GoRoute(
                path: '/b',
                name: AppRoute.sectionB.name,
                pageBuilder: (context, state) => NoTransitionPage(
                        child: RootScreen(
                      label: 'Section B',
                      detailsPath: AppRoute.sectionBDetail.name,
                    ))),
            GoRoute(
                path: '/details',
                name: AppRoute.sectionBDetail.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                        child: DetailScreen(
                      label: 'Detail B',
                    )))
          ])
        ])
  ],
);

import 'package:go_router/go_router.dart';
import 'package:riverpod_todo/features/auth/presentation/account/account_screen.dart';
import 'package:riverpod_todo/features/auth/presentation/sigin/email_password_formtype.dart';
import 'package:riverpod_todo/features/auth/presentation/sigin/signin_screen.dart';
import 'package:riverpod_todo/features/products/presentation/product_screen/product_screen.dart';
import 'package:riverpod_todo/features/products/presentation/products_list/product_list_screen.dart';

enum AppRoute {
  home,
  product,
  leaveReview,
  cart,
  checkout,
  orders,
  account,
  signIn,
}

final goRouter =
    GoRouter(initialLocation: '/', debugLogDiagnostics: true, routes: [
  GoRoute(
      path: '/',
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
      builder: (context, state) => SignInScreen(
          formType: EmailPasswordSignInFormType.signIn,
          onSignedIn: () => GoRouter.of(context).pushNamed('register'))),
  GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const AccountScreen())
]);

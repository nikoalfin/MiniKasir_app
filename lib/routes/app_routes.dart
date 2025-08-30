import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:mini_kasir/mini_kasir/akun_setting/view/setting.dart';
import 'package:mini_kasir/mini_kasir/home/view/home_page.dart';
import 'package:mini_kasir/mini_kasir/product/view/product.dart';
import 'package:mini_kasir/mini_kasir/product/view/product_add.dart';
import 'package:mini_kasir/mini_kasir/transaksi/view/transaksi.dart';
import 'package:mini_kasir/utils/splash.dart';

class myRoute{
   get router => GoRouter(initialLocation: '/splash', 
   routes: [
    GoRoute(
        path: '/splash',
        name: 'Splash',
        pageBuilder: (context, state) =>
            // NoTransitionPage(child: HomePage()),
            NoTransitionPage(child: SplashScreen()),  // Buat SplashScreen
      ),
    GoRoute(
            path: '/',
            name: 'home',
            pageBuilder: (context, state) =>
                NoTransitionPage(child: HomePage()),
            // NoTransitionPage(child: Product()),
                // NoTransitionPage(child: ProductAdd()),
            // NoTransitionPage(child: Transaksi()),
            // NoTransitionPage(child: Setting()),
            // sub routes
            routes: <RouteBase>[
              GoRoute(
                path: 'product-pages',
                name: 'ProductPages',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: Product()),
              ),
              GoRoute(
                path: 'setting-pages',
                name: 'SettingPages',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: Setting()),
              )
              ])
   ]);
}

// // Definisi GoRouter
// final GoRouter router = GoRouter(
//   routes: <RouteBase>[
//     GoRoute(
//       path: '/',
//       builder: (BuildContext context, GoRouterState state) {
//         return const HomePage();
//       },
//     ),
//   ],
// );

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_todo/common_widgets/async_value_widget.dart';
import 'package:riverpod_todo/constants/app_sizes.dart';
import 'package:riverpod_todo/features/products/data/fake_product_repository.dart';
import 'package:riverpod_todo/features/products/domain/product.dart';
import 'package:riverpod_todo/features/products/presentation/products_list/product_card.dart';
import 'package:riverpod_todo/localization/string_hardcoded.dart';
import 'package:riverpod_todo/routing/app_router.dart';

class ProductGrid extends ConsumerWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productList = ref.watch(productsListFutureProvider);
    return AsyncValueWidget<List<Product>>(
        value: productList,
        data: (products) => products.isEmpty
            ? Center(
                child: Text(
                  'No products found'.hardcoded,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              )
            : ProductLayoutGrid(
                itemCount: products.length,
                itemBuilder: (_, index) {
                  final product = products[index];
                  return ProductCard(
                    product: product,
                    onPressed: () => context.goNamed(
                      AppRoute.product.name,
                      pathParameters: {'id': product.id},
                    ),
                  );
                }));
  }
}

class ProductLayoutGrid extends StatelessWidget {
  const ProductLayoutGrid(
      {super.key, required this.itemCount, required this.itemBuilder});
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      // 1 column for width < 500px
      // then add one more column for each 250px
      final crossAxisCount = max(1, width ~/ 250);
      // once the crossAxisCount is known, calculate the column and row sizes
      // set some flexible track sizes based on the crossAxisCount with 1.fr
      final columnSizes = List.generate(crossAxisCount, (_) => 1.fr);
      final numRows = (itemCount / crossAxisCount).ceil();
      // set all the row sizes to auto (self-sizing height)
      final rowSizes = List.generate(numRows, (_) => auto);
      // Custom layout grid. See: https://pub.dev/packages/flutter_layout_grid
      return LayoutGrid(
        columnSizes: columnSizes,
        rowSizes: rowSizes,
        rowGap: Sizes.p24, // equivalent to mainAxisSpacing
        columnGap: Sizes.p24, // equivalent to crossAxisSpacing
        children: [
          // render all the items with automatic child placement
          for (var i = 0; i < itemCount; i++) itemBuilder(context, i),
        ],
      );
    });
  }
}

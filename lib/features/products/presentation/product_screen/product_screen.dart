import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo/common_widgets/async_value_widget.dart';
import 'package:riverpod_todo/common_widgets/custom_image.dart';
import 'package:riverpod_todo/common_widgets/empty_placeholder_widget.dart';
import 'package:riverpod_todo/common_widgets/responsive_center.dart';
import 'package:riverpod_todo/common_widgets/responsive_two_column_layout.dart';
import 'package:riverpod_todo/constants/app_sizes.dart';
import 'package:riverpod_todo/features/products/data/fake_product_repository.dart';
import 'package:riverpod_todo/features/products/domain/product.dart';
import 'package:riverpod_todo/features/products/presentation/home_app_bar/home_app_bar.dart';
import 'package:riverpod_todo/features/products/presentation/product_screen/product_average_rating.dart';
import 'package:riverpod_todo/localization/string_hardcoded.dart';
import 'package:riverpod_todo/utils/currency_formatter.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.productId});
  final ProductID productId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: Consumer(builder: (context, ref, _) {
        final productValue = ref.watch(productProvider(productId));
        return AsyncValueWidget(
            value: productValue,
            data: (product) => product == null
                ? EmptyPlaceholderWidget(message: 'No Product'.hardcoded)
                : CustomScrollView(
                    slivers: [
                      ResponsiveSliverCenter(
                          child: ProductDetails(
                        product: product,
                      ))
                    ],
                  ));
      }),
    );
  }
}

class ProductDetails extends ConsumerWidget {
  const ProductDetails({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final priceFormatted =
        ref.watch(currencyFormatterProvider).format(product.price);
    return ResponsiveTwoColumnLayout(
        startContent: Card(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.p16),
            child: CustomImage(imageUrl: product.imageUrl),
          ),
        ),
        endContent: Card(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.p16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                gapH8,
                Text(
                  product.description,
                ),
                if (product.numRatings >= 1) ...[
                  gapH48,
                  ProductAverageRating(product: product)
                ],
                gapH8,
                const Divider(),
                gapH8,
                Text(
                  priceFormatted,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                gapH8,
                const Divider(),
                gapH8,
                Row(
                  children: [
                    const Text('Quantity'),
                    const Spacer(),
                    Text(
                      product.availableQuantity.toString(),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        spacing: Sizes.p16);
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_todo/common_widgets/custom_image.dart';
import 'package:riverpod_todo/constants/app_sizes.dart';
import 'package:riverpod_todo/features/products/domain/product.dart';
import 'package:riverpod_todo/features/products/presentation/product_screen/product_average_rating.dart';
import 'package:riverpod_todo/localization/string_hardcoded.dart';
import 'package:riverpod_todo/utils/currency_formatter.dart';

class ProductCard extends ConsumerWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.onPressed,
  });

  final Product product;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final priceFormatted =
        ref.watch(currencyFormatterProvider).format(product.price);
    return Card(
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Column(
            children: [
              CustomImage(imageUrl: product.imageUrl),
              gapH8,
              const Divider(),
              Text(
                product.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              if (product.numRatings >= 1) ...[
                gapH8,
                ProductAverageRating(product: product),
              ],
              gapH24,
              Text(priceFormatted,
                  style: Theme.of(context).textTheme.headlineSmall),
              gapH4,
              Text(
                product.availableQuantity <= 0
                    ? 'Out of Stock'.hardcoded
                    : 'Quantity: ${product.availableQuantity}'.hardcoded,
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
        ),
      ),
    );
  }
}

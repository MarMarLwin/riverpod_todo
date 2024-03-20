import 'package:flutter/material.dart';
import 'package:riverpod_todo/constants/app_sizes.dart';

class ShoppingCartIcon extends StatelessWidget {
  const ShoppingCartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    const cartItemCount = 3;
    return Stack(
      children: [
        Center(
          child: IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ),
        if (cartItemCount > 0)
          const Positioned(
              top: Sizes.p4,
              right: 0,
              child: ShoppingCartIconBadge(itemCount: cartItemCount))
      ],
    );
  }
}

class ShoppingCartIconBadge extends StatelessWidget {
  const ShoppingCartIconBadge({super.key, required this.itemCount});
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.p16,
      height: Sizes.p16,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
      child: Text(
        itemCount.toString(),
        // * Force text scale factor to 1.0 irrespective of the device's
        // * textScaleFactor. This is to prevent the text from growing bigger
        // * than the available space.
        textScaler: const TextScaler.linear(1.0),
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .labelSmall!
            .copyWith(color: Colors.white),
      ),
    );
  }
}

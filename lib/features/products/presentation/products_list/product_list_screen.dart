import 'package:flutter/material.dart';
import 'package:riverpod_todo/common_widgets/responsive_center.dart';
import 'package:riverpod_todo/features/products/presentation/home_app_bar/home_app_bar.dart';
import 'package:riverpod_todo/features/products/presentation/products_list/product_grid.dart';
import 'package:riverpod_todo/localization/string_hardcoded.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() => _dismissOnScreenKeyboard());
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // When the search text field gets the focus, the keyboard appears on mobile.
  // This method is used to dismiss the keyboard when the user scrolls.
  void _dismissOnScreenKeyboard() {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     title: Text(
      //   'Product List'.hardcoded,
      // )),
      appBar: const HomeAppBar(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: const [ResponsiveSliverCenter(child: ProductGrid())],
      ),
    );
  }
}

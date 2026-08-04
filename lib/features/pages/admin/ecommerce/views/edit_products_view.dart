import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/widgets/product_card.dart';
import 'package:flutter_course/features/pages/admin/ecommerce/providers/ecommerce_providers.dart';
import 'package:flutter_course/features/pages/admin/ecommerce/services/product_firestore_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Pantalla para editar productos (solo admin).
/// Muestra todos los productos con opción de editar nombre, precio e imagen.
class EditProductsView extends ConsumerWidget {
  const EditProductsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final perfectForYouAsync = ref.watch(perfectForYouProductsProvider);
    final forThisSummerAsync = ref.watch(forThisSummerProductsProvider);

    return Scaffold(
      backgroundColor: ArgonColors.bgColorScreen,
      appBar: AppBar(
        backgroundColor: ArgonColors.white,
        elevation: 0,
        title: const Text(
          'Edit Products',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: ArgonColors.text,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Perfect for you',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: ArgonColors.text,
              ),
            ),
            const SizedBox(height: 12),
            perfectForYouAsync.when(
              loading: () => const Center(
                child: CircularProgressIndicator(color: ArgonColors.primary),
              ),
              error: (e, _) => Text('Error: $e'),
              data: (products) => _ProductList(
                products: products,
                onRefresh: () {
                  ref.invalidate(perfectForYouProductsProvider);
                  ref.invalidate(forThisSummerProductsProvider);
                },
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'For this summer',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: ArgonColors.text,
              ),
            ),
            const SizedBox(height: 12),
            forThisSummerAsync.when(
              loading: () => const Center(
                child: CircularProgressIndicator(color: ArgonColors.primary),
              ),
              error: (e, _) => Text('Error: $e'),
              data: (products) => _ProductList(
                products: products,
                onRefresh: () {
                  ref.invalidate(perfectForYouProductsProvider);
                  ref.invalidate(forThisSummerProductsProvider);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Lista de productos editables.
class _ProductList extends StatelessWidget {
  final List<Product> products;
  final VoidCallback onRefresh;

  const _ProductList({
    required this.products,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Text(
        'No products found',
        style: TextStyle(color: ArgonColors.muted),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final product = products[index];
        return _EditableProductCard(
          product: product,
          onSaved: onRefresh,
        );
      },
    );
  }
}

/// Tarjeta de producto con botón de editar.
class _EditableProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onSaved;

  const _EditableProductCard({
    required this.product,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ArgonColors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Imagen
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: ArgonColors.secondary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: product.imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      product.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, e, s) =>
                          const Icon(Icons.image, color: ArgonColors.muted),
                    ),
                  )
                : const Icon(Icons.image, color: ArgonColors.muted),
          ),
          const SizedBox(width: 14),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: ArgonColors.text,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.price,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: ArgonColors.primary,
                  ),
                ),
              ],
            ),
          ),
          // Botón editar
          IconButton(
            onPressed: () => _showEditDialog(context),
            icon: const Icon(
              Icons.edit_rounded,
              color: ArgonColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  /// Muestra el diálogo de edición del producto.
  void _showEditDialog(BuildContext context) {
    final nameController = TextEditingController(text: product.name);
    final priceController = TextEditingController(text: product.price);
    final imageController = TextEditingController(text: product.imageUrl ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: ArgonColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Edit Product',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: ArgonColors.text,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: imageController,
                decoration: const InputDecoration(
                  labelText: 'Image URL',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final service = ProductFirestoreService();
                await service.updateProduct(
                  productId: product.id,
                  name: nameController.text.trim(),
                  price: priceController.text.trim(),
                  imageUrl: imageController.text.trim().isNotEmpty
                      ? imageController.text.trim()
                      : null,
                );

                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Product updated!'),
                      backgroundColor: ArgonColors.success,
                    ),
                  );
                }
                onSaved();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ArgonColors.primary,
                foregroundColor: ArgonColors.white,
              ),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

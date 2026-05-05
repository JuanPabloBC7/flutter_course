import 'package:flutter/material.dart';

/// Maps transaction category strings to their corresponding Material icons.
///
/// Used in Dashboard and History views to display category-specific icons.
class CategoryIcon {
  CategoryIcon._();

  static IconData fromCategory(String category) {
    switch (category) {
      case 'salary':
        return Icons.account_balance;
      case 'shopping':
        return Icons.shopping_cart;
      case 'freelance':
        return Icons.work_outline;
      case 'entertainment':
        return Icons.movie_outlined;
      case 'transfer':
        return Icons.person_outline;
      case 'utilities':
        return Icons.bolt;
      case 'food':
        return Icons.restaurant;
      case 'refund':
        return Icons.replay;
      case 'transport':
        return Icons.local_gas_station;
      case 'health':
        return Icons.fitness_center;
      default:
        return Icons.attach_money;
    }
  }
}

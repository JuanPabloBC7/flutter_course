import 'package:flutter_course/core/network/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Providers for service layer instances.
/// These are the entry points for data access across the app.

final userServiceProvider = Provider<UserService>((ref) => UserService());

final accountServiceProvider = Provider<AccountService>((ref) => AccountService());

final transactionServiceProvider = Provider<TransactionService>((ref) => TransactionService());

final transferServiceProvider = Provider<TransferService>((ref) => TransferService());

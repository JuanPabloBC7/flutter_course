import 'dart:async';
import 'package:flutter_course/core/network/api_client.dart';
import 'package:flutter_course/core/network/app_exceptions.dart';

// ignore_for_file: unused_field
// The _client fields are declared but use mock data for now.
// Remove this ignore when connecting to real API endpoints.

/// Service for user-related API calls.
class UserService {
  final ApiClient _client = ApiClient();

  /// Fetches the current user profile.
  /// Uses mock data for now — replace with real endpoint later.
  Future<Map<String, dynamic>> fetchUser() async {
    // TODO: Replace with real API call:
    // final response = await _client.get('/users/me');
    // return response.data;

    await Future.delayed(const Duration(milliseconds: 500));
    return {
      'id': 1,
      'username': 'jpbalan',
      'email': 'jpbalan@example.com',
      'fullName': 'Juan P. Balan',
      'avatar': null,
    };
  }
}

/// Service for account and balance-related API calls.
class AccountService {
  final ApiClient _client = ApiClient();

  /// Fetches the user's accounts and balances.
  Future<Map<String, dynamic>> fetchAccountSummary() async {
    // TODO: Replace with real API call:
    // final response = await _client.get('/accounts/summary');
    // return response.data;

    await Future.delayed(const Duration(milliseconds: 600));
    return {
      'totalBalance': 12458.75,
      'percentChange': 8.3,
      'accounts': [
        {
          'id': 'acc-001',
          'name': 'Main Account',
          'type': 'checking',
          'balance': 8234.50,
          'currency': 'USD',
        },
        {
          'id': 'acc-002',
          'name': 'Savings',
          'type': 'savings',
          'balance': 4224.25,
          'currency': 'USD',
        },
      ],
      'stats': {
        'income': 4150.00,
        'expenses': 1842.00,
        'savings': 2308.00,
        'transactionCount': 48,
      },
    };
  }
}

/// Service for transaction history API calls.
class TransactionService {
  final ApiClient _client = ApiClient();

  /// Fetches the transaction history with optional filters.
  Future<List<Map<String, dynamic>>> fetchTransactions({
    String? filter,
    int page = 1,
    int limit = 20,
  }) async {
    // TODO: Replace with real API call:
    // final response = await _client.get('/transactions', queryParameters: {
    //   'filter': filter,
    //   'page': page,
    //   'limit': limit,
    // });
    // return List<Map<String, dynamic>>.from(response.data['items']);

    await Future.delayed(const Duration(milliseconds: 700));

    final allTransactions = [
      {'id': 'tx-001', 'title': 'Salary Deposit', 'date': '2025-05-04T09:41:00', 'amount': 3500.00, 'type': 'income', 'category': 'salary', 'section': 'Today'},
      {'id': 'tx-002', 'title': 'Grocery Store', 'date': '2025-05-04T14:15:00', 'amount': 85.45, 'type': 'expense', 'category': 'shopping', 'section': 'Today'},
      {'id': 'tx-003', 'title': 'Freelance Payment', 'date': '2025-05-04T17:30:00', 'amount': 450.00, 'type': 'income', 'category': 'freelance', 'section': 'Today'},
      {'id': 'tx-004', 'title': 'Netflix Subscription', 'date': '2025-05-03T08:00:00', 'amount': 15.99, 'type': 'expense', 'category': 'entertainment', 'section': 'Yesterday'},
      {'id': 'tx-005', 'title': 'Transfer from Juan', 'date': '2025-05-03T11:20:00', 'amount': 200.00, 'type': 'income', 'category': 'transfer', 'section': 'Yesterday'},
      {'id': 'tx-006', 'title': 'Electric Bill', 'date': '2025-05-03T15:45:00', 'amount': 120.50, 'type': 'expense', 'category': 'utilities', 'section': 'Yesterday'},
      {'id': 'tx-007', 'title': 'Restaurant', 'date': '2025-05-01T19:30:00', 'amount': 62.00, 'type': 'expense', 'category': 'food', 'section': 'This Week'},
      {'id': 'tx-008', 'title': 'Refund - Amazon', 'date': '2025-05-01T10:00:00', 'amount': 34.99, 'type': 'income', 'category': 'refund', 'section': 'This Week'},
      {'id': 'tx-009', 'title': 'Gas Station', 'date': '2025-04-30T18:15:00', 'amount': 55.00, 'type': 'expense', 'category': 'transport', 'section': 'This Week'},
      {'id': 'tx-010', 'title': 'Gym Membership', 'date': '2025-04-29T09:00:00', 'amount': 40.00, 'type': 'expense', 'category': 'health', 'section': 'This Week'},
    ];

    if (filter == 'income') {
      return allTransactions.where((tx) => tx['type'] == 'income').toList();
    } else if (filter == 'expense') {
      return allTransactions.where((tx) => tx['type'] == 'expense').toList();
    }

    return allTransactions;
  }
}

/// Service for transfer-related API calls.
class TransferService {
  final ApiClient _client = ApiClient();

  /// Fetches the list of frequent contacts for transfers.
  Future<List<Map<String, dynamic>>> fetchFrequentContacts() async {
    // TODO: Replace with real API call:
    // final response = await _client.get('/transfers/contacts');
    // return List<Map<String, dynamic>>.from(response.data);

    await Future.delayed(const Duration(milliseconds: 400));
    return [
      {'id': 'c-001', 'name': 'Ana García', 'account': '****1234'},
      {'id': 'c-002', 'name': 'Carlos López', 'account': '****5678'},
      {'id': 'c-003', 'name': 'María Torres', 'account': '****9012'},
      {'id': 'c-004', 'name': 'Juan Pérez', 'account': '****3456'},
      {'id': 'c-005', 'name': 'Laura Díaz', 'account': '****7890'},
      {'id': 'c-006', 'name': 'Pedro Ruiz', 'account': '****2345'},
    ];
  }

  /// Fetches recent transfers.
  Future<List<Map<String, dynamic>>> fetchRecentTransfers() async {
    // TODO: Replace with real API call:
    // final response = await _client.get('/transfers/recent');
    // return List<Map<String, dynamic>>.from(response.data);

    await Future.delayed(const Duration(milliseconds: 500));
    return [
      {'id': 't-001', 'name': 'Ana García', 'date': '2025-05-04T10:30:00', 'amount': 250.00, 'status': 'completed'},
      {'id': 't-002', 'name': 'Carlos López', 'date': '2025-05-04T08:15:00', 'amount': 1200.00, 'status': 'pending'},
      {'id': 't-003', 'name': 'María Torres', 'date': '2025-05-03T16:45:00', 'amount': 85.50, 'status': 'completed'},
      {'id': 't-004', 'name': 'Juan Pérez', 'date': '2025-05-03T13:20:00', 'amount': 500.00, 'status': 'failed'},
      {'id': 't-005', 'name': 'Laura Díaz', 'date': '2025-05-01T09:00:00', 'amount': 320.00, 'status': 'completed'},
    ];
  }

  /// Executes a new transfer.
  Future<Map<String, dynamic>> executeTransfer({
    required String toAccountId,
    required double amount,
    String? description,
  }) async {
    // TODO: Replace with real API call:
    // final response = await _client.post('/transfers', data: {
    //   'toAccountId': toAccountId,
    //   'amount': amount,
    //   'description': description,
    // });
    // return response.data;

    await Future.delayed(const Duration(milliseconds: 800));

    // Simulate validation error for amounts over 10,000
    if (amount > 10000) {
      throw const BadRequestException(
        message: 'Transfer amount exceeds the daily limit of \$10,000.',
      );
    }

    return {
      'id': 't-new-001',
      'status': 'completed',
      'amount': amount,
      'toAccountId': toAccountId,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
}

/// Service for authentication API calls.
class AuthService {
  final ApiClient _client = ApiClient();

  /// Authenticates the user with username and password.
  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    // TODO: Replace with real API call:
    // final response = await _client.post('/auth/login', data: {
    //   'username': username,
    //   'password': password,
    // });
    // return response.data;

    await Future.delayed(const Duration(milliseconds: 800));

    // Simulate invalid credentials
    if (username != 'jpbalan' || password != '123456') {
      throw const UnauthorizedException(
        message: 'Invalid username or password.',
      );
    }

    return {
      'token': 'mock-jwt-token-abc123',
      'refreshToken': 'mock-refresh-token-xyz789',
      'user': {
        'id': 1,
        'username': 'jpbalan',
        'email': 'jpbalan@example.com',
        'fullName': 'Juan P. Balan',
      },
    };
  }

  /// Requests a password reset email.
  Future<Map<String, dynamic>> requestPasswordReset({
    required String username,
    required String email,
  }) async {
    // TODO: Replace with real API call:
    // final response = await _client.post('/auth/reset-password', data: {
    //   'username': username,
    //   'email': email,
    // });
    // return response.data;

    await Future.delayed(const Duration(milliseconds: 600));

    // Simulate user not found
    if (username.isEmpty || email.isEmpty) {
      throw const BadRequestException(
        message: 'Username and email are required.',
      );
    }

    return {
      'success': true,
      'message': 'Password reset link sent to $email.',
    };
  }

  /// Logs out the current user.
  Future<void> logout() async {
    // TODO: Replace with real API call:
    // await _client.post('/auth/logout');

    await Future.delayed(const Duration(milliseconds: 300));
    // Clear token from secure storage here
  }
}

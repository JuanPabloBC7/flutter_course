import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/widgets/top_notification.dart';
import 'package:flutter_course/features/pages/admin/trasnfers/providers/transfer_form_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Formulario para realizar una nueva transferencia.
/// Guarda la transacción en Firestore con la fecha automática.
class TransferForm extends ConsumerStatefulWidget {
  const TransferForm({super.key});

  @override
  ConsumerState<TransferForm> createState() => _TransferFormState();
}

class _TransferFormState extends ConsumerState<TransferForm> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _titleController = TextEditingController();

  String? _selectedAccountId;
  String? _selectedCategory;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  /// Envía la transferencia a Firestore.
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedAccountId == null || _selectedCategory == null) {
      TopNotification.show(
        context,
        message: 'Please select an account and category',
        type: NotificationType.error,
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      await FirebaseFirestore.instance.collection('transactions').add({
        'accountId': _selectedAccountId,
        'amount': double.parse(_amountController.text.trim()).toStringAsFixed(2),
        'category': _selectedCategory,
        'title': _titleController.text.trim(),
        'type': 'expense',
        'date': Timestamp.now(),
      });

      if (mounted) {
        _amountController.clear();
        _titleController.clear();
        setState(() {
          _selectedAccountId = null;
          _selectedCategory = null;
        });

        TopNotification.show(
          context,
          message: 'Transfer completed!',
          type: NotificationType.success,
        );
      }
    } catch (e) {
      if (mounted) {
        TopNotification.show(
          context,
          message: 'Error: $e',
          type: NotificationType.error,
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final accountsAsync = ref.watch(accountsProvider);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ArgonColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título de la sección
            const Text(
              'New Transfer',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: ArgonColors.text,
              ),
            ),
            const SizedBox(height: 16),

            // Dropdown de cuenta
            const Text(
              'Account',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: ArgonColors.muted,
              ),
            ),
            const SizedBox(height: 6),
            accountsAsync.when(
              loading: () => const LinearProgressIndicator(
                color: ArgonColors.primary,
              ),
              error: (e, _) => Text(
                'Error loading accounts',
                style: TextStyle(color: ArgonColors.error),
              ),
              data: (accounts) => DropdownButtonFormField<String>(
                initialValue: _selectedAccountId,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: ArgonColors.bgColorScreen,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: ArgonColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: ArgonColors.border),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                ),
                hint: const Text('Select account'),
                items: accounts.map((account) {
                  return DropdownMenuItem<String>(
                    value: account['id'] as String,
                    child: Text(
                      '${account['name']} (${account['currency']})',
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedAccountId = value),
                validator: (value) =>
                    value == null ? 'Select an account' : null,
              ),
            ),
            const SizedBox(height: 14),

            // Input de monto
            const Text(
              'Amount',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: ArgonColors.muted,
              ),
            ),
            const SizedBox(height: 6),
            TextFormField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              decoration: InputDecoration(
                filled: true,
                fillColor: ArgonColors.bgColorScreen,
                hintText: '0.00',
                prefixText: '\$ ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: ArgonColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: ArgonColors.border),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Enter an amount';
                }
                final amount = double.tryParse(value.trim());
                if (amount == null || amount <= 0) {
                  return 'Enter a valid amount';
                }
                return null;
              },
            ),
            const SizedBox(height: 14),

            // Dropdown de categoría
            const Text(
              'Category',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: ArgonColors.muted,
              ),
            ),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              initialValue: _selectedCategory,
              decoration: InputDecoration(
                filled: true,
                fillColor: ArgonColors.bgColorScreen,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: ArgonColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: ArgonColors.border),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
              ),
              hint: const Text('Select category'),
              items: transferCategories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(
                    category[0].toUpperCase() + category.substring(1),
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedCategory = value),
              validator: (value) =>
                  value == null ? 'Select a category' : null,
            ),
            const SizedBox(height: 14),

            // Input de título/descripción
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: ArgonColors.muted,
              ),
            ),
            const SizedBox(height: 6),
            TextFormField(
              controller: _titleController,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                filled: true,
                fillColor: ArgonColors.bgColorScreen,
                hintText: 'e.g. Rent payment',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: ArgonColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: ArgonColors.border),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Enter a description';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // Botón de enviar
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ArgonColors.primary,
                  foregroundColor: ArgonColors.white,
                  disabledBackgroundColor:
                      ArgonColors.primary.withValues(alpha: 0.6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          color: ArgonColors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Send Transfer',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

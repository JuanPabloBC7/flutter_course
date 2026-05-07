import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/network/services.dart';
import 'package:flutter_course/core/widgets/animated_list_item.dart';
import 'package:flutter_course/core/widgets/app_toast.dart';
import 'package:flutter_course/core/widgets/error_state.dart';
import 'package:flutter_course/core/widgets/frequent_contacts.dart';
import 'package:flutter_course/core/widgets/gradient_action_card.dart';
import 'package:flutter_course/core/widgets/options_grid.dart';
import 'package:flutter_course/core/widgets/section_header.dart';
import 'package:flutter_course/core/widgets/transfer_card.dart';

// ── Color palette for contact avatars ────────────────────────────────────────

const List<Color> _avatarColors = [
  ArgonColors.primary,
  ArgonColors.success,
  ArgonColors.info,
  ArgonColors.warning,
  ArgonColors.label,
  ArgonColors.error,
];

class TransfersView extends StatefulWidget {
  const TransfersView({super.key});

  @override
  State<TransfersView> createState() => _TransfersViewState();
}

class _TransfersViewState extends State<TransfersView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  final TransferService _transferService = TransferService();

  List<Map<String, dynamic>> _contacts = [];
  List<Map<String, dynamic>> _recentTransfers = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final results = await Future.wait([
        _transferService.fetchFrequentContacts(),
        _transferService.fetchRecentTransfers(),
      ]);

      if (!mounted) return;

      setState(() {
        _contacts = results[0];
        _recentTransfers = results[1];
        _isLoading = false;
      });
      _animController.forward(from: 0);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  TransferStatus _parseStatus(String? status) {
    switch (status) {
      case 'completed':
        return TransferStatus.completed;
      case 'pending':
        return TransferStatus.pending;
      case 'failed':
        return TransferStatus.failed;
      default:
        return TransferStatus.pending;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ArgonColors.bgColorScreen,
      appBar: AppBar(
        backgroundColor: ArgonColors.white,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: const Text(
          'Transfers',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: ArgonColors.text),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded, color: ArgonColors.text, size: 24),
            onPressed: () {},
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: ArgonColors.primary))
          : _errorMessage != null
              ? ErrorState(message: _errorMessage!, onRetry: _loadData)
              : RefreshIndicator(
                  color: ArgonColors.primary,
                  onRefresh: _loadData,
                  child: _buildContent(),
                ),
    );
  }

  Widget _buildContent() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        // ── Hero card ──
        AnimatedListItem(
          index: 0,
          controller: _animController,
          child: GradientActionCard(
            title: 'Send Money',
            subtitle: 'Transfer to anyone, anywhere',
            icon: Icons.send_rounded,
            onTap: () {},
          ),
        ),

        // ── Frequent contacts ──
        AnimatedListItem(
          index: 1,
          controller: _animController,
          child: const SectionHeader(title: 'FREQUENT CONTACTS'),
        ),
        AnimatedListItem(
          index: 2,
          controller: _animController,
          child: FrequentContacts(
            contacts: _contacts.asMap().entries.map((entry) {
              return ContactItem(
                name: entry.value['name'] as String,
                color: _avatarColors[entry.key % _avatarColors.length],
                id: entry.value['id'] as String?,
              );
            }).toList(),
            onContactTap: (contact) => AppToast.success(
              context,
              title: 'On press ${contact.name}',
              message: 'You on press successfully.',
            ),
            onAddTap: () => AppToast.success(
              context,
              title: 'On press',
              message: 'You on press successfully.',
            ),
          ),
        ),

        // ── Transfer options ──
        AnimatedListItem(
          index: 3,
          controller: _animController,
          child: const SectionHeader(title: 'TRANSFER OPTIONS'),
        ),
        AnimatedListItem(
          index: 4,
          controller: _animController,
          child: OptionsGrid(
            items: [
              OptionItem(
                icon: Icons.account_balance_rounded, 
                title: 'Bank Transfer', 
                subtitle: 'To bank account', 
                color: ArgonColors.primary, 
                onTap: () => AppToast.success(
                  context,
                  title: 'On press',
                  message: 'You on press successfully.',
                )
              ),
              OptionItem(
                icon: Icons.phone_android_rounded, 
                title: 'Mobile', 
                subtitle: 'To phone number', 
                color: ArgonColors.success, 
                onTap: () => AppToast.success(
                  context,
                  title: 'On press',
                  message: 'You on press successfully.',
                )
              ),
              OptionItem(
                icon: Icons.qr_code_rounded, 
                title: 'QR Code', 
                subtitle: 'Scan to pay', 
                color: ArgonColors.info, 
                onTap: () => AppToast.success(
                  context,
                  title: 'On press',
                  message: 'You on press successfully.',
                )
              ),
              OptionItem(
                icon: Icons.language_rounded, 
                title: 'International', 
                subtitle: 'Send abroad', 
                color: ArgonColors.warning, 
                onTap: () => AppToast.success(
                  context,
                  title: 'On press',
                  message: 'You on press successfully.',
                )
              ),
            ],
          ),
        ),

        // ── Recent transfers ──
        AnimatedListItem(
          index: 5,
          controller: _animController,
          child: const SectionHeader(title: 'RECENT TRANSFERS'),
        ),
        ..._recentTransfers.asMap().entries.map((entry) {
          final transfer = entry.value;
          return AnimatedListItem(
            index: 6 + entry.key,
            controller: _animController,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TransferCard(
                name: transfer['name'] as String,
                date: transfer['date'] as String? ?? '',
                amount: (transfer['amount'] as num).toDouble(),
                status: _parseStatus(transfer['status'] as String?),
                avatarColor: _avatarColors[entry.key % _avatarColors.length],
                onTap: () => AppToast.success(
                  context,
                  title: 'On press ${transfer['name'] as String}',
                  message: 'You on press successfully.',
                ),
              ),
            ),
          );
        }),
        const SizedBox(height: 24),
      ],
    );
  }
}

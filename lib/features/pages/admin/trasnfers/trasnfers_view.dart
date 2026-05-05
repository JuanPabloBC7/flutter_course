import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/network/services.dart';
import 'package:flutter_course/core/widgets/animated_list_item.dart';
import 'package:flutter_course/core/widgets/contact_avatar.dart';
import 'package:flutter_course/core/widgets/error_state.dart';
import 'package:flutter_course/core/widgets/section_header.dart';

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
        AnimatedListItem(index: 0, controller: _animController, child: const _NewTransferCard()),
        AnimatedListItem(index: 1, controller: _animController, child: const SectionHeader(title: 'FREQUENT CONTACTS')),
        AnimatedListItem(index: 2, controller: _animController, child: _FrequentContacts(contacts: _contacts)),
        AnimatedListItem(index: 3, controller: _animController, child: const SectionHeader(title: 'TRANSFER OPTIONS')),
        AnimatedListItem(index: 4, controller: _animController, child: const _TransferOptions()),
        AnimatedListItem(index: 5, controller: _animController, child: const SectionHeader(title: 'RECENT TRANSFERS')),
        ..._recentTransfers.asMap().entries.map((entry) {
          return AnimatedListItem(
            index: 6 + entry.key,
            controller: _animController,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _RecentTransferCard(
                transfer: entry.value,
                avatarColor: _avatarColors[entry.key % _avatarColors.length],
              ),
            ),
          );
        }),
        const SizedBox(height: 24),
      ],
    );
  }
}

// ── New Transfer Card ────────────────────────────────────────────────────────

class _NewTransferCard extends StatelessWidget {
  const _NewTransferCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 4),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ArgonColors.primary, ArgonColors.primary.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: ArgonColors.primary.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 6))],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: ArgonColors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.send_rounded, color: ArgonColors.white, size: 22),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Send Money', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: ArgonColors.white)),
                SizedBox(height: 2),
                Text('Transfer to anyone, anywhere', style: TextStyle(fontSize: 13, color: Colors.white70)),
              ],
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: ArgonColors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(20)),
            child: const Icon(Icons.arrow_forward_rounded, color: ArgonColors.white, size: 20),
          ),
        ],
      ),
    );
  }
}

// ── Frequent Contacts ────────────────────────────────────────────────────────

class _FrequentContacts extends StatelessWidget {
  final List<Map<String, dynamic>> contacts;

  const _FrequentContacts({required this.contacts});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: contacts.length + 1,
        separatorBuilder: (_, _) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          if (index == 0) {
            return GestureDetector(
              onTap: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: ArgonColors.border.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(26),
                      border: Border.all(color: ArgonColors.border, width: 1.5, strokeAlign: BorderSide.strokeAlignInside),
                    ),
                    child: const Icon(Icons.add_rounded, color: ArgonColors.muted, size: 24),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(
                    width: 68,
                    child: Text('Add', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: ArgonColors.muted)),
                  ),
                ],
              ),
            );
          }

          final contact = contacts[index - 1];
          final colorIndex = (index - 1) % _avatarColors.length;

          return ContactAvatar(
            name: contact['name'] as String,
            color: _avatarColors[colorIndex],
            onTap: () {},
          );
        },
      ),
    );
  }
}

// ── Transfer Options ─────────────────────────────────────────────────────────

class _TransferOptions extends StatelessWidget {
  const _TransferOptions();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _TransferOptionTile(icon: Icons.account_balance_rounded, title: 'Bank Transfer', subtitle: 'To bank account', color: ArgonColors.primary, onTap: () {})),
            const SizedBox(width: 12),
            Expanded(child: _TransferOptionTile(icon: Icons.phone_android_rounded, title: 'Mobile', subtitle: 'To phone number', color: ArgonColors.success, onTap: () {})),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _TransferOptionTile(icon: Icons.qr_code_rounded, title: 'QR Code', subtitle: 'Scan to pay', color: ArgonColors.info, onTap: () {})),
            const SizedBox(width: 12),
            Expanded(child: _TransferOptionTile(icon: Icons.language_rounded, title: 'International', subtitle: 'Send abroad', color: ArgonColors.warning, onTap: () {})),
          ],
        ),
      ],
    );
  }
}

class _TransferOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _TransferOptionTile({required this.icon, required this.title, required this.subtitle, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ArgonColors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: ArgonColors.initial.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 3))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: ArgonColors.text)),
            const SizedBox(height: 2),
            Text(subtitle, style: const TextStyle(fontSize: 11, color: ArgonColors.muted)),
          ],
        ),
      ),
    );
  }
}

// ── Recent Transfer Card ─────────────────────────────────────────────────────

class _RecentTransferCard extends StatelessWidget {
  final Map<String, dynamic> transfer;
  final Color avatarColor;

  const _RecentTransferCard({required this.transfer, required this.avatarColor});

  Color get _statusColor {
    switch (transfer['status']) {
      case 'completed':
        return ArgonColors.success;
      case 'pending':
        return ArgonColors.warning;
      case 'failed':
        return ArgonColors.error;
      default:
        return ArgonColors.muted;
    }
  }

  String get _statusLabel {
    switch (transfer['status']) {
      case 'completed':
        return 'Completed';
      case 'pending':
        return 'Pending';
      case 'failed':
        return 'Failed';
      default:
        return transfer['status'] as String? ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = transfer['name'] as String;
    final amount = (transfer['amount'] as num).toDouble();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: ArgonColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: ArgonColors.initial.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          ContactAvatar(name: name, color: avatarColor, size: 44, showLabel: false),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: ArgonColors.text), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 3),
                Text(transfer['date'] as String? ?? '', style: const TextStyle(fontSize: 12, color: ArgonColors.muted)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('-\$${amount.toStringAsFixed(2)}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: ArgonColors.text)),
              const SizedBox(height: 3),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: _statusColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10)),
                child: Text(_statusLabel, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _statusColor)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

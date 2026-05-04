import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/widgets/contact_avatar.dart';
import 'package:flutter_course/core/widgets/section_header.dart';

// ── Mock data ────────────────────────────────────────────────────────────────

class _Contact {
  final String name;
  final Color color;

  const _Contact({required this.name, required this.color});
}

class _RecentTransfer {
  final String name;
  final String date;
  final double amount;
  final String status; // completed, pending, failed
  final Color avatarColor;

  const _RecentTransfer({
    required this.name,
    required this.date,
    required this.amount,
    required this.status,
    required this.avatarColor,
  });
}

const List<_Contact> _frequentContacts = [
  _Contact(name: 'Ana García', color: ArgonColors.primary),
  _Contact(name: 'Carlos López', color: ArgonColors.success),
  _Contact(name: 'María Torres', color: ArgonColors.info),
  _Contact(name: 'Juan Pérez', color: ArgonColors.warning),
  _Contact(name: 'Laura Díaz', color: ArgonColors.label),
  _Contact(name: 'Pedro Ruiz', color: ArgonColors.error),
];

const List<_RecentTransfer> _recentTransfers = [
  _RecentTransfer(
    name: 'Ana García',
    date: 'Today, 10:30 AM',
    amount: 250.00,
    status: 'completed',
    avatarColor: ArgonColors.primary,
  ),
  _RecentTransfer(
    name: 'Carlos López',
    date: 'Today, 8:15 AM',
    amount: 1200.00,
    status: 'pending',
    avatarColor: ArgonColors.success,
  ),
  _RecentTransfer(
    name: 'María Torres',
    date: 'Yesterday, 4:45 PM',
    amount: 85.50,
    status: 'completed',
    avatarColor: ArgonColors.info,
  ),
  _RecentTransfer(
    name: 'Juan Pérez',
    date: 'Yesterday, 1:20 PM',
    amount: 500.00,
    status: 'failed',
    avatarColor: ArgonColors.warning,
  ),
  _RecentTransfer(
    name: 'Laura Díaz',
    date: 'Mon, 9:00 AM',
    amount: 320.00,
    status: 'completed',
    avatarColor: ArgonColors.label,
  ),
];

// ── Transfers View ───────────────────────────────────────────────────────────

class TransfersView extends StatefulWidget {
  const TransfersView({super.key});

  @override
  State<TransfersView> createState() => _TransfersViewState();
}

class _TransfersViewState extends State<TransfersView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Widget _buildAnimatedItem({required int index, required Widget child}) {
    final start = (index * 0.08).clamp(0.0, 0.6);
    final end = (start + 0.4).clamp(0.0, 1.0);

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.12),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _animController,
        curve: Interval(start, end, curve: Curves.easeOutCubic),
      )),
      child: FadeTransition(
        opacity: CurvedAnimation(
          parent: _animController,
          curve: Interval(start, end, curve: Curves.easeOut),
        ),
        child: child,
      ),
    );
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
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: ArgonColors.text,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded,
                color: ArgonColors.text, size: 24),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          // ── New transfer card ──
          _buildAnimatedItem(
            index: 0,
            child: const _NewTransferCard(),
          ),

          // ── Frequent contacts ──
          _buildAnimatedItem(
            index: 1,
            child: const SectionHeader(title: 'FREQUENT CONTACTS'),
          ),
          _buildAnimatedItem(
            index: 2,
            child: const _FrequentContacts(),
          ),

          // ── Transfer options ──
          _buildAnimatedItem(
            index: 3,
            child: const SectionHeader(title: 'TRANSFER OPTIONS'),
          ),
          _buildAnimatedItem(
            index: 4,
            child: const _TransferOptions(),
          ),

          // ── Recent transfers ──
          _buildAnimatedItem(
            index: 5,
            child: const SectionHeader(title: 'RECENT TRANSFERS'),
          ),
          ..._recentTransfers.asMap().entries.map((entry) {
            return _buildAnimatedItem(
              index: 6 + entry.key,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _RecentTransferCard(transfer: entry.value),
              ),
            );
          }),

          const SizedBox(height: 24),
        ],
      ),
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
          colors: [
            ArgonColors.primary,
            ArgonColors.primary.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: ArgonColors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: ArgonColors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.send_rounded,
                  color: ArgonColors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Send Money',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: ArgonColors.white,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Transfer to anyone, anywhere',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: ArgonColors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: ArgonColors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Frequent Contacts ────────────────────────────────────────────────────────

class _FrequentContacts extends StatelessWidget {
  const _FrequentContacts();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _frequentContacts.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          // First item is "Add new"
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
                      color: ArgonColors.border.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(26),
                      border: Border.all(
                        color: ArgonColors.border,
                        width: 1.5,
                        strokeAlign: BorderSide.strokeAlignInside,
                      ),
                    ),
                    child: const Icon(
                      Icons.add_rounded,
                      color: ArgonColors.muted,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(
                    width: 68,
                    child: Text(
                      'Add',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: ArgonColors.muted,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          final contact = _frequentContacts[index - 1];
          return ContactAvatar(
            name: contact.name,
            color: contact.color,
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
            Expanded(
              child: _TransferOptionTile(
                icon: Icons.account_balance_rounded,
                title: 'Bank Transfer',
                subtitle: 'To bank account',
                color: ArgonColors.primary,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _TransferOptionTile(
                icon: Icons.phone_android_rounded,
                title: 'Mobile',
                subtitle: 'To phone number',
                color: ArgonColors.success,
                onTap: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _TransferOptionTile(
                icon: Icons.qr_code_rounded,
                title: 'QR Code',
                subtitle: 'Scan to pay',
                color: ArgonColors.info,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _TransferOptionTile(
                icon: Icons.language_rounded,
                title: 'International',
                subtitle: 'Send abroad',
                color: ArgonColors.warning,
                onTap: () {},
              ),
            ),
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

  const _TransferOptionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ArgonColors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: ArgonColors.initial.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: ArgonColors.text,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 11,
                color: ArgonColors.muted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Recent Transfer Card ─────────────────────────────────────────────────────

class _RecentTransferCard extends StatelessWidget {
  final _RecentTransfer transfer;

  const _RecentTransferCard({required this.transfer});

  Color get _statusColor {
    switch (transfer.status) {
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
    switch (transfer.status) {
      case 'completed':
        return 'Completed';
      case 'pending':
        return 'Pending';
      case 'failed':
        return 'Failed';
      default:
        return transfer.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: ArgonColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: ArgonColors.initial.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ContactAvatar(
            name: transfer.name,
            color: transfer.avatarColor,
            size: 44,
            showLabel: false,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transfer.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: ArgonColors.text,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Text(
                  transfer.date,
                  style: const TextStyle(
                    fontSize: 12,
                    color: ArgonColors.muted,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '-\$${transfer.amount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: ArgonColors.text,
                ),
              ),
              const SizedBox(height: 3),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: _statusColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _statusLabel,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _statusColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

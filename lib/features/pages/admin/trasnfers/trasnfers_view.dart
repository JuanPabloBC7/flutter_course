import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/widgets/animated_list_item.dart';
import 'package:flutter_course/core/widgets/app_toast.dart';
import 'package:flutter_course/core/widgets/error_state.dart';
import 'package:flutter_course/core/widgets/frequent_contacts.dart';
import 'package:flutter_course/core/widgets/gradient_action_card.dart';
import 'package:flutter_course/core/widgets/options_grid.dart';
import 'package:flutter_course/core/widgets/section_header.dart';
import 'package:flutter_course/core/widgets/transfer_card.dart';
import 'package:flutter_course/features/pages/admin/trasnfers/providers/transfers_providers.dart';
import 'package:flutter_course/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const List<Color> _avatarColors = [
  ArgonColors.primary,
  ArgonColors.success,
  ArgonColors.info,
  ArgonColors.warning,
  ArgonColors.label,
  ArgonColors.error,
];

class TransfersView extends ConsumerStatefulWidget {
  const TransfersView({super.key});

  @override
  ConsumerState<TransfersView> createState() => _TransfersViewState();
}

class _TransfersViewState extends ConsumerState<TransfersView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
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
    final l10n = AppLocalizations.of(context)!;
    final transfersAsync = ref.watch(transfersProvider);

    return Scaffold(
      backgroundColor: ArgonColors.bgColorScreen,
      appBar: AppBar(
        backgroundColor: ArgonColors.white,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          l10n.transfersTitle,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: ArgonColors.text),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded, color: ArgonColors.text, size: 24),
            onPressed: () {},
          ),
        ],
      ),
      body: transfersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: ArgonColors.primary)),
        error: (error, _) => ErrorState(message: error.toString(), onRetry: () => ref.invalidate(transfersProvider)),
        data: (data) {
          _animController.forward(from: 0);

          return RefreshIndicator(
            color: ArgonColors.primary,
            onRefresh: () async => ref.invalidate(transfersProvider),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                AnimatedListItem(
                  index: 0,
                  controller: _animController,
                  child: GradientActionCard(
                    title: l10n.sendMoney,
                    subtitle: l10n.sendMoneySubtitle,
                    icon: Icons.send_rounded,
                    onTap: () {},
                  ),
                ),

                AnimatedListItem(
                  index: 1,
                  controller: _animController,
                  child: SectionHeader(title: l10n.sectionFrequentContacts),
                ),
                AnimatedListItem(
                  index: 2,
                  controller: _animController,
                  child: FrequentContacts(
                    contacts: data.contacts.asMap().entries.map((entry) {
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

                AnimatedListItem(
                  index: 3,
                  controller: _animController,
                  child: SectionHeader(title: l10n.sectionTransferOptions),
                ),
                AnimatedListItem(
                  index: 4,
                  controller: _animController,
                  child: OptionsGrid(
                    items: [
                      OptionItem(icon: Icons.account_balance_rounded, title: l10n.optionBankTransfer, subtitle: l10n.optionBankTransferSubtitle, color: ArgonColors.primary, onTap: () {}),
                      OptionItem(icon: Icons.phone_android_rounded, title: l10n.optionMobile, subtitle: l10n.optionMobileSubtitle, color: ArgonColors.success, onTap: () {}),
                      OptionItem(icon: Icons.qr_code_rounded, title: l10n.optionQRCode, subtitle: l10n.optionQRCodeSubtitle, color: ArgonColors.info, onTap: () {}),
                      OptionItem(icon: Icons.language_rounded, title: l10n.optionInternational, subtitle: l10n.optionInternationalSubtitle, color: ArgonColors.warning, onTap: () {}),
                    ],
                  ),
                ),

                AnimatedListItem(
                  index: 5,
                  controller: _animController,
                  child: SectionHeader(title: l10n.sectionRecentTransfers),
                ),
                ...data.recentTransfers.asMap().entries.map((entry) {
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
                        onTap: () {},
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}

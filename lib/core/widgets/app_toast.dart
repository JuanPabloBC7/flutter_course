import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';

/// Types of toast notifications.
enum ToastType { success, error, warning, info, loading, neutral, promotion }

/// A customizable toast notification that slides in from the top of the screen.
///
/// Usage:
/// ```dart
/// AppToast.show(context, message: 'Transfer completed!', type: ToastType.success);
/// AppToast.show(context, message: 'Network error', type: ToastType.error);
/// AppToast.show(context, message: 'Low balance', type: ToastType.warning);
/// AppToast.show(context, message: 'New update available', type: ToastType.info);
/// ```
class AppToast {
  AppToast._();

  static OverlayEntry? _currentEntry;
  static Timer? _dismissTimer;

  /// Shows a toast notification at the top of the screen.
  ///
  /// - [message]: The text to display.
  /// - [type]: The toast type (success, error, warning, info).
  /// - [duration]: How long the toast stays visible (default 3 seconds).
  /// - [title]: Optional title displayed above the message.
  /// - [showIcon]: Whether to show the type icon (default true).
  /// - [dismissible]: Whether the user can swipe to dismiss (default true).
  static void show(
    BuildContext context, {
    required String message,
    ToastType type = ToastType.info,
    Duration duration = const Duration(seconds: 3),
    String? title,
    bool showIcon = true,
    bool dismissible = true,
  }) {
    // Dismiss any existing toast
    dismiss();

    final overlay = Overlay.of(context);

    _currentEntry = OverlayEntry(
      builder: (context) => _ToastWidget(
        message: message,
        type: type,
        title: title,
        showIcon: showIcon,
        dismissible: dismissible,
        onDismiss: dismiss,
      ),
    );

    overlay.insert(_currentEntry!);

    _dismissTimer = Timer(duration, dismiss);
  }

  /// Dismisses the current toast if one is showing.
  static void dismiss() {
    _dismissTimer?.cancel();
    _dismissTimer = null;
    _currentEntry?.remove();
    _currentEntry = null;
  }

  // ── Convenience methods ──────────────────────────────────────────────────

  /// Shows a success toast.
  static void success(BuildContext context, {required String message, String? title}) {
    show(context, message: message, type: ToastType.success, title: title);
  }

  /// Shows an error toast.
  static void error(BuildContext context, {required String message, String? title}) {
    show(context, message: message, type: ToastType.error, title: title);
  }

  /// Shows a warning toast.
  static void warning(BuildContext context, {required String message, String? title}) {
    show(context, message: message, type: ToastType.warning, title: title);
  }

  /// Shows an info toast.
  static void info(BuildContext context, {required String message, String? title}) {
    show(context, message: message, type: ToastType.info, title: title);
  }

  /// Shows a loading toast (stays until manually dismissed or replaced).
  static void loading(BuildContext context, {required String message, String? title}) {
    show(context, message: message, type: ToastType.loading, title: title, duration: const Duration(seconds: 30));
  }

  /// Shows a neutral toast (generic notification).
  static void neutral(BuildContext context, {required String message, String? title}) {
    show(context, message: message, type: ToastType.neutral, title: title);
  }

  /// Shows a promotion toast (offers, news, updates).
  static void promotion(BuildContext context, {required String message, String? title}) {
    show(context, message: message, type: ToastType.promotion, title: title);
  }
}

// ── Toast Widget (internal) ──────────────────────────────────────────────────

class _ToastWidget extends StatefulWidget {
  final String message;
  final ToastType type;
  final String? title;
  final bool showIcon;
  final bool dismissible;
  final VoidCallback onDismiss;

  const _ToastWidget({
    required this.message,
    required this.type,
    this.title,
    required this.showIcon,
    required this.dismissible,
    required this.onDismiss,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleDismiss() {
    _controller.reverse().then((_) => widget.onDismiss());
  }

  @override
  Widget build(BuildContext context) {
    final config = _ToastConfig.fromType(widget.type);
    final topPadding = MediaQuery.of(context).padding.top;

    Widget toast = SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: EdgeInsets.only(top: topPadding + 12, left: 16, right: 16),
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: config.backgroundColor,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: config.borderColor, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: config.color.withValues(alpha: 0.15),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  if (widget.showIcon) ...[
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: config.color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: widget.type == ToastType.loading
                          ? Padding(
                              padding: const EdgeInsets.all(8),
                              child: CircularProgressIndicator(
                                color: config.color,
                                strokeWidth: 2.5,
                              ),
                            )
                          : Icon(config.icon, color: config.color, size: 20),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.title != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Text(
                              widget.title!,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: config.color,
                              ),
                            ),
                          ),
                        Text(
                          widget.message,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: ArgonColors.text,
                            height: 1.3,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _handleDismiss,
                    child: Icon(
                      Icons.close_rounded,
                      color: ArgonColors.muted.withValues(alpha: 0.6),
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    if (widget.dismissible) {
      toast = Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.up,
        onDismissed: (_) => widget.onDismiss(),
        child: toast,
      );
    }

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: toast,
    );
  }
}

// ── Toast Configuration ──────────────────────────────────────────────────────

class _ToastConfig {
  final Color color;
  final Color backgroundColor;
  final Color borderColor;
  final IconData icon;

  const _ToastConfig({
    required this.color,
    required this.backgroundColor,
    required this.borderColor,
    required this.icon,
  });

  factory _ToastConfig.fromType(ToastType type) {
    switch (type) {
      case ToastType.success:
        return _ToastConfig(
          color: ArgonColors.success,
          backgroundColor: ArgonColors.white,
          borderColor: ArgonColors.success.withValues(alpha: 0.3),
          icon: Icons.check_circle_outline_rounded,
        );
      case ToastType.error:
        return _ToastConfig(
          color: ArgonColors.error,
          backgroundColor: ArgonColors.white,
          borderColor: ArgonColors.error.withValues(alpha: 0.3),
          icon: Icons.error_outline_rounded,
        );
      case ToastType.warning:
        return _ToastConfig(
          color: ArgonColors.warning,
          backgroundColor: ArgonColors.white,
          borderColor: ArgonColors.warning.withValues(alpha: 0.3),
          icon: Icons.warning_amber_rounded,
        );
      case ToastType.info:
        return _ToastConfig(
          color: ArgonColors.info,
          backgroundColor: ArgonColors.white,
          borderColor: ArgonColors.info.withValues(alpha: 0.3),
          icon: Icons.info_outline_rounded,
        );
      case ToastType.loading:
        return _ToastConfig(
          color: ArgonColors.primary,
          backgroundColor: ArgonColors.white,
          borderColor: ArgonColors.primary.withValues(alpha: 0.3),
          icon: Icons.hourglass_top_rounded,
        );
      case ToastType.neutral:
        return const _ToastConfig(
          color: ArgonColors.header,
          backgroundColor: ArgonColors.white,
          borderColor: ArgonColors.border,
          icon: Icons.notifications_none_rounded,
        );
      case ToastType.promotion:
        return _ToastConfig(
          color: ArgonColors.label,
          backgroundColor: ArgonColors.white,
          borderColor: ArgonColors.label.withValues(alpha: 0.3),
          icon: Icons.local_offer_rounded,
        );
    }
  }
}

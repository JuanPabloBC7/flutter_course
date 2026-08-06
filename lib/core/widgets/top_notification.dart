import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';

/// Tipos de notificación disponibles.
enum NotificationType { success, error, warning, info }

/// Notificación que aparece en la parte superior de la pantalla.
/// Se puede usar desde cualquier contexto con [TopNotification.show].
class TopNotification extends StatefulWidget {
  final String message;
  final NotificationType type;
  final VoidCallback onDismiss;

  const TopNotification({
    super.key,
    required this.message,
    required this.type,
    required this.onDismiss,
  });

  /// Muestra una notificación en la parte superior de la pantalla.
  static void show(
    BuildContext context, {
    required String message,
    NotificationType type = NotificationType.success,
    Duration duration = const Duration(seconds: 4),
  }) {
    final overlay = Overlay.of(context, rootOverlay: true);
    OverlayEntry? entry;

    entry = OverlayEntry(
      builder: (context) => TopNotification(
        message: message,
        type: type,
        onDismiss: () {
          entry?.remove();
          entry = null;
        },
      ),
    );

    overlay.insert(entry!);

    // Auto-dismiss
    Future.delayed(duration, () {
      entry?.remove();
      entry = null;
    });
  }

  @override
  State<TopNotification> createState() => _TopNotificationState();
}

class _TopNotificationState extends State<TopNotification>
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

  /// Retorna el color del icono según el tipo de notificación.
  Color get _iconColor {
    switch (widget.type) {
      case NotificationType.success:
        return ArgonColors.success;
      case NotificationType.error:
        return ArgonColors.error;
      case NotificationType.warning:
        return ArgonColors.warning;
      case NotificationType.info:
        return ArgonColors.info;
    }
  }

  /// Retorna el icono según el tipo de notificación.
  IconData get _icon {
    switch (widget.type) {
      case NotificationType.success:
        return Icons.check_circle_rounded;
      case NotificationType.error:
        return Icons.error_rounded;
      case NotificationType.warning:
        return Icons.warning_rounded;
      case NotificationType.info:
        return Icons.info_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 8,
      left: 16,
      right: 16,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: widget.onDismiss,
              onVerticalDragEnd: (details) {
                if (details.velocity.pixelsPerSecond.dy < 0) {
                  widget.onDismiss();
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: ArgonColors.text,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: _iconColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        _icon,
                        color: _iconColor,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.message,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: ArgonColors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.close_rounded,
                      color: ArgonColors.muted,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

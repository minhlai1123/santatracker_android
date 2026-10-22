import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/services/christmas_audio_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/christmas_typography.dart';
import '../../../../shared/widgets/festive_button.dart';
import '../controllers/notification_settings_controller.dart';
import 'even_day_special_badge.dart';
import 'notification_preview_card.dart';

class NotificationSettingsSheet extends StatefulWidget {
  final NotificationSettingsController controller;

  const NotificationSettingsSheet({super.key, required this.controller});

  static Future<void> show(
    BuildContext context, {
    required NotificationSettingsController controller,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => NotificationSettingsSheet(controller: controller),
    );
  }

  @override
  State<NotificationSettingsSheet> createState() =>
      _NotificationSettingsSheetState();
}

class _NotificationSettingsSheetState extends State<NotificationSettingsSheet> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onControllerUpdate);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerUpdate);
    super.dispose();
  }

  void _onControllerUpdate() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _pickTime() async {
    ChristmasAudioService.playButtonClick();
    final currentHour = widget.controller.settings.preferredHour;
    final currentMinute = widget.controller.settings.preferredMinute;

    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: currentHour, minute: currentMinute),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.christmasRed,
              onPrimary: Colors.white,
              onSurface: AppColors.pineGreen,
            ),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );

    if (picked != null) {
      await widget.controller.updateTime(picked.hour, picked.minute);
    }
  }

  Future<void> _sendTest() async {
    ChristmasAudioService.playChristmasBell();
    await widget.controller.sendTestNotification();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(
                Icons.mark_email_read_rounded,
                color: Color(0xFFFEF08A),
                size: 20,
              ),
              const SizedBox(width: AppDimensions.spaceSM),
              const Expanded(
                child: Text(
                  AppStrings.testNotificationSentToast,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.pineGreen,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  String _formattedTime() {
    final hour = widget.controller.settings.preferredHour;
    final minute = widget.controller.settings.preferredMinute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour == 0
        ? 12
        : hour > 12
        ? hour - 12
        : hour;
    final displayMinute = minute.toString().padLeft(2, '0');
    return '$displayHour:$displayMinute $period';
  }

  @override
  Widget build(BuildContext context) {
    final settings = widget.controller.settings;
    final todayItem = widget.controller.todayNotification;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusXL),
        ),
      ),
      padding: EdgeInsets.only(
        top: AppDimensions.spaceMD,
        left: AppDimensions.spaceLG,
        right: AppDimensions.spaceLG,
        bottom:
            MediaQuery.of(context).viewInsets.bottom + AppDimensions.spaceXL,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Sheet Handle Pill
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.cardBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.spaceMD),

            // Header Row
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFEF4444), Color(0xFF991B1B)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withAlpha(60),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.notifications_active_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: AppDimensions.spaceMD),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.dailyRemindersTitle,
                        style: ChristmasTypography.titleLarge,
                      ),
                      SizedBox(height: 2),
                      Text(
                        AppStrings.dailyRemindersSubtitle,
                        style: ChristmasTypography.bodySmall,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  tooltip: AppStrings.closeNotificationSheet,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.spaceLG),

            // Daily Reminders Toggle Switch Tile
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spaceMD,
                vertical: AppDimensions.spaceSM,
              ),
              decoration: BoxDecoration(
                color: AppColors.softSnow,
                borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.enableDailyReminders,
                          style: TextStyle(
                            fontFamily: ChristmasTypography.fontFamilyUI,
                            fontFamilyFallback:
                                ChristmasTypography.fallbackFonts,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          AppStrings.enableDailyRemindersDesc,
                          style: ChristmasTypography.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Switch.adaptive(
                    key: const Key('key_toggle_daily_notifications'),
                    value: settings.isEnabled,
                    activeTrackColor: AppColors.christmasRed,
                    onChanged: (val) {
                      ChristmasAudioService.playButtonClick();
                      widget.controller.toggleEnabled(val);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimensions.spaceMD),

            // Time Selector Row (if enabled)
            if (settings.isEnabled) ...[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spaceMD,
                  vertical: AppDimensions.spaceSM,
                ),
                decoration: BoxDecoration(
                  color: AppColors.softSnow,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.schedule_rounded,
                      size: 20,
                      color: AppColors.pineGreen,
                    ),
                    const SizedBox(width: AppDimensions.spaceSM),
                    const Expanded(
                      child: Text(
                        AppStrings.reminderTimeLabel,
                        style: TextStyle(
                          fontFamily: ChristmasTypography.fontFamilyUI,
                          fontFamilyFallback: ChristmasTypography.fallbackFonts,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    TextButton.icon(
                      key: const Key('btn_pick_notification_time'),
                      onPressed: _pickTime,
                      icon: const Icon(
                        Icons.edit_rounded,
                        size: 16,
                        color: AppColors.pineGreen,
                      ),
                      label: Text(
                        _formattedTime(),
                        style: const TextStyle(
                          fontFamily: ChristmasTypography.fontFamilyUI,
                          fontFamilyFallback: ChristmasTypography.fallbackFonts,
                          fontWeight: FontWeight.w700,
                          color: AppColors.pineGreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimensions.spaceLG),
            ],

            // Loud Christmas Bell Chime Card
            Container(
              padding: const EdgeInsets.all(AppDimensions.spaceMD),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
                border: Border.all(color: const Color(0xFFFCA5A5), width: 1.2),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.christmasRed.withAlpha(25),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.notifications_active_rounded,
                      color: AppColors.christmasRed,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spaceMD),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.notificationBellChimeTitle,
                          style: TextStyle(
                            fontFamily: ChristmasTypography.fontFamilyUI,
                            fontFamilyFallback:
                                ChristmasTypography.fallbackFonts,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF991B1B),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          AppStrings.notificationBellChimeDesc,
                          style: TextStyle(
                            fontFamily: ChristmasTypography.fontFamilyUI,
                            fontFamilyFallback:
                                ChristmasTypography.fallbackFonts,
                            fontSize: 12,
                            height: 1.3,
                            color: Color(0xFF7F1D1D),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    key: const Key('btn_preview_bell_sound'),
                    tooltip: 'Play chime preview',
                    icon: const Icon(
                      Icons.volume_up_rounded,
                      color: AppColors.christmasRed,
                      size: 24,
                    ),
                    onPressed: () => ChristmasAudioService.playChristmasBell(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimensions.spaceMD),

            // Even-Day Special Feature Callout
            Container(
              padding: const EdgeInsets.all(AppDimensions.spaceMD),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xFFFEF3C7), const Color(0xFFFFFBEB)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
                border: Border.all(
                  color: AppColors.warmGold.withAlpha(120),
                  width: 1.2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const EvenDaySpecialBadge(),
                      const Spacer(),
                      if (widget.controller.isTodayEvenDay)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.spaceSM,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDCFCE7),
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusFull,
                            ),
                          ),
                          child: const Text(
                            'Active Today!',
                            style: TextStyle(
                              fontFamily: ChristmasTypography.fontFamilyUI,
                              fontFamilyFallback:
                                  ChristmasTypography.fallbackFonts,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF166534),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.spaceSM),
                  const Text(
                    AppStrings.evenDaysSpecialDesc,
                    style: TextStyle(
                      fontFamily: ChristmasTypography.fontFamilyUI,
                      fontFamilyFallback: ChristmasTypography.fallbackFonts,
                      fontSize: 12.5,
                      height: 1.35,
                      color: Color(0xFF78350F),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimensions.spaceLG),

            // Today's Preview Section Header
            const Text(
              AppStrings.todayNotificationPreviewTitle,
              style: TextStyle(
                fontFamily: ChristmasTypography.fontFamilyUI,
                fontFamilyFallback: ChristmasTypography.fallbackFonts,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.spaceSM),

            // Today's Notification Preview Card
            NotificationPreviewCard(item: todayItem),
            const SizedBox(height: AppDimensions.spaceLG),

            // Send Test Notification Action Button
            FestiveButton(
              key: const Key('btn_send_test_notification'),
              label: AppStrings.sendTestNotificationButton,
              icon: Icons.notifications_active_rounded,
              style: FestiveButtonStyle.primary,
              isExpanded: true,
              onPressed: _sendTest,
            ),
          ],
        ),
      ),
    );
  }
}

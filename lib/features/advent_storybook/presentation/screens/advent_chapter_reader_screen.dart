import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/festive_button.dart';
import '../controllers/advent_storybook_controller.dart';
import '../../domain/models/advent_chapter.dart';

class AdventChapterReaderScreen extends StatefulWidget {
  final AdventChapter chapter;
  final AdventStorybookController controller;

  const AdventChapterReaderScreen({
    super.key,
    required this.chapter,
    required this.controller,
  });

  @override
  State<AdventChapterReaderScreen> createState() =>
      _AdventChapterReaderScreenState();
}

class _AdventChapterReaderScreenState extends State<AdventChapterReaderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${AppStrings.adventDayPrefix} ${widget.chapter.dayNumber}',
        ),
      ),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: widget.controller,
          builder: (context, _) {
            final isRead = widget.controller.state.isChapterRead(
              widget.chapter.dayNumber,
            );

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppDimensions.spaceLG),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 580),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Book Chapter Card
                      Container(
                        padding: const EdgeInsets.all(AppDimensions.spaceXL),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFDF8), // Warm parchment
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusLG,
                          ),
                          border: Border.all(
                            color: const Color(0xFFE2D9C8),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(10),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Chapter Subtitle & Status
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${AppStrings.adventChapterPrefix.toUpperCase()} ${widget.chapter.dayNumber}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1.2,
                                    color: AppColors.christmasRed,
                                  ),
                                ),
                                if (isRead)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFDCFCE7),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.check_circle_rounded,
                                          size: 14,
                                          color: AppColors.pineGreen,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          AppStrings.adventStatusRead,
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.pineGreen,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: AppDimensions.spaceSM),

                            // Chapter Title
                            Text(
                              widget.chapter.title,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: AppDimensions.spaceLG),

                            // Divider
                            Container(
                              height: 1,
                              color: const Color(0xFFE2D9C8),
                            ),
                            const SizedBox(height: AppDimensions.spaceLG),

                            // Story Content
                            Text(
                              widget.chapter.storyContent,
                              style: const TextStyle(
                                fontSize: 15,
                                height: 1.7,
                                color: Color(0xFF2D3748),
                                letterSpacing: 0.2,
                              ),
                            ),
                            const SizedBox(height: AppDimensions.spaceXL),

                            // Festive Message Box
                            Container(
                              padding: const EdgeInsets.all(
                                AppDimensions.spaceMD,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.christmasRed.withAlpha(12),
                                borderRadius: BorderRadius.circular(
                                  AppDimensions.radiusMD,
                                ),
                                border: Border.all(
                                  color: AppColors.christmasRed.withAlpha(60),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.auto_awesome_rounded,
                                        size: 18,
                                        color: AppColors.christmasRed,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        AppStrings.festiveMessageTitle,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.christmasRed,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    widget.chapter.festiveMessage,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontStyle: FontStyle.italic,
                                      color: AppColors.textPrimary,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: AppDimensions.spaceMD),

                            // Riddle / Activity Box
                            Container(
                              padding: const EdgeInsets.all(
                                AppDimensions.spaceMD,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.pineGreen.withAlpha(12),
                                borderRadius: BorderRadius.circular(
                                  AppDimensions.radiusMD,
                                ),
                                border: Border.all(
                                  color: AppColors.pineGreen.withAlpha(60),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.lightbulb_rounded,
                                        size: 18,
                                        color: AppColors.pineGreen,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        AppStrings.activityPromptTitle,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.pineGreen,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    widget.chapter.activityOrRiddle,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textPrimary,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spaceLG),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: FestiveButton(
                              key: const Key('btn_back_to_storybook'),
                              label: AppStrings.backToStorybookButton,
                              icon: Icons.arrow_back_rounded,
                              style: FestiveButtonStyle.outlined,
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ),
                          const SizedBox(width: AppDimensions.spaceMD),
                          Expanded(
                            child: FestiveButton(
                              key: const Key('btn_mark_as_read'),
                              label: isRead
                                  ? AppStrings.adventStatusRead
                                  : AppStrings.markAsReadButton,
                              icon: Icons.check_circle_rounded,
                              style: FestiveButtonStyle.primary,
                              onPressed: () {
                                widget.controller.markChapterAsRead(
                                  widget.chapter.dayNumber,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Đã ghi nhận đọc ${widget.chapter.title}!',
                                    ),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

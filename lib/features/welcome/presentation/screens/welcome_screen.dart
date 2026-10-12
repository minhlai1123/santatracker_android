import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/festive_button.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../widgets/festive_badge.dart';
import '../widgets/welcome_header.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spaceLG,
              vertical: AppDimensions.spaceXL,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const WelcomeHeader(),
                  const SizedBox(height: AppDimensions.spaceXL),
                  _buildIntroCard(),
                  const SizedBox(height: AppDimensions.spaceMD),
                  _buildFoundationStatusCard(),
                  const SizedBox(height: AppDimensions.spaceLG),
                  _buildBadgesSection(),
                  const SizedBox(height: AppDimensions.spaceXL),
                  FestiveButton(
                    label: AppStrings.enterHomeButton,
                    icon: Icons.arrow_forward_rounded,
                    isExpanded: true,
                    onPressed: () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      } else {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: AppDimensions.spaceXL),
                  _buildFooterGreeting(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIntroCard() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spaceLG),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            AppStrings.welcomeTitle,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              height: 1.3,
            ),
          ),
          SizedBox(height: AppDimensions.spaceSM),
          Text(
            AppStrings.welcomeSubtitle,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoundationStatusCard() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spaceMD),
      decoration: BoxDecoration(
        color: AppColors.softSnow,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimensions.spaceSM),
            decoration: BoxDecoration(
              color: AppColors.pineGreen.withAlpha(25),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.verified_rounded,
              size: AppDimensions.iconSizeMD,
              color: AppColors.pineGreen,
            ),
          ),
          const SizedBox(width: AppDimensions.spaceMD),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.foundationStatusTitle,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: AppDimensions.spaceXS),
                Text(
                  AppStrings.foundationStatusDesc,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgesSection() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: AppDimensions.spaceSM,
      runSpacing: AppDimensions.spaceSM,
      children: const [
        FestiveBadge(
          label: AppStrings.offlineFirstBadge,
          icon: Icons.cloud_off_rounded,
          iconColor: AppColors.pineGreen,
        ),
        FestiveBadge(
          label: AppStrings.privacyBadge,
          icon: Icons.shield_rounded,
          iconColor: AppColors.christmasRed,
        ),
      ],
    );
  }

  Widget _buildFooterGreeting() {
    return const Text(
      AppStrings.holidayGreeting,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.textMuted,
        letterSpacing: 0.3,
      ),
    );
  }
}

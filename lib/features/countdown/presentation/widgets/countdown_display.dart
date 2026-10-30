import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../domain/models/countdown_state.dart';
import 'countdown_time_unit.dart';

class CountdownDisplay extends StatelessWidget {
  final CountdownState state;

  const CountdownDisplay({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CountdownTimeUnit(
            value: state.formattedDays,
            label: AppStrings.daysLabel,
            isHighlight: true,
          ),
        ),
        const SizedBox(width: AppDimensions.spaceSM),
        Expanded(
          child: CountdownTimeUnit(
            value: state.formattedHours,
            label: AppStrings.hoursLabel,
          ),
        ),
        const SizedBox(width: AppDimensions.spaceSM),
        Expanded(
          child: CountdownTimeUnit(
            value: state.formattedMinutes,
            label: AppStrings.minutesLabel,
          ),
        ),
        const SizedBox(width: AppDimensions.spaceSM),
        Expanded(
          child: CountdownTimeUnit(
            value: state.formattedSeconds,
            label: AppStrings.secondsLabel,
          ),
        ),
      ],
    );
  }
}

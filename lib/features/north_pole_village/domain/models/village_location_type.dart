import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';

enum VillageLocationType {
  plaza,
  residence,
  workshop,
  stables,
  landmark,
  postOffice,
  bakery,
  nature;

  String get label {
    switch (this) {
      case VillageLocationType.plaza:
        return AppStrings.categoryPlaza;
      case VillageLocationType.residence:
        return AppStrings.categoryResidence;
      case VillageLocationType.workshop:
        return AppStrings.categoryWorkshop;
      case VillageLocationType.stables:
        return AppStrings.categoryStables;
      case VillageLocationType.landmark:
        return AppStrings.categoryLandmark;
      case VillageLocationType.postOffice:
        return AppStrings.categoryPostOffice;
      case VillageLocationType.bakery:
        return AppStrings.categoryBakery;
      case VillageLocationType.nature:
        return AppStrings.categoryNature;
    }
  }

  IconData get icon {
    switch (this) {
      case VillageLocationType.plaza:
        return Icons.holiday_village_rounded;
      case VillageLocationType.residence:
        return Icons.cottage_rounded;
      case VillageLocationType.workshop:
        return Icons.handyman_rounded;
      case VillageLocationType.stables:
        return Icons.pets_rounded;
      case VillageLocationType.landmark:
        return Icons.park_rounded;
      case VillageLocationType.postOffice:
        return Icons.markunread_mailbox_rounded;
      case VillageLocationType.bakery:
        return Icons.bakery_dining_rounded;
      case VillageLocationType.nature:
        return Icons.ac_unit_rounded;
    }
  }
}

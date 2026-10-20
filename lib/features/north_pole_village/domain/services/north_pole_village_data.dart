import '../models/village_location.dart';
import '../models/village_location_type.dart';

class NorthPoleVillageData {
  const NorthPoleVillageData._();

  static const List<VillageLocation> defaultLocations = [
    VillageLocation(
      id: 'christmas_plaza',
      name: 'Holiday Plaza',
      type: VillageLocationType.plaza,
      description: 'The liveliest gathering center of the North Pole village filled with festive celebrations.',
      details: 'Where elves and reindeer gather to sing Christmas carols beneath dazzling fairy lights.',
      normalizedX: 0.50,
      normalizedY: 0.52,
      order: 0,
    ),
    VillageLocation(
      id: 'santa_house',
      name: "Santa's Cottage",
      type: VillageLocationType.residence,
      description: 'A cozy wooden home with a crackling fireplace and iconic rocking chair.',
      details: 'Where Santa Claus reads wish letters from around the world and enjoys freshly baked cookies.',
      normalizedX: 0.24,
      normalizedY: 0.26,
      order: 1,
    ),
    VillageLocation(
      id: 'gift_workshop',
      name: "Elves' Toy Workshop",
      type: VillageLocationType.workshop,
      description: 'A buzzing workshop filled with cheerful hammering and the laughter of elf craftsmen.',
      details: 'Millions of unique handcrafted toys are meticulously built throughout the year for Christmas Eve.',
      normalizedX: 0.76,
      normalizedY: 0.26,
      order: 2,
    ),
    VillageLocation(
      id: 'reindeer_stables',
      name: 'Magical Reindeer Stables',
      type: VillageLocationType.stables,
      description: 'Warm thatched stables for Rudolph and the flight team that pulls the magical sleigh.',
      details: 'Tended with sweet snow moss to keep the reindeer team energized and flight-ready.',
      normalizedX: 0.80,
      normalizedY: 0.64,
      order: 3,
    ),
    VillageLocation(
      id: 'grand_christmas_tree',
      name: 'Grand Christmas Tree',
      type: VillageLocationType.landmark,
      description: 'A towering ancient evergreen crowned with a brilliant golden star on top.',
      details: 'A beacon of hope, peace, and holiday love illuminating the entire Arctic realm.',
      normalizedX: 0.50,
      normalizedY: 0.28,
      order: 4,
    ),
    VillageLocation(
      id: 'polar_post_office',
      name: 'North Pole Post Office',
      type: VillageLocationType.postOffice,
      description: 'Where millions of dream-filled letters from children worldwide arrive and are sorted.',
      details: 'Every letter is stamped with an official North Pole red wax seal carrying warm blessings.',
      normalizedX: 0.20,
      normalizedY: 0.64,
      order: 5,
    ),
    VillageLocation(
      id: 'holiday_bakery',
      name: 'Gingerbread Bakery',
      type: VillageLocationType.bakery,
      description: 'Sweet aromas of cinnamon, gingerbread cookies, and hot cocoa wafting through snowy streets.',
      details: 'Where fairy bakers serve crispy warm gingerbread men and peppermint candy canes.',
      normalizedX: 0.34,
      normalizedY: 0.80,
      order: 6,
    ),
    VillageLocation(
      id: 'crystal_ice_lake',
      name: 'Crystal Ice Lake & Pine Forest',
      type: VillageLocationType.nature,
      description: 'A serene frozen lake shimmering like a crystal mirror amidst snow-dusted pine trees.',
      details: 'The favorite ice-skating destination every winter twilight for magical dances on ice.',
      normalizedX: 0.68,
      normalizedY: 0.82,
      order: 7,
    ),
  ];
}

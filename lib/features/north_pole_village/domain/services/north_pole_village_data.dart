import '../models/village_location.dart';
import '../models/village_location_type.dart';

class NorthPoleVillageData {
  const NorthPoleVillageData._();

  static const List<VillageLocation> defaultLocations = [
    VillageLocation(
      id: 'christmas_plaza',
      name: 'Quảng Trường Lễ Hội',
      type: VillageLocationType.plaza,
      description: 'Trung tâm tụ hội sôi động nhất của ngôi làng Bắc Cực với những lễ hội rộn ràng.',
      details: 'Nơi các chú lùn và tuần lộc tụ họp hát mừng Giáng Sinh dưới ánh đèn lấp lánh rực rỡ.',
      normalizedX: 0.50,
      normalizedY: 0.52,
      order: 0,
    ),
    VillageLocation(
      id: 'santa_house',
      name: 'Nhà Ông Già Noel',
      type: VillageLocationType.residence,
      description: 'Ngôi nhà gỗ ấm cúng với lò sưởi bập bùng và chiếc ghế bập bênh quen thuộc.',
      details: 'Nơi Ông Già Noel đọc những bức thư gửi về từ khắp thế giới và thưởng thức bánh quy thơm ngọt.',
      normalizedX: 0.24,
      normalizedY: 0.26,
      order: 1,
    ),
    VillageLocation(
      id: 'gift_workshop',
      name: 'Xưởng Quà Chú Lùn',
      type: VillageLocationType.workshop,
      description: 'Xưởng cơ khí và đồ chơi nhộn nhịp tiếng búa đập và tiếng cười của các chú lùn thợ thủ công.',
      details: 'Hàng triệu món quà đồ chơi độc đáo được chế tác tỉ mỉ suốt cả năm để chuẩn bị cho đêm Giáng Sinh.',
      normalizedX: 0.76,
      normalizedY: 0.26,
      order: 2,
    ),
    VillageLocation(
      id: 'reindeer_stables',
      name: 'Chuồng Tuần Lộc Diệu Kỳ',
      type: VillageLocationType.stables,
      description: 'Ngôi nhà mái rơm ấm áp của Rudolph và đội tuần lộc kéo cỗ xe bay qua các vì sao.',
      details: 'Được chăm sóc chu đáo với cỏ rêu tuyết ngọt ngào giúp đàn tuần lộc luôn tràn đầy năng lượng bay lượn.',
      normalizedX: 0.80,
      normalizedY: 0.64,
      order: 3,
    ),
    VillageLocation(
      id: 'grand_christmas_tree',
      name: 'Cây Thông Noel Khổng Lồ',
      type: VillageLocationType.landmark,
      description: 'Cây thông cổ thụ cao chọc trời được thắp sáng bởi ngôi sao vàng rực rỡ trên đỉnh ngọn.',
      details: 'Biểu tượng của niềm hy vọng, hòa bình và tình yêu thương mùa lễ hội chiếu sáng khắp vùng cực bắc.',
      normalizedX: 0.50,
      normalizedY: 0.28,
      order: 4,
    ),
    VillageLocation(
      id: 'polar_post_office',
      name: 'Bưu Điện Bắc Cực',
      type: VillageLocationType.postOffice,
      description: 'Nơi tiếp nhận và phân loại hàng triệu lá thư đầy ắp ước mơ từ trẻ em khắp địa cầu.',
      details: 'Mỗi lá thư đều được đóng dấu mộc sáp đỏ Bắc Cực và gửi lời chúc an lành tới từng gia đình.',
      normalizedX: 0.20,
      normalizedY: 0.64,
      order: 5,
    ),
    VillageLocation(
      id: 'holiday_bakery',
      name: 'Tiệm Bánh Gừng Giáng Sinh',
      type: VillageLocationType.bakery,
      description: 'Mùi thơm ngào ngạt của quế, bánh gừng hình người và sô-cô-la nóng lan tỏa khắp các con phố.',
      details: 'Nơi các bà tiên làm bánh phục vụ những chiếc bánh gừng giòn rụm và kẹo gậy bạc hà ngọt lịm.',
      normalizedX: 0.34,
      normalizedY: 0.80,
      order: 6,
    ),
    VillageLocation(
      id: 'crystal_ice_lake',
      name: 'Hồ Băng Pha Lê & Rừng Tuyết',
      type: VillageLocationType.nature,
      description: 'Mặt hồ đóng băng phẳng lặng trong veo lấp lánh như gương giữa cánh rừng thông tuyết.',
      details: 'Địa điểm trượt băng yêu thích vào mỗi buổi chiều hoàng hôn mùa đông với vũ điệu băng diệu kỳ.',
      normalizedX: 0.68,
      normalizedY: 0.82,
      order: 7,
    ),
  ];
}

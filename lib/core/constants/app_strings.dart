class AppStrings {
  const AppStrings._();

  // Core App
  static const String appName = 'Chrimastsatastracker';
  static const String festiveTagline = 'Ấm áp • Diệu kỳ • Tối giản';
  static const String holidayGreeting = 'Merry Christmas & Happy Holidays!';

  // Welcome Screen (Phase 1)
  static const String welcomeTitle = 'Chào đón mùa lễ hội Giáng Sinh';
  static const String welcomeSubtitle =
      'Đếm ngược, theo dõi hành trình kỳ diệu và tận hưởng khoảnh khắc ấm áp cùng gia đình.';
  static const String foundationStatusTitle = 'Nền tảng kỹ thuật Phase 1';
  static const String foundationStatusDesc =
      'Hệ thống Flutter đã sẵn sàng với kiến trúc phân tầng, không phụ thuộc bên ngoài và bảo vệ quyền riêng tư tuyệt đối.';
  static const String offlineFirstBadge = '100% Cục bộ & Offline';
  static const String privacyBadge = 'Bảo mật & Riêng tư';
  static const String enterHomeButton = 'Vào Trang Chủ';

  // Home Navigation (Phase 2)
  static const String homeTitle = 'Trang Chủ';
  static const String homeGreetingPrefix = 'Mùa lễ hội đang chờ đón bạn';
  static const String countdownPreviewTitle = 'Đếm Ngược Giáng Sinh';
  static const String countdownPreviewSubtitle =
      'Đếm chính xác từng khoảnh khắc đến 00:00:00 ngày 25/12';
  static const String openCountdownButton = 'Xem Đếm Ngược';
  static const String aboutAppButton = 'Giới thiệu & Nền tảng';

  // Coming Soon Section
  static const String comingSoonTitle = 'Tính Năng Đang Phát Triển';
  static const String comingSoonSubtitle =
      'Các phân hệ trong lộ trình tiếp theo của dự án';
  static const String comingSoonBadge = 'Sắp ra mắt';
  static const String trackerFeatureTitle = 'Santa Tracker';
  static const String trackerFeatureDesc =
      'Mô phỏng hành trình phát quà của ông già Noel vòng quanh thế giới.';
  static const String villageFeatureTitle = 'Ngôi Làng Bắc Cực';
  static const String villageFeatureDesc =
      'Khám phá xưởng đồ chơi của các chú lùn và chuồng tuần lộc.';
  static const String gamesFeatureTitle = 'Trò Chơi Giáng Sinh';
  static const String gamesFeatureDesc =
      'Các mini-game lễ hội nhẹ nhàng, mang tính giáo dục và giải trí.';
  static const String adventFeatureTitle = 'Lịch Advent';
  static const String adventFeatureDesc =
      'Mở 24 ô quà bất ngờ đếm ngược từng ngày trong tháng 12.';

  // Countdown Screen
  static const String countdownScreenTitle = 'Đếm Ngược Đến Giáng Sinh';
  static const String nextChristmasPrefix = 'Mục tiêu: Giáng Sinh 25/12/';
  static const String backToHomeButton = 'Quay lại Trang Chủ';
  static const String daysLabel = 'Ngày';
  static const String hoursLabel = 'Giờ';
  static const String minutesLabel = 'Phút';
  static const String secondsLabel = 'Giây';
  static const String christmasDayBadge = 'Hôm nay là Giáng Sinh!';

  // Dynamic Messages
  static const String messageChristmasDay =
      'Giáng Sinh an lành! Chúc bạn và gia đình một mùa lễ hội tràn ngập niềm vui và yêu thương!';
  static const String messageUnder24Hours =
      'Chỉ còn vài giờ nữa thôi! Thời khắc Giáng Sinh diệu kỳ sắp gõ cửa!';
  static const String messageOneToSevenDays =
      'Không khí lễ hội đã ngập tràn, cùng đếm ngược từng ngày đến Giáng Sinh!';
  static const String messageEightToThirtyDays =
      'Mùa lễ hội đang đến gần, hãy chuẩn bị đón Giáng Sinh ấm áp bên gia đình!';
  static const String messageOverThirtyDays =
      'Cùng mong chờ và đón chào một mùa Giáng Sinh an lành sắp đến!';

  // Santa Tracker (Phase 3)
  static const String santaTrackerScreenTitle = 'Santa Tracker';
  static const String simulationBadgeLabel = 'HÀNH TRÌNH MÔ PHỎNG';
  static const String simulationSubtitle =
      'Theo dõi lộ trình phát quà mô phỏng của Ông Già Noel qua 12 điểm dừng vòng quanh thế giới.';
  static const String openSantaTrackerButton = 'Mở Santa Tracker';
  static const String santaTrackerActiveBadge = 'Hoạt động';

  // Offline Banner
  static const String offlineSimulationBanner =
      'Bạn đang offline — hành trình mô phỏng vẫn hoạt động';

  // Journey Status Labels
  static const String statusNotStarted = 'Chưa bắt đầu';
  static const String statusInProgress = 'Đang di chuyển';
  static const String statusPaused = 'Đang tạm dừng';
  static const String statusCompleted = 'Đã hoàn thành';

  // Journey Info Labels
  static const String infoCardTitle = 'Thông Tin Hành Trình';
  static const String currentLocationLabel = 'Vị trí hiện tại';
  static const String nextDestinationLabel = 'Điểm đến tiếp theo';
  static const String journeyStatusLabel = 'Trạng thái hành trình';
  static const String giftsDeliveredLabel = 'Số quà đã giao (mô phỏng)';
  static const String simulatedEtaLabel = 'Thời gian đến dự kiến (ETA)';
  static const String routeProgressLabel = 'Tiến độ lộ trình';
  static const String etaMinutesSuffix = 'phút mô phỏng';
  static const String giftsUnitSuffix = 'món quà';

  // Manual Controls
  static const String controlPanelTitle = 'Điều Khiển Hành Trình';
  static const String startJourneyButton = 'Bắt đầu hành trình';
  static const String nextStopButton = 'Điểm dừng tiếp theo';
  static const String pauseJourneyButton = 'Tạm dừng';
  static const String resumeJourneyButton = 'Tiếp tục';
  static const String resetJourneyButton = 'Đặt lại hành trình';

  // Map & Legend
  static const String mapLegendCurrent = 'Vị trí Santa';
  static const String mapLegendCompleted = 'Đã đi qua';
  static const String mapLegendUpcoming = 'Chưa đến';
  static const String journeyCompletedBanner =
      'Ông già Noel đã hoàn thành hành trình phát quà mô phỏng vòng quanh thế giới!';
}

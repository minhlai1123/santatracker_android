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

  // North Pole Village (Phase 4)
  static const String villageScreenTitle = 'Ngôi Làng Bắc Cực';
  static const String villageSubtitle =
      'Khám phá các địa điểm diệu kỳ trong ngôi làng Giáng Sinh của Ông Già Noel.';
  static const String openVillageButton = 'Khám Phá Ngôi Làng';
  static const String villageActiveBadge = 'Hoạt động';
  static const String villageProgressLabel = 'Tiến độ khám phá';
  static const String villageLocationsCountSuffix = 'địa điểm';
  static const String villageCompletedTitle =
      'Làng Bắc Cực Đã Khám Phá Hoàn Tất!';
  static const String villageCompletedBanner =
      'Chúc mừng! Bạn đã khám phá toàn bộ 8 địa điểm diệu kỳ tại Ngôi Làng Bắc Cực!';
  static const String locationStatusDiscovered = 'Đã khám phá';
  static const String locationStatusUndiscovered = 'Chưa khám phá';
  static const String discoverLocationButton = 'Khám Phá Địa Điểm Này';
  static const String closeDetailSheetButton = 'Đóng chi tiết';
  static const String selectLocationHint =
      'Nhấn vào một địa điểm trên bản đồ làng để khám phá.';

  // Village Categories
  static const String categoryPlaza = 'Quảng trường';
  static const String categoryResidence = 'Nơi ở';
  static const String categoryWorkshop = 'Xưởng quà';
  static const String categoryStables = 'Chuồng tuần lộc';
  static const String categoryLandmark = 'Biểu tượng';
  static const String categoryPostOffice = 'Bưu điện';
  static const String categoryBakery = 'Tiệm bánh';
  static const String categoryNature = 'Thiên nhiên';

  // Mini Games (Phase 5)
  static const String miniGamesScreenTitle = 'Trò Chơi Giáng Sinh';
  static const String miniGamesSubtitle =
      'Hai trò chơi lễ hội vui nhộn, rèn luyện trí nhớ và phản xạ nhanh.';
  static const String openMiniGamesButton = 'Chơi Trò Chơi';
  static const String miniGamesActiveBadge = 'Hoạt động';
  static const String playGameButton = 'Bắt Đầu Chơi';
  static const String replayGameButton = 'Chơi Lại';
  static const String gameCompletedBadge = 'Đã hoàn thành';

  // Memory Match Game
  static const String memoryMatchTitle = 'Lật Thẻ Giáng Sinh';
  static const String memoryMatchDesc =
      'Lật thẻ và tìm 6 cặp biểu tượng Giáng sinh giống nhau.';
  static const String movesLabel = 'Lượt thử';
  static const String pairsFoundLabel = 'Cặp đã tìm';
  static const String bestMovesLabel = 'Kỷ lục ít lượt nhất';
  static const String completedCountLabel = 'Số lần thắng';
  static const String memoryMatchWinTitle = 'Tuyệt Vời! Bạn Đã Thắng!';
  static const String memoryMatchWinMessage =
      'Bạn đã tìm thấy tất cả các cặp thẻ Giáng Sinh!';

  // Catch the Gifts Game
  static const String catchGiftsTitle = 'Bắt Quà Giáng Sinh';
  static const String catchGiftsDesc =
      'Chạm nhanh vào những hộp quà xuất hiện trong 30 giây.';
  static const String scoreLabel = 'Điểm số';
  static const String highScoreLabel = 'Điểm cao nhất';
  static const String timeRemainingLabel = 'Thời gian';
  static const String totalGiftsLabel = 'Tổng quà đã bắt';
  static const String secondsSuffix = 'giây';
  static const String pointsSuffix = 'điểm';
  static const String catchGiftsGameOverTitle = 'Hết Giờ Rồi!';
  static const String catchGiftsGameOverMessage =
      'Bạn đã hoàn thành lượt chơi Bắt Quà Giáng Sinh!';
  static const String catchGiftsInstructions =
      'Chạm vào những hộp quà xuất hiện trên màn hình để ghi điểm!';

  // Advent Storybook (Phase 5)
  static const String adventScreenTitle = 'Cuốn Sách Advent 24 Ngày';
  static const String adventSubtitle =
      'Mở khóa 24 câu chuyện, điều ước và câu đố Giáng sinh diệu kỳ.';
  static const String openAdventButton = 'Đọc Cuốn Sách';
  static const String adventActiveBadge = 'Hoạt động';
  static const String adventChapterPrefix = 'Chương';
  static const String adventDayPrefix = 'Ngày';
  static const String adventUnlockedCountLabel = 'Đã mở khóa';
  static const String adventReadCountLabel = 'Đã đọc';
  static const String adventStatusLocked = 'Đang khóa';
  static const String adventStatusUnlocked = 'Sẵn sàng đọc';
  static const String adventStatusRead = 'Đã đọc';
  static const String readChapterButton = 'Đọc Chương Này';
  static const String markAsReadButton = 'Đã Đọc Xong';
  static const String backToStorybookButton = 'Quay Lại Cuốn Sách';
  static const String unlockConditionPrefix = 'Điều kiện mở khóa';
  static const String chapterLockedMessage =
      'Chương này đang bị khóa. Hãy hoàn thành nhiệm vụ để mở khóa!';
  static const String festiveMessageTitle = 'Lời Chúc Lễ Hội';
  static const String activityPromptTitle = 'Hoạt Động / Câu Đố Vui';
  static const String allChaptersUnlockedBanner =
      'Tuyệt vời! Bạn đã mở khóa toàn bộ 24 chương sách Advent!';
  static const String allChaptersReadBanner =
      'Chúc mừng! Bạn đã đọc trọn vẹn cuốn sách Advent 24 Ngày!';
}

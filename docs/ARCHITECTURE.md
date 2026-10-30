# CHRIMASTSATRASTRACKER — KIẾN TRÚC PHẦN MỀM (ARCHITECTURE SPECIFICATION)

Tài liệu này mô tả chi tiết kiến trúc phần mềm cho ứng dụng Flutter **Chrimastsatastracker**, bảo đảm tính tinh gọn, dễ mở rộng, dễ bảo trì, dễ kiểm thử và tuân thủ các nguyên tắc thiết kế hiện đại.

---

## 1. Triết lý kiến trúc (Architectural Principles)

1. **Feature-First kết hợp Clean Boundaries (Kiến trúc theo tính năng):**
   Mã nguồn được tổ chức theo từng nhóm tính năng độc lập (Feature-driven) thay vì gom toàn bộ theo loại tệp (Layer-driven). Điều này giúp cô lập phạm vi thay đổi, dễ dàng tìm kiếm và tái sử dụng mã.

2. **Phân tách trách nhiệm rõ ràng (Separation of Concerns):**
   - **Giao diện (Presentation):** Chỉ chịu trách nhiệm hiển thị và nhận tương tác từ người dùng.
   - **Nghiệp vụ (Domain/Business Logic):** Thuần Dart, không phụ thuộc vào widget của Flutter, dễ viết unit test.
   - **Dữ liệu (Data):** Xử lý lưu trữ cục bộ, tính toán thời gian và dữ liệu mô phỏng.

3. **Tối giản phụ thuộc (Minimal Dependencies / Pragmatic Architecture):**
   Không thêm các thư viện cồng kềnh, boilerplates phức tạp hoặc các framework nặng nề khi chưa có nhu cầu thực tế. Tận dụng tối đa các công cụ tích hợp sẵn của Flutter và Dart.

4. **Kiểm thử độc lập (Testability by Design):**
   Mỗi tầng, mỗi component và mỗi logic nghiệp vụ đều có thể được kiểm thử cô lập bằng Unit Test và Widget Test mà không cần chạy toàn bộ ứng dụng hay phụ thuộc vào hệ thống bên ngoài.

---

## 2. Cấu trúc thư mục chuẩn (Directory Structure)

Cấu trúc mã nguồn trong thư mục `lib/` được quy định như sau:

```
lib/
│
├── main.dart                      # Điểm khởi chạy ứng dụng (Application Entry Point)
│
├── app/                           # Cấu hình gốc và vòng đời ứng dụng
│   ├── app.dart                   # Widget MaterialApp gốc, quản lý router và theme
│   └── app_flavor.dart            # (Tùy chọn) Cấu hình môi trường nếu cần
│
├── core/                          # Các tài nguyên cốt lõi dùng chung toàn dự án
│   ├── constants/                 # Hằng số (chuỗi, kích thước, thời gian)
│   │   ├── app_strings.dart       # Chuỗi văn bản hiển thị
│   │   └── app_dimensions.dart    # Kích thước, khoảng cách (padding/margin/radius)
│   ├── theme/                     # Hệ thống giao diện, màu sắc, typography
│   │   ├── app_colors.dart        # Bảng màu Giáng Sinh chuẩn (đỏ, xanh, vàng, trắng)
│   │   ├── app_theme.dart         # Cấu hình ThemeData (Light/Dark)
│   │   └── app_typography.dart    # Kiểu chữ tiêu đề, phụ đề, nội dung
│   └── utils/                     # Tiện ích bổ trợ (DateTime, định dạng, validators)
│
├── shared/                        # Các thành phần giao diện và tiện ích tái sử dụng
│   └── widgets/                   # Các widget dùng chung giữa nhiều tính năng
│       ├── festive_background.dart # Nền trang trí mùa đông/Giáng Sinh tối giản
│       └── festive_button.dart    # Nút bấm thiết kế chuẩn theo phong cách Giáng Sinh
│
└── features/                      # Các module tính năng theo từng domain
    ├── welcome/                   # Màn hình khởi đầu & Giới thiệu nền tảng
    │   ├── presentation/
    │   │   ├── screens/
    │   │   │   └── welcome_screen.dart
    │   │   └── widgets/
    │   │       ├── welcome_header.dart
    │   │       └── festive_badge.dart
    │
    ├── home/                      # Trang chủ điều hướng trung tâm (Phase 2 & 3 & 4)
    │   └── presentation/
    │       ├── screens/
    │       │   └── home_screen.dart
    │       └── widgets/
    │           ├── home_header.dart
    │           ├── home_countdown_preview_card.dart
    │           ├── home_santa_tracker_card.dart
    │           ├── home_village_card.dart
    │           └── home_coming_soon_section.dart
    │
    ├── countdown/                 # Bộ đếm ngược Giáng Sinh (Phase 2)
    │   ├── domain/
    │   │   ├── models/
    │   │   │   ├── countdown_message_type.dart
    │   │   │   └── countdown_state.dart
    │   │   └── services/
    │   │       └── countdown_calculator.dart
    │   └── presentation/
    │       ├── screens/
    │       │   └── countdown_screen.dart
    │       └── widgets/
    │           ├── countdown_display.dart
    │           ├── countdown_time_unit.dart
    │           └── countdown_message_card.dart
    │
    ├── santa_tracker/             # Hành trình ông già Noel mô phỏng (Phase 3)
    │   ├── domain/
    │   │   ├── models/
    │   │   │   ├── santa_stop.dart
    │   │   │   ├── santa_journey_status.dart
    │   │   │   └── santa_tracker_state.dart
    │   │   └── services/
    │   │       ├── santa_route_data.dart
    │   │       └── network_status_provider.dart
    │   └── presentation/
    │       ├── controllers/
    │       │   └── santa_tracker_controller.dart
    │       ├── screens/
    │       │   └── santa_tracker_screen.dart
    │       └── widgets/
    │           ├── santa_world_map.dart
    │           ├── santa_marker.dart
    │           ├── santa_journey_info_card.dart
    │           ├── santa_control_panel.dart
    │           └── santa_offline_banner.dart
    │
    ├── north_pole_village/        # Khám phá ngôi làng Bắc Cực (Phase 4)
    │   ├── data/
    │   │   ├── village_storage.dart
    │   │   ├── shared_preferences_village_storage.dart
    │   │   └── memory_village_storage.dart
    │   ├── domain/
    │   │   ├── models/
    │   │   │   ├── village_location_type.dart
    │   │   │   ├── village_location.dart
    │   │   │   └── village_exploration_state.dart
    │   │   └── services/
    │   │       └── north_pole_village_data.dart
    │   └── presentation/
    │       ├── controllers/
    │       │   └── village_controller.dart
    │       ├── screens/
    │       │   └── north_pole_village_screen.dart
    │       └── widgets/
    │           ├── village_progress_header.dart
    │           ├── village_map.dart
    │           └── village_location_detail_sheet.dart
    │
    ├── mini_games/                # Trò chơi Giáng Sinh offline (Phase 5)
    │   ├── data/
    │   │   ├── mini_games_storage.dart
    │   │   ├── shared_preferences_mini_games_storage.dart
    │   │   └── memory_mini_games_storage.dart
    │   ├── domain/
    │   │   ├── models/
    │   │   │   ├── mini_game_type.dart
    │   │   │   ├── mini_game_record.dart
    │   │   │   ├── memory_card.dart
    │   │   │   ├── memory_match_state.dart
    │   │   │   ├── falling_gift.dart
    │   │   │   └── catch_gifts_state.dart
    │   │   └── services/
    │   │       ├── memory_match_engine.dart
    │   │       └── catch_gifts_engine.dart
    │   └── presentation/
    │       ├── controllers/
    │       │   ├── mini_games_controller.dart
    │       │   ├── memory_match_controller.dart
    │       │   └── catch_gifts_controller.dart
    │       ├── screens/
    │       │   ├── christmas_mini_games_screen.dart
    │       │   ├── memory_match_screen.dart
    │       │   └── catch_gifts_screen.dart
    │       └── widgets/
    │           ├── mini_game_hub_card.dart
    │           ├── memory_card_widget.dart
    │           └── catch_gift_target_widget.dart
    │
    └── advent_storybook/          # Cuốn sách Giáng Sinh 24 chương (Phase 5)
        ├── data/
        │   ├── advent_storage.dart
        │   ├── shared_preferences_advent_storage.dart
        │   └── memory_advent_storage.dart
        ├── domain/
        │   ├── models/
        │   │   ├── advent_chapter_status.dart
        │   │   ├── advent_chapter.dart
        │   │   └── advent_storybook_state.dart
        │   └── services/
        │       ├── advent_unlock_rules.dart
        │       └── advent_storybook_data.dart
        └── presentation/
            ├── controllers/
            │   └── advent_storybook_controller.dart
            ├── screens/
            │   ├── advent_storybook_screen.dart
            │   └── advent_chapter_reader_screen.dart
            └── widgets/
                ├── storybook_cover_header.dart
                └── storybook_chapter_card.dart
```

---

## 3. Vai trò chi tiết của từng thư mục

### 3.1. `lib/main.dart`
- Là điểm vào (entry point) duy nhất của ứng dụng.
- Khởi tạo Flutter engine (`WidgetsFlutterBinding.ensureInitialized()`).
- Khởi chạy widget gốc `ChrimastsatastrackerApp`.
- Không chứa logic nghiệp vụ, không chứa giao diện cụ thể.

### 3.2. `lib/app/`
- Chứa lớp `ChrimastsatastrackerApp` kế thừa từ `StatelessWidget`.
- Định cấu hình `MaterialApp`: cấu hình tiêu đề `Chrimastsatastracker`, cài đặt `ThemeData`, tắt banner debug, định tuyến màn hình chính (`HomeScreen`).
- Hỗ trợ truyền tùy chọn `clock` và `home` phục vụ kiểm thử cô lập.

### 3.3. `lib/core/`
- Chứa các định nghĩa nền tảng không thuộc riêng về một tính năng nào:
  - **`app_colors.dart`:** Khai báo bảng màu Giáng Sinh trang nhã:
    - Primary Red (`Color(0xFFC41E3A)` - Cardinal Christmas Red)
    - Forest Green (`Color(0xFF1B4D3E)` - Deep Pine Green)
    - Gold Accent (`Color(0xFFD4AF37)` - Festive Warm Gold)
    - Snow White / Soft Snow / Subtle Tints
  - **`app_strings.dart`:** Khai báo tập trung toàn bộ chuỗi ký tự, nhãn màn hình, thông điệp động theo thời gian, nhãn mô phỏng Santa Tracker, Ngôi Làng Bắc Cực, Trò Chơi Giáng Sinh và Advent Storybook.
  - **`app_theme.dart`:** Tích hợp `ThemeData` hoàn chỉnh sử dụng Material 3 (`useMaterial3: true`), áp dụng typography và colorScheme hài hòa.
  - **`app_dimensions.dart`:** Quy định các khoảng cách chuẩn (8, 16, 24, 32dp), bo góc chuẩn (8, 16, 24dp).

### 3.4. `lib/shared/`
- Chứa các widget thuần UI được dùng lại ở nhiều feature:
  - **`festive_button.dart`:** Nút bấm lễ hội chuẩn với hỗ trợ kiểu Primary, Secondary, Outlined, chiều cao chuẩn 50px, tự động co giãn `Flexible` chống tràn.

### 3.5. `lib/features/`
- Mỗi thư mục con là một đơn vị tính năng độc lập:
  - **`welcome/`:** Màn hình giới thiệu tầm nhìn dự án, nguyên tắc bảo mật và nút chuyển tiếp sang Trang Chủ.
  - **`home/`:** Màn hình trung tâm hiển thị preview đếm ngược thời gian thực, thẻ mở `SantaTrackerScreen` (`HomeSantaTrackerCard`), thẻ mở `NorthPoleVillageScreen` (`HomeVillageCard`), thẻ mở `ChristmasMiniGamesScreen` (`HomeMiniGamesCard`) và thẻ mở `AdventStorybookScreen` (`HomeAdventStorybookCard`). Tất cả 4 thẻ đều gắn huy hiệu "Hoạt động".
  - **`countdown/`:** Tầng domain thuần Dart (`CountdownCalculator`, `CountdownState`, `CountdownMessageType`) tính toán ngày/giờ/phút/giây và thông điệp động; tầng presentation hiển thị các block thời gian responsive và card chúc mừng lễ hội.
  - **`santa_tracker/`:**
    - **Domain Layer:** `SantaStop` (dữ liệu điểm dừng với tọa độ chuẩn hóa `0.0..1.0`), `SantaJourneyStatus` (4 trạng thái hành trình), `SantaTrackerState` (trạng thái bất biến tính toán quà từ `completedStopIds`), `SantaRouteData` (12 điểm dừng vòng quanh thế giới) và `NetworkStatusProvider` (trừu tượng hóa trạng thái offline/online có thể mock).
    - **Presentation Layer:** `SantaTrackerController` (`ChangeNotifier` điều khiển mô phỏng thủ công và lắng nghe vòng đời ứng dụng), `SantaWorldMap` (bản đồ minh họa vẽ bằng `CustomPainter`), `SantaMarker` (marker vị trí hiện tại có hiệu ứng pulse nhẹ tách biệt hoàn toàn khỏi logic hành trình), `SantaControlPanel`, `SantaJourneyInfoCard` và `SantaOfflineBanner`.
  - **`north_pole_village/`:**
    - **Data Layer:** `VillageStorage` (interface lưu trữ trạng thái), `SharedPreferencesVillageStorage` (adapter production sử dụng SharedPreferences), `MemoryVillageStorage` (adapter in-memory phục vụ unit/widget test).
    - **Domain Layer:** `VillageLocationType` (enum loại địa điểm), `VillageLocation` (entity địa điểm với tọa độ chuẩn hóa `0.0..1.0`), `VillageExplorationState` (trạng thái bất biến của tiến độ khám phá và địa điểm đang chọn), `NorthPoleVillageData` (dữ liệu cố định 8 địa điểm làng Bắc Cực).
    - **Presentation Layer:** `VillageController` (`ChangeNotifier` quản lý nạp/lưu trạng thái, chọn địa điểm, khám phá với tính lũy đẳng idempotency), `VillageMap` (bản đồ minh họa vẽ bằng `CustomPainter` kết hợp các Interactive Marker), `VillageLocationDetailSheet` (bottom sheet hiển thị chi tiết và nút khám phá), `VillageProgressHeader` (tiến độ khám phá và banner chúc mừng hoàn thành), `NorthPoleVillageScreen` (màn hình chính quản lý điều hướng và vòng đời controller).
  - **`mini_games/`:**
    - **Data Layer:** `MiniGamesStorage`, `SharedPreferencesMiniGamesStorage`, `MemoryMiniGamesStorage`.
    - **Domain Layer:** `MiniGameRecord` (thống kê số lần thắng, kỷ lục ít lượt nhất, điểm cao nhất, tổng quà), `MemoryMatchEngine` (engine thuần Dart quản lý 12 thẻ, lật, so khớp, đếm số lượt, phát hiện chiến thắng), `CatchGiftsEngine` (engine thuần Dart quản lý 30 giây đếm ngược, sinh hộp quà rơi trong khung an toàn `0.1..0.9`, phát hiện chạm trúng và game over chính xác ở 0s).
    - **Presentation Layer:** `MiniGamesController` (quản lý thống kê thành tích toàn cục), `MemoryMatchController` (controller cho game lật thẻ với độ trễ khóa lật tự động), `CatchGiftsController` (controller cho game bắt quà với `Timer.periodic`), `ChristmasMiniGamesScreen` (hub trung tâm), `MemoryMatchScreen`, `CatchGiftsScreen`.
  - **`advent_storybook/`:**
    - **Data Layer:** `AdventStorage`, `SharedPreferencesAdventStorage`, `MemoryAdventStorage`.
    - **Domain Layer:** `AdventChapter` (dữ liệu chương gồm ngày, tiêu đề, câu chuyện, danh ngôn, câu đố), `AdventStorybookState`, `AdventUnlockRules` (24 luật mở khóa minh bạch dựa trên thành tích 2 mini-games và số chương đã đọc), `AdventStorybookData` (24 chương Giáng Sinh độc bản đầy đủ).
    - **Presentation Layer:** `AdventStorybookController` (quản lý trạng thái mở khóa, đánh dấu đã đọc idempotent, kết nối với `MiniGamesController`), `AdventStorybookScreen` (bố cục sách với bìa sách, tiến độ kép và 24 thẻ chương), `AdventChapterReaderScreen` (trình đọc nội dung và đánh dấu đã đọc).

---

## 4. Chiến lược Quản lý Trạng thái (State Management Rationale)

### 4.1. Giải pháp được chọn
Sử dụng các công cụ có sẵn của Flutter Framework:
- **`ValueNotifier<T>`** và **`ChangeNotifier`** kết hợp với **`ValueListenableBuilder`** / **`ListenableBuilder`**.
- Với các widget nội bộ đơn giản: Sử dụng **`StatefulWidget`** cơ bản.

### 4.2. Lý do lựa chọn
1. **Zero External Dependency:** Không cần thêm bất kỳ thư viện bên ngoài nào (không cần `flutter_bloc`, `riverpod`, `provider`, `getx`). Điều này giúp dự án nhẹ nhất có thể, không rủi ro xung đột phiên bản, build tức thì.
2. **Hiệu năng cao:** `ValueNotifier` kích hoạt rebuild cục bộ chỉ tại widget con lắng nghe (granular rebuild), không gây rebuild toàn bộ cây widget.
3. **Phù hợp với đặc thù dự án:** Chrimastsatastracker là ứng dụng tập trung vào hiển thị, đếm ngược và mô phỏng offline nhẹ nhàng; trạng thái không quá phức tạp để cần đến hệ thống State Machine nhiều tầng.
4. **Dễ kiểm thử:** Các Controller dựa trên `ValueNotifier` hoàn toàn là Plain Dart Class, có thể kiểm thử đơn vị nhanh chóng bằng `flutter test` mà không cần setup phức tạp.
5. **Quy tắc quan trọng:** Tuyệt đối không phối hợp nhiều thư viện quản lý trạng thái khác nhau trong cùng một dự án.

---

## 5. Chiến lược Kiểm thử (Testing Strategy)

Hệ thống kiểm thử được chia thành 2 cấp độ chính:

1. **Unit Tests (`test/unit/`):**
   - Kiểm tra các hàm logic tính toán, utils, chuỗi hằng số và formatting.
   - Chạy độc lập, tốc độ mili-giây, không phụ thuộc vào Flutter UI engine.

2. **Widget Tests (`test/widget/`):**
   - Xác thực việc render màn hình và các component giao diện.
   - Kiểm tra tên ứng dụng hiển thị `Chrimastsatastracker`.
   - Kiểm tra thông điệp giới thiệu, màu sắc chủ đề và tính toàn vẹn bố cục (không lỗi tràn viền `overflow`).
   - Kiểm tra hành vi phản hồi của widget khi thay đổi kích thước màn hình.

---

## 6. Tiêu chuẩn mã nguồn và Quy tắc chất lượng (Code Quality Rules)

- **Sound Null Safety:** 100% mã nguồn tuân thủ null-safety, không sử dụng ép kiểu không an toàn (`!`) bừa bãi.
- **Lint Rules:** Áp dụng `flutter_lints` nghiêm ngặt, duy trì trạng thái 0 error, 0 warning khi chạy `flutter analyze`.
- **Formatting:** Mã nguồn định dạng chuẩn bằng `dart format --line-length 80` hoặc cấu hình mặc định.
- **Tính bảo mật:** Không lưu trữ mật khẩu, secret, cấu hình máy chủ cá nhân trong mã nguồn.
- **Không code thừa:** Không để lại mã mẫu demo bộ đếm `MyHomePage`, không chứa code thử nghiệm không sử dụng.

# BÁO CÁO HOÀN THÀNH PHASE 5 — CHRISTMAS MINI GAMES & ADVENT STORYBOOK
## DỰ ÁN: CHRIMASTSATASTRACKER

**Ngày hoàn thành:** 15/10/2026  
**Vai trò thực hiện:** Senior Flutter Developer, Software Architect & QA Engineer  
**Trạng thái nghiệm thu:** **PASS (ĐẠT 100% CÁC TIÊU CHÍ NGHIỆM THU)**

---

## 1. Kết quả kiểm tra môi trường và trạng thái ban đầu của workspace

- **Hệ điều hành:** Windows 11 (64-bit).
- **Flutter SDK:** Flutter 3.47.5 (Channel stable).
- **Dart SDK:** Dart 3.13.4.
- **Git Version:** Git 2.51.2.windows.1.
- **Trạng thái Git trước triển khai:**
  - Branch: `master`.
  - HEAD Commit: `c325d82` (`phase-4: implement North Pole Village feature with offline interactive map and local persistence`).
  - Remote: Không có bất kỳ remote nào được cấu hình; tuân thủ nghiêm ngặt nguyên tắc **Không kết nối hoặc thao tác với GitLab/Git remote**.
- **Kiểm tra hồi quy ban đầu:** 105/105 test cases từ Phase 1, Phase 2, Phase 3 và Phase 4 đều PASS.

---

## 2. Quyết định kiến trúc, cấu trúc thư mục và mô hình dữ liệu

Tuân thủ kiến trúc **Feature-First kết hợp Clean Boundaries**:
- Phân tách rõ rệt 3 tầng: **Data** (Lưu trữ SharedPreferences / In-Memory), **Domain** (Pure Dart Entities, Value Objects, Game Engines, Unlock Rules) và **Presentation** (Controllers kế thừa `ChangeNotifier`, Screens, Widgets minh họa lễ hội).
- **Quản lý trạng thái:** Tận dụng 100% Flutter native state management (`ChangeNotifier`, `AnimatedBuilder`, `ValueListenableBuilder`), không thêm thư viện bên ngoài (zero-dependency).
- **Offline-First:** Hoàn toàn độc lập mạng, không tải bất kỳ tài nguyên hay hình ảnh nào từ Internet, dữ liệu được khởi tạo và lưu trữ an toàn ngay trên thiết bị.

### Cấu trúc thư mục mới trong `lib/features/`:

```
lib/features/
├── mini_games/
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
└── advent_storybook/
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
        │   └── advent_storybook_screen.dart
        │   └── advent_chapter_reader_screen.dart
        └── widgets/
            ├── storybook_cover_header.dart
            └── storybook_chapter_card.dart
```

---

## 3. Triển khai chi tiết Mini Games

Đã triển khai chính xác **2 mini games offline**, đảm bảo trải nghiệm Giáng Sinh vui tươi, nhẹ nhàng và an toàn:

### 3.1. Game 1: Christmas Memory Match (Lật Thẻ Giáng Sinh)
- **Cơ chế chơi:** 12 thẻ (6 cặp biểu tượng Giáng Sinh đặc sắc: Cây thông Noel, Người tuyết, Hộp quà diệu kỳ, Chuông vàng ngân vang, Ngôi sao Bethlehem, Chiếc tất may mắn).
- **Engine thuần Dart (`MemoryMatchEngine`):**
  - Quản lý trạng thái các thẻ: `isFlipped`, `isMatched`.
  - Khóa thao tác lật khi đang so sánh 2 thẻ không khớp (`mismatchDelay: 900ms`) để tránh người dùng nhấn loạn xạ.
  - Tự động phát hiện khi tìm đủ 6 cặp thẻ, chuyển sang trạng thái chiến thắng và kích hoạt dialog chúc mừng lễ hội.
  - Hỗ trợ khởi động lại / xáo bài mới (`resetGame()`).
- **Thống kê lưu trữ:** Tự động ghi nhận số lần thắng (`memoryMatchCompletions`) và kỷ lục số lượt thử ít nhất (`memoryMatchBestMoves`).

### 3.2. Game 2: Catch the Gifts (Bắt Quà Giáng Sinh)
- **Cơ chế chơi:** Lượt chơi kéo dài chính xác 30 giây với đồng hồ đếm ngược từng giây.
- **Engine thuần Dart (`CatchGiftsEngine`):**
  - Sinh hộp quà rơi/xuất hiện ngẫu nhiên trong tọa độ an toàn (`0.1 <= x, y <= 0.9`).
  - Hỗ trợ tiêm `Random` và `Clock` để kiểm thử logic tất định 100%.
  - Chạm trúng hộp quà: cộng điểm thưởng (+10 hoặc +20 điểm tùy kích thước quà), tăng bộ đếm quà đã bắt và sinh quà mới ngay lập tức.
  - Chạm ra ngoài vùng quà (khoảng trống): không tính điểm.
  - Khi đồng hồ chạm mốc `0 giây`: trò chơi kết thúc ngay lập tức (`isGameOver = true`), dừng timer, hiển thị tổng kết và cập nhật điểm cao kỷ lục.
- **Thống kê lưu trữ:** Lưu điểm cao nhất (`catchGiftsHighScore`) và tổng số hộp quà đã bắt tích lũy (`catchGiftsTotalGifts`).

### 3.3. Hub trung tâm (`ChristmasMiniGamesScreen`)
- Hiển thị danh sách 2 trò chơi với huy hiệu hoạt động, tóm tắt luật chơi, nút "Bắt Đầu Chơi" và hiển thị các kỷ lục thành tích cá nhân được nạp từ bộ nhớ máy.

---

## 4. Triển khai chi tiết Advent Storybook

- **Bố cục dạng sách truyện (`AdventStorybookScreen`):**
  - Bìa sách lễ hội (`StorybookCoverHeader`) với tiêu đề, phụ đề, biểu tượng cuốn sách và thanh tiến độ kép:
    - *Chương đã mở khóa:* `unlockedCount / 24` kèm thanh tiến độ vàng ấm.
    - *Chương đã đọc:* `readCount / 24` kèm thanh tiến độ xanh thông.
    - Banner chúc mừng khi mở toàn bộ 24 chương hoặc đọc toàn bộ 24 chương.
  - Danh sách 24 thẻ chương dạng thẻ sách (`StorybookChapterCard`) với số ngày, tiêu đề, điều kiện mở khóa / tóm tắt và huy hiệu trạng thái:
    - **Khóa (`locked`):** Biểu tượng ổ khóa vàng, nền mờ, khi chạm vào hiển thị SnackBar hướng dẫn điều kiện mở khóa.
    - **Đã mở (`unlocked`):** Nền sáng, huy hiệu xanh thông "Đã mở", chạm vào mở trình đọc chương.
    - **Đã đọc (`read`):** Nền xanh thông nhạt, dấu checkmark "Đã đọc", có thể đọc lại bất cứ lúc nào mà không làm sai lệch số liệu.
- **Trình đọc chương (`AdventChapterReaderScreen`):**
  - Hiển thị tiêu đề chương, ngày Advent, biểu tượng minh họa.
  - Khung nội dung câu chuyện Giáng Sinh ấm áp (150 - 300 từ).
  - Khung danh ngôn lễ hội ý nghĩa (`Festive Quote`).
  - Khung gợi ý hoạt động hoặc câu đố vui gia đình (`Activity / Riddle`).
  - Nút quay lại và nút **"Đánh dấu đã đọc"** (idempotent, an toàn tuyệt đối khi đọc lại).
- **Cơ chế mở khóa minh bạch (`AdventUnlockRules`):**
  - Toàn bộ 24 chương đều mở được **100% offline** bằng các cột mốc trong ứng dụng (thắng Memory Match, đạt mốc điểm Catch the Gifts, tổng số quà bắt được, số chương đã đọc trước đó).
  - Không có bất kỳ cơ chế mua hàng (IAP) hay bắt buộc tải game ngoài nào.

---

## 5. Danh sách toàn bộ 24 chương Advent

Dữ liệu được quản lý tập trung tại `AdventStorybookData` gồm 24 chương độc bản, không trùng lặp:

1. **Ngày 1: Món Quà Khởi Đầu** (Mở sẵn mặc định) — Khởi đầu mùa Vọng đầy háo hức.
2. **Ngày 2: Bí Mật Xưởng Yêu Tinh** (Điều kiện: Thắng Lật Thẻ Giáng Sinh lần đầu).
3. **Ngày 3: Những Chú Tuần Lộc Tập Bay** (Điều kiện: Đạt ít nhất 20 điểm Bắt Quà Giáng Sinh).
4. **Ngày 4: Ngôi Sao Trên Đỉnh Cây Thông** (Điều kiện: Đọc xong Chương 1).
5. **Ngày 5: Tiếng Chuông Gió Bắc Cực** (Điều kiện: Bắt được tổng cộng 15 hộp quà).
6. **Ngày 6: Bức Thư Gửi Muộn** (Điều kiện: Thắng 2 lần Lật Thẻ Giáng Sinh).
7. **Ngày 7: Hương Vị Bánh Gừng Mẹ Làm** (Điều kiện: Đạt ít nhất 40 điểm Bắt Quà).
8. **Ngày 8: Cỗ Xe Trượt Tuyết Diệu Kỳ** (Điều kiện: Đọc xong ít nhất 3 chương).
9. **Ngày 9: Bản Đồ Ngôi Sao Dẫn Đường** (Điều kiện: Thắng Lật Thẻ với kỷ lục <= 16 lượt).
10. **Ngày 10: Chiếc Áo Choàng Đỏ Của Santa** (Điều kiện: Bắt được tổng cộng 35 hộp quà).
11. **Ngày 11: Điệu Múa Của Những Bông Tuyết** (Điều kiện: Thắng 3 lần Lật Thẻ Giáng Sinh).
12. **Ngày 12: Chiếc Đồng Hồ Cát Thời Gian** (Điều kiện: Đạt ít nhất 60 điểm Bắt Quà).
13. **Ngày 13: Đêm Đông Bên Lò Sưởi Ấm** (Điều kiện: Đọc xong ít nhất 6 chương).
14. **Ngày 14: Những Hộp Quà Bí Ẩn** (Điều kiện: Bắt được tổng cộng 60 hộp quà).
15. **Ngày 15: Chú Tuần Lộc Mũi Đỏ Rudolph** (Điều kiện: Thắng 4 lần Lật Thẻ Giáng Sinh).
16. **Ngày 16: Ngọn Đèn Hải Đăng Đêm Bão Tuyết** (Điều kiện: Đạt ít nhất 80 điểm Bắt Quà).
17. **Ngày 17: Khúc Hát Giáng Sinh Vang Xa** (Điều kiện: Đọc xong ít nhất 10 chương).
18. **Ngày 18: Lời Ước Nguyện Đêm Trăng Rằm** (Điều kiện: Thắng Lật Thẻ với kỷ lục <= 12 lượt).
19. **Ngày 19: Chiếc Túi Quà Không Đáy** (Điều kiện: Bắt được tổng cộng 90 hộp quà).
20. **Ngày 20: Chuyến Bay Thử Nghiệm Cuối Cùng** (Điều kiện: Thắng 5 lần Lật Thẻ Giáng Sinh).
21. **Ngày 21: Ánh Sáng Cực Quang Kỳ Ảo** (Điều kiện: Đạt ít nhất 100 điểm Bắt Quà).
22. **Ngày 22: Bữa Tiệc Bánh Ngọt Bắc Cực** (Điều kiện: Đọc xong ít nhất 15 chương).
23. **Ngày 23: Sự Chuẩn Bị Hoàn Hảo** (Điều kiện: Bắt được tổng cộng 120 hộp quà).
24. **Ngày 24: Đêm Giáng Sinh Diệu Kỳ** (Điều kiện: Thắng 6 lần Lật Thẻ, đạt >= 120 điểm Bắt Quà và đọc >= 18 chương).

---

## 6. Tích hợp HomeScreen

- Cập nhật `HomeScreen` tích hợp 2 widget thẻ hoạt động mới:
  - `HomeMiniGamesCard`: Biểu tượng tay cầm trò chơi, nhãn "Hoạt động", tóm tắt và nút "Chơi Trò Chơi" dẫn tới `ChristmasMiniGamesScreen`.
  - `HomeAdventStorybookCard`: Biểu tượng cuốn sách mở, nhãn "Hoạt động", tóm tắt và nút "Khám Phá Sách Truyện" dẫn tới `AdventStorybookScreen`.
- Toàn bộ 4 tính năng chính trên Trang Chủ (`Santa Tracker`, `Ngôi Làng Bắc Cực`, `Trò Chơi Giáng Sinh`, `Lịch Advent`) đều đã hoạt động chính thức và gắn nhãn "Hoạt động".
- Mục "Sắp ra mắt" chuyển sang trạng thái trống hoàn toàn không gây lỗi giao diện.

---

## 7. Kết quả kiểm thử tự động (Test Automation Results)

Toàn bộ **156 bài kiểm thử** (tăng thêm 51 bài kiểm thử mới so với Phase 4) đều chạy thành công tuyệt đối:

```
00:14 +156: All tests passed!
```

### Chi tiết các file kiểm thử:
1. `test/unit/constants_test.dart`: Kiểm tra chuỗi hằng số, kích thước, định dạng và màu sắc của Phase 5.
2. `test/unit/mini_games_domain_test.dart`: 11 test cases kiểm tra MemoryMatchEngine, CatchGiftsEngine, va chạm, tính điểm, game over ở 0s, MiniGamesController.
3. `test/unit/advent_storybook_domain_test.dart`: 17 test cases kiểm tra 24 chương độc bản, 24 luật mở khóa tất định, tính toán tỷ lệ %, idempotent khi đọc lại.
4. `test/unit/mini_games_persistence_test.dart`: Kiểm tra adapter SharedPreferences và Memory cho Mini Games, mô phỏng app restart bảo toàn kỷ lục.
5. `test/unit/advent_persistence_test.dart`: Kiểm tra adapter SharedPreferences và Memory cho Advent Storybook, mô phỏng app restart bảo toàn tiến độ mở khóa và số chương đã đọc.
6. `test/unit/countdown_calculator_test.dart`: Kiểm tra hồi quy tính toán đếm ngược.
7. `test/unit/santa_route_data_test.dart`: Kiểm tra hồi quy 12 điểm dừng Santa.
8. `test/unit/santa_tracker_controller_test.dart`: Kiểm tra hồi quy vòng đời mô phỏng Santa.
9. `test/unit/village_controller_test.dart`: Kiểm tra hồi quy lưu trữ tiến độ làng Bắc Cực.
10. `test/unit/north_pole_village_data_test.dart`: Kiểm tra hồi quy 8 địa điểm làng Bắc Cực.
11. `test/unit/village_persistence_test.dart`: Kiểm tra hồi quy SharedPreferences của Ngôi Làng Bắc Cực.
12. `test/widget/christmas_mini_games_screen_test.dart`: Widget test Hub, Memory Match, Catch the Gifts và kiểm tra responsive 3 màn hình chuẩn (360x640, 390x844, 768x1024) 0 lỗi overflow.
13. `test/widget/advent_storybook_screen_test.dart`: Widget test Storybook layout, SnackBar điều kiện khi nhấn chương khóa, đọc chương, đánh dấu đã đọc, responsive 3 màn hình (360x640, 390x844, 768x1024) 0 lỗi overflow.
14. `test/widget/home_screen_test.dart`: Widget test xác thực 4 card hoạt động, điều hướng đến Mini Games và Advent Storybook và quay lại Trang Chủ an toàn.
15. `test/widget/santa_tracker_screen_test.dart`: Kiểm tra hồi quy giao diện Santa Tracker và 4 card hoạt động.
16. `test/widget/santa_tracker_lifecycle_test.dart`: Kiểm tra hồi quy quản lý bộ nhớ và backgrounding của Santa Tracker.
17. `test/widget/north_pole_village_screen_test.dart`: Kiểm tra hồi quy Ngôi Làng Bắc Cực và 4 card hoạt động.
18. `test/widget/welcome_screen_test.dart`: Kiểm tra hồi quy WelcomeScreen.
19. `test/widget_test.dart`: Kiểm tra khởi động ứng dụng gốc.

---

## 8. Kết quả flutter analyze và dart format

- **`flutter analyze`:**
  ```
  Analyzing Chrimastsatastracker...
  No issues found! (ran in 4.5s)
  ```
  *Kết quả:* **0 errors, 0 warnings, 0 lints**.
- **`dart format --output=none --set-exit-if-changed lib test`:**
  ```
  Formatted 102 files (0 changed) in 0.58 seconds.
  ```
  *Kết quả:* **100% tệp mã nguồn và kiểm thử tuân thủ chuẩn định dạng Dart**.

---

## 9. Kết quả build thực tế

Chạy thành công lệnh build Android Debug APK:
- **Lệnh thực thi:** `flutter build apk --debug`
- **Thời gian hoàn thành:** 41.5 giây.
- **Tệp xuất xưởng:** `build\app\outputs\flutter-apk\app-debug.apk`
- **Kích thước APK:** 190,628,897 bytes (~181.8 MB).
- **Trạng thái:** Thành công không lỗi runtime hay biên dịch.

---

## 10. Thông tin Git commit cục bộ

- **Quy tắc tuân thủ:** 100% Local Git, không remote push, không fetch, không kết nối GitLab/GitHub.
- **Commit Message:** `phase-5: implement Christmas mini games and Advent storybook`
- **Các tệp được stage và commit:** Toàn bộ mã nguồn, tài liệu kiến trúc, tài liệu tổng quan và bộ test Phase 5.

---

## 11. Đánh giá tính toàn vẹn và hồi quy

- **Phase 1 (Nền tảng & WelcomeScreen):** Đảm bảo hoạt động bình thường, thông điệp và nhận diện thương hiệu nguyên vẹn.
- **Phase 2 (Countdown & Home Navigation):** Logic đếm ngược, chuyển năm sau, các mức thông điệp động duy trì chính xác 100%.
- **Phase 3 (Santa Tracker):** Bản đồ thế giới CustomPainter, 12 điểm dừng, điều khiển thủ công, offline banner và animation nhịp thở hoạt động mượt mà.
- **Phase 4 (North Pole Village):** Bản đồ làng CustomPainter, 8 địa điểm, lưu trữ SharedPreferences khám phá làng và tiến độ 100% được bảo toàn.
- **Phase 5 (Mini Games & Advent Storybook):** Tích hợp hoàn hảo, kết nối liên thông trạng thái giữa trò chơi và tiến độ mở sách mà không gây xung đột kiến trúc hay rò rỉ bộ nhớ.

---

## 12. Danh sách các tệp được tạo mới hoặc chỉnh sửa

### 12.1. Tệp tạo mới:
1. `lib/features/mini_games/domain/models/mini_game_type.dart`
2. `lib/features/mini_games/domain/models/mini_game_record.dart`
3. `lib/features/mini_games/domain/models/memory_card.dart`
4. `lib/features/mini_games/domain/models/memory_match_state.dart`
5. `lib/features/mini_games/domain/models/falling_gift.dart`
6. `lib/features/mini_games/domain/models/catch_gifts_state.dart`
7. `lib/features/mini_games/domain/services/memory_match_engine.dart`
8. `lib/features/mini_games/domain/services/catch_gifts_engine.dart`
9. `lib/features/mini_games/data/mini_games_storage.dart`
10. `lib/features/mini_games/data/shared_preferences_mini_games_storage.dart`
11. `lib/features/mini_games/data/memory_mini_games_storage.dart`
12. `lib/features/mini_games/presentation/controllers/mini_games_controller.dart`
13. `lib/features/mini_games/presentation/controllers/memory_match_controller.dart`
14. `lib/features/mini_games/presentation/controllers/catch_gifts_controller.dart`
15. `lib/features/mini_games/presentation/widgets/mini_game_hub_card.dart`
16. `lib/features/mini_games/presentation/widgets/memory_card_widget.dart`
17. `lib/features/mini_games/presentation/widgets/catch_gift_target_widget.dart`
18. `lib/features/mini_games/presentation/screens/christmas_mini_games_screen.dart`
19. `lib/features/mini_games/presentation/screens/memory_match_screen.dart`
20. `lib/features/mini_games/presentation/screens/catch_gifts_screen.dart`
21. `lib/features/advent_storybook/domain/models/advent_chapter_status.dart`
22. `lib/features/advent_storybook/domain/models/advent_chapter.dart`
23. `lib/features/advent_storybook/domain/models/advent_storybook_state.dart`
24. `lib/features/advent_storybook/domain/services/advent_unlock_rules.dart`
25. `lib/features/advent_storybook/domain/services/advent_storybook_data.dart`
26. `lib/features/advent_storybook/data/advent_storage.dart`
27. `lib/features/advent_storybook/data/shared_preferences_advent_storage.dart`
28. `lib/features/advent_storybook/data/memory_advent_storage.dart`
29. `lib/features/advent_storybook/presentation/controllers/advent_storybook_controller.dart`
30. `lib/features/advent_storybook/presentation/widgets/storybook_cover_header.dart`
31. `lib/features/advent_storybook/presentation/widgets/storybook_chapter_card.dart`
32. `lib/features/advent_storybook/presentation/screens/advent_chapter_reader_screen.dart`
33. `lib/features/advent_storybook/presentation/screens/advent_storybook_screen.dart`
34. `lib/features/home/presentation/widgets/home_mini_games_card.dart`
35. `lib/features/home/presentation/widgets/home_advent_storybook_card.dart`
36. `test/unit/mini_games_domain_test.dart`
37. `test/unit/advent_storybook_domain_test.dart`
38. `test/unit/mini_games_persistence_test.dart`
39. `test/unit/advent_persistence_test.dart`
40. `test/widget/christmas_mini_games_screen_test.dart`
41. `test/widget/advent_storybook_screen_test.dart`
42. `PHASE_5_COMPLETION_REPORT.md`

### 12.2. Tệp chỉnh sửa:
1. `lib/core/constants/app_strings.dart` (Bổ sung chuỗi hằng số cho Mini Games và Advent Storybook).
2. `lib/features/home/presentation/screens/home_screen.dart` (Tích hợp 2 card hoạt động mới và điều hướng).
3. `docs/PROJECT_OVERVIEW.md` (Cập nhật tiến độ Phase 3, Phase 5 và lộ trình Phase 6).
4. `docs/ARCHITECTURE.md` (Cập nhật kiến trúc phân hệ Mini Games và Advent Storybook).
5. `test/unit/constants_test.dart` (Kiểm thử các chuỗi hằng số mới).
6. `test/widget/home_screen_test.dart` (Kiểm thử 4 card hoạt động và điều hướng Phase 5).
7. `test/widget/santa_tracker_screen_test.dart` (Cập nhật assertion 4 card hoạt động).
8. `test/widget/north_pole_village_screen_test.dart` (Cập nhật assertion 4 card hoạt động).

---

## 13. Khuyến nghị và các bước tiếp theo

1. Toàn bộ 5 nhóm tính năng người dùng cam kết trong tài liệu thiết kế ban đầu (`Welcome`, `Countdown`, `Santa Tracker`, `North Pole Village`, `Mini Games & Advent Storybook`) hiện đã hoàn thành trọn vẹn và hoạt động 100% offline.
2. Bước sang **Phase 6: Polish, QA Testing & Release Readiness**, dự án nên tập trung vào:
   - Tinh chỉnh hiệu ứng mượt mà trên thiết bị cấu hình thấp.
   - Thêm hiệu ứng âm thanh lễ hội tùy chọn (nhạc nền Giáng Sinh, tiếng chuông leng keng khi tìm đúng cặp thẻ hoặc bắt được quà) với nút bật/tắt âm thanh trong cài đặt.
   - Kiểm tra đa ngôn ngữ nếu cần mở rộng thị trường quốc tế.
   - Chuẩn bị metadata và build release APK/AAB cho Google Play Store và IPA cho Apple App Store.

---

## 14. Kết luận nghiệm thu Phase 5

Tính năng **Christmas Mini Games & Advent Storybook** đã được triển khai hoàn chỉnh, chuẩn mực theo các tiêu chuẩn kỹ thuật cao nhất của Flutter, sạch đẹp về mặt kiến trúc, vượt qua 100% các bài kiểm thử tự động và sẵn sàng nghiệm thu bàn giao.

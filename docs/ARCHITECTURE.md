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
    ├── welcome/                   # Màn hình khởi đầu (Trọng tâm của Phase 1)
    │   ├── presentation/
    │   │   ├── screens/
    │   │   │   └── welcome_screen.dart
    │   │   └── widgets/
    │   │       ├── welcome_header.dart
    │   │       └── festive_badge.dart
    │   └── domain/                # (Dành cho logic feature khi cần)
    │
    │   # [Các module dành cho Phase tiếp theo]
    ├── countdown/                 # Phase 2: Đếm ngược Giáng Sinh
    ├── santa_tracker/             # Phase 3: Mô phỏng hành trình ông già Noel
    ├── north_pole_village/        # Phase 3: Khám phá ngôi làng Bắc Cực
    ├── mini_games/                # Phase 4: Các trò chơi nhỏ
    └── advent_calendar/           # Phase 4: Lịch mở quà 24 ngày
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
- Định cấu hình `MaterialApp`: cấu hình tiêu đề `Chrimastsatastracker`, cài đặt `ThemeData`, tắt banner debug, định tuyến màn hình khởi đầu (`WelcomeScreen`).
- Giữ cấu hình ứng dụng tập trung và tách biệt với `main.dart`.

### 3.3. `lib/core/`
- Chứa các định nghĩa nền tảng không thuộc riêng về một tính năng nào:
  - **`app_colors.dart`:** Khai báo bảng màu Giáng Sinh trang nhã:
    - Primary Red (`Color(0xFFC41E3A)` - Cardinal Christmas Red)
    - Forest Green (`Color(0xFF1B4D3E)` - Deep Pine Green)
    - Gold Accent (`Color(0xFFD4AF37)` - Festive Warm Gold)
    - Snow White / Background Snow (`Color(0xFFF9FBFD)` / `Color(0xFF0F172A)`)
  - **`app_strings.dart`:** Khai báo tập trung toàn bộ chuỗi ký tự, hạn chế việc hardcode chuỗi trong widget, sẵn sàng cho việc đa ngôn ngữ trong tương lai.
  - **`app_theme.dart`:** Tích hợp `ThemeData` hoàn chỉnh sử dụng Material 3 (`useMaterial3: true`), áp dụng typography và colorScheme hài hòa.
  - **`app_dimensions.dart`:** Quy định các khoảng cách chuẩn (8, 16, 24, 32dp), bo góc chuẩn (12, 16, 24dp) nhằm đảm bảo giao diện nhất quán.

### 3.4. `lib/shared/`
- Chứa các widget thuần UI được dùng lại ở nhiều feature khác nhau (ví dụ: nền Giáng Sinh với hiệu ứng tinh tế, nút bấm chuẩn phong cách lễ hội, thẻ hiển thị thẻ bài).
- Không phụ thuộc vào logic của bất kỳ feature cụ thể nào.

### 3.5. `lib/features/`
- Mỗi thư mục con là một đơn vị tính năng độc lập.
- Trong **Phase 1**, chỉ triển khai thư mục `features/welcome/` bao gồm màn hình chào mừng tối giản và các widget con hiển thị thông tin giới thiệu.
- Các module `countdown/`, `santa_tracker/`, `north_pole_village/`, `mini_games/`, `advent_calendar/` được quy hoạch cấu trúc nhưng **chưa triển khai mã trong Phase 1** để tuân thủ phạm vi.

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

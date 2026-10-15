# CHRIMASTSATRASTRACKER — TỔNG QUAN DỰ ÁN (PROJECT OVERVIEW)

Tài liệu này xác định tầm nhìn, mục tiêu, phạm vi và các định hướng kỹ thuật chính thức cho dự án **Chrimastsatastracker**.

---

## 1. Tên dự án và Định danh

- **Tên dự án chính thức:** `Chrimastsatastracker`
- **Tên hiển thị ứng dụng (Android & iOS):** `Chrimastsatastracker`
- **Tên gói kỹ thuật (Dart / Flutter package):** `chrimastsatastracker`
- **Android Application ID / Namespace:** `com.example.chrimastsatastracker`
- **iOS Bundle Identifier:** `com.example.chrimastsatastracker`

---

## 2. Mục tiêu sản phẩm

Chrimastsatastracker là ứng dụng di động mang chủ đề Giáng Sinh, hướng đến việc tạo ra một không gian ấm cúng, vui tươi, lành mạnh và thư giãn cho người dùng, gia đình và trẻ nhỏ trong mùa lễ hội cuối năm.

Sản phẩm tập trung vào:
- Mang lại trải nghiệm đón chờ Giáng Sinh thông qua tính năng đếm ngược trực quan.
- Mô phỏng hành trình phát quà kỳ diệu của ông già Noel (Santa Claus) vòng quanh thế giới theo phong cách hoạt hình thân thiện.
- Cung cấp các hoạt động tương tác nhẹ nhàng (khám phá ngôi làng Bắc Cực, mở quà lịch Advent, các trò chơi nhỏ mang tính giáo dục và giải trí).
- Đảm bảo trải nghiệm mượt mà, không quảng cáo, không theo dõi người dùng, an toàn tuyệt đối cho trẻ em.

---

## 3. Nền tảng hỗ trợ

- **Android:** Hỗ trợ các phiên bản Android phổ biến (API level 21+).
- **iOS:** Hỗ trợ các thiết bị iPhone/iPad chạy iOS hiện đại (iOS 12+).
- **Mục tiêu phát triển:** Sử dụng chung một codebase Flutter duy nhất cho cả Android và iOS, đảm bảo giao diện và hành vi nhất quán trên mọi kích thước màn hình điện thoại và máy tính bảng phổ biến, hạn chế tối đa việc phải bảo trì hai nhánh mã nguồn riêng biệt.

---

## 4. Công nghệ chủ đạo

- **Framework:** Flutter (kênh Stable).
- **Ngôn ngữ:** Dart (với Sound Null Safety nghiêm ngặt).
- **Quản lý phiên bản:** Git cục bộ (Local Git). Phase 1 tuyệt đối không kết nối và không thực hiện thao tác từ xa với GitLab/GitHub.

---

## 5. Phong cách thiết kế (Design Philosophy)

Ứng dụng tuân thủ ngôn ngữ thiết kế: **Tối giản (Minimalist) — Hiện đại (Modern) — Thân thiện (Friendly) — Đậm chất Giáng Sinh (Festive Vibe)**:
- **Giao diện sạch sẽ:** Không nhồi nhét chi tiết, bố cục thoáng đãng, phân cấp thị giác rõ ràng.
- **Bảng màu Giáng Sinh hài hòa:** 
  - Màu chủ đạo: Đỏ thông Noel trầm ấm (Festive Red / Burgundy), Xanh lá cây thông (Pine Forest Green).
  - Màu phụ trợ: Trắng tuyết (Snow White), Vàng kim ấm áp (Warm Gold), Xanh đêm đông (Winter Night Navy).
- **Hiệu ứng vừa phải:** Animation tinh tế, chuyển cảnh mượt mà, không lạm dụng hạt tuyết rơi hoặc hiệu ứng vật lý phức tạp gây nóng máy hoặc hao pin.
- **Thích ứng màn hình:** Thiết kế responsive, tự động co giãn và căn chỉnh vừa vặn trên các kích cỡ màn hình từ điện thoại nhỏ đến màn hình kích thước lớn.
- **Ưu tiên trải nghiệm thực tế:** Dễ tiếp cận với mọi lứa tuổi, kể cả trẻ em và người lớn tuổi.

---

## 6. Mô tả năm nhóm chức năng tổng thể

Hệ thống được thiết kế hướng tới 5 nhóm chức năng chính (triển khai theo lộ trình nhiều Phase):

1. **Countdown (Đếm ngược đến Giáng Sinh):**
   - Đếm ngược chính xác theo ngày, giờ, phút, giây đến đêm Giáng Sinh (24/12) và ngày Giáng Sinh (25/12).
   - Tùy biến múi giờ địa phương của thiết bị.
   - Trực quan hóa tiến độ bằng đồ họa đơn giản, ấm cúng.

2. **Santa Tracker (Mô phỏng hành trình ông già Noel):**
   - Bản đồ mô phỏng lộ trình xe tuần lộc của Santa đi phát quà quanh các thành phố trên toàn cầu vào đêm 24/12.
   - Cung cấp thông tin vui nhộn mô phỏng: số lượng quà đã phát, điểm dừng tiếp theo, khoảng cách ước tính.
   - Lưu ý: Toàn bộ là mô phỏng viễn tưởng lễ hội (Fictional Simulation), không dùng vị trí GPS thật.

3. **North Pole Village (Ngôi làng Bắc Cực):**
   - Không gian tương tác trực quan mô tả xưởng đồ chơi của các chú lùn (Elves workshop), chuồng tuần lộc (Reindeer stables), bưu điện Bắc Cực tiếp nhận thư gửi ông già Noel.
   - Âm thanh và hoạt họa vi mô (micro-interactions) mang lại sự sinh động.

4. **Mini Games (Trò chơi nhỏ Giáng Sinh):**
   - Tập hợp các trò chơi giải đố, trí nhớ (Memory Match), hứng quà tuyết rơi (Gift Catch) đơn giản, nhẹ nhàng.
   - Không chứa yếu tố bạo lực, không có cơ chế gây nghiện hoặc nạp tiền.

5. **Advent Calendar (Lịch mở quà theo ngày):**
   - 24 ô cửa đếm ngược từ ngày 1 đến ngày 24 tháng 12.
   - Mỗi ngày người dùng có thể mở 1 ô cửa để nhận thông điệp chúc phúc, hình dán (sticker) kỹ thuật số, câu đố Giáng Sinh hoặc mẩu chuyện nhỏ.

---

## 7. Các chức năng bị loại trừ (Out of Scope)

Dự án kiên quyết **KHÔNG** triển khai các tính năng sau:
- **Widget màn hình chính (Home screen widgets):** Tránh phức tạp hóa native code và hao pin nền.
- **Quảng cáo (Advertisements):** Tuyệt đối không tích hợp Google AdMob hoặc bất kỳ SDK quảng cáo nào để bảo vệ trải nghiệm của trẻ em và người dùng.
- **Mua hàng trong ứng dụng (In-App Purchases / IAP):** Toàn bộ nội dung là miễn phí, không có paywall hoặc cơ chế microtransactions.
- **Đăng ký / Đăng nhập tài khoản:** Không yêu cầu email, số điện thoại, mạng xã hội; mở app là sử dụng ngay.
- **Backend hoặc máy chủ riêng không cần thiết:** Ứng dụng vận hành theo kiến trúc offline-first, tự tính toán cục bộ mà không phụ thuộc hạ tầng server tốn kém.
- **Theo dõi vị trí thật của người dùng:** Không xin quyền GPS/Location; bảo vệ quyền riêng tư tuyệt đối.
- **Không sao chép nguyên bản:** Không vi phạm bản quyền hình ảnh, âm thanh, icon hoặc mã nguồn của Google Santa Tracker, NORAD Tracks Santa hay bất kỳ bên thứ ba nào.

---

## 8. Định hướng ưu tiên hoạt động cục bộ và Offline (Offline-First)

- Toàn bộ thuật toán đếm ngược, mô phỏng lộ trình Santa, dữ liệu làng Bắc Cực và nội dung 24 ngày Advent Calendar được đóng gói và tính toán trực tiếp trên thiết bị (Local Device Computation).
- Người dùng có thể sử dụng đầy đủ các tính năng kể cả khi đi máy bay, ở vùng không có sóng hoặc tắt dữ liệu di động.
- Dữ liệu trạng thái (điểm trò chơi, các ô lịch đã mở) được lưu trữ an toàn trong bộ nhớ cục bộ (Local Storage).

---

## 9. Nguyên tắc bảo mật và Quyền riêng tư (Security & Privacy)

- **Zero Data Collection:** Không thu thập, không phân tích hành vi, không gửi telemetry cá nhân về máy chủ.
- **Quyền hạn tối thiểu (Least Privilege):** Ứng dụng không yêu cầu bất kỳ quyền truy cập nhạy cảm nào trong manifest (không Camera, không Micro, không Danh bạ, không Vị trí, không Bộ nhớ ngoài).
- **An toàn cho trẻ em (COPPA / GDPR-K compliant by design):** Thiết kế an toàn mặc định cho môi trường gia đình.
- **Bảo mật mã nguồn:** Không lưu trữ secret, token, API keys trong codebase.

---

## 10. Yêu cầu cơ bản về hiệu năng (Performance Requirements)

- **Tốc độ khung hình:** Duy trì ổn định 60 FPS (hoặc 120 FPS trên màn hình ProMotion/High-refresh rate) trên các tác vụ UI thông thường.
- **Khởi động ứng dụng (Cold Start):** Thời gian hiển thị màn hình đầu tiên dưới 1.5 giây trên thiết bị tầm trung.
- **Dung lượng cài đặt:** Tối ưu hóa kích thước build APK/IPA gọn nhẹ, không chèn tài nguyên âm thanh/hình ảnh thừa.
- **Mức tiêu hao tài nguyên:** Tối ưu hóa render tree, không kích hoạt rebuild liên tục, không gây hiện tượng quá nhiệt hay tụt pin nhanh.

---

## 11. Trạng thái thực hiện các Phase

### 11.1. Phase 1 — Khởi tạo nền tảng dự án (Đã hoàn thành - PASS)
- Thiết lập workspace Flutter chuẩn, Android/iOS configurations, kiểm thử ban đầu, Git cục bộ commit `6cbe8d2`.
- Hoàn thành `WelcomeScreen` và bộ tài liệu khởi tạo.

### 11.2. Phase 2 — Countdown & Home Navigation (Đã hoàn thành - PASS)
- **Home Navigation:** Triển khai `HomeScreen` làm trung tâm ứng dụng, kết nối điều hướng mượt mà đến `CountdownScreen` và `WelcomeScreen`.
- **Countdown Engine:** Logic tính toán thời gian thực theo giờ địa phương, tự động xác định mốc 25/12 tiếp theo, xử lý năm nhuận, không trễ giờ và xử lý mốc 00:00:00 ngày 25/12 chuyển chu kỳ năm sau.
- **Hệ thống thông điệp:** 5 cấp độ thông điệp động theo thời gian còn lại kết hợp độc lập với trạng thái chúc mừng ngày lễ 25/12.
- **Khu vực Sắp ra mắt:** Giới thiệu rõ ràng 4 tính năng tương lai (Santa Tracker, North Pole Village, Mini Games, Advent Calendar) dưới dạng thẻ thông tin, không tạo nút giả hay màn hình giả.
- **Bảo toàn nền tảng:** Không thêm dependency ngoài, zero-tracking, responsive trên mobile và tablet, 42/42 tests PASS, Android debug APK build thành công.

### 11.3. Phase 3 — Santa Tracker (Đã hoàn thành - PASS)
- **Bản đồ thế giới minh họa riêng (`SantaMap`):** Xây dựng 100% bằng Flutter `CustomPainter`, vẽ lục địa cách điệu, đường bay vòng quanh thế giới, các điểm dừng và vị trí Santa hiện tại theo tọa độ chuẩn hóa (`0.0..1.0`), hoàn toàn offline và không phụ thuộc API bên ngoài.
- **Mô phỏng hành trình phát quà (`SantaJourneyEngine`):** Quản lý trạng thái hành trình gồm 12 điểm dừng toàn cầu, tính toán số quà đã phát, vận tốc, điểm dừng tiếp theo và thời gian dự kiến (ETA). Hỗ trợ điều khiển thủ công (Bắt đầu, Tạm dừng, Tiếp tục, Điểm tiếp theo, Chơi lại).
- **Trải nghiệm mượt mà:** Animation nhịp thở dịu nhẹ cho điểm dừng và vị trí Santa, banner trạng thái mạng giả lập (Mock Network) minh chứng khả năng hoạt động offline 100%.

### 11.4. Phase 4 — North Pole Village (Đã hoàn thành - PASS)
- **Bản đồ Ngôi Làng Bắc Cực minh họa riêng (`VillageMap`):** Xây dựng 100% bằng Flutter `CustomPainter`, `LayoutBuilder`, `Stack` và `Positioned` theo hệ tọa độ chuẩn hóa (`0.0..1.0`), không sử dụng API bản đồ ngoài, tile server hay web view.
- **8 địa điểm tương tác phong phú (`NorthPoleVillageData`):** Quảng Trường Bắc Cực, Nhà Ông Già Noel, Xưởng Đồ Chơi Yêu Tinh, Chuồng Tuần Lộc Diệu Kỳ, Cây Thông Lễ Hội Khổng Lồ, Bưu Điện Bắc Cực, Tiệm Bánh Gừng & Kẹo Ngọt, và Hồ Băng Pha Lê.
- **Lưu trữ trạng thái cục bộ lâu dài (`VillageStorage` & `SharedPreferencesVillageStorage`):** Sử dụng `shared_preferences: ^2.5.6` được bọc qua interface trừu tượng `VillageStorage`, đảm bảo tiến độ khám phá được lưu an toàn trên thiết bị và duy trì nguyên vẹn khi khởi động lại ứng dụng. Có sẵn `MemoryVillageStorage` cho Unit/Widget Test.
- **Trải nghiệm khám phá tương tác:** Nhấn marker mở chi tiết địa điểm (`VillageLocationDetailSheet`), hỗ trợ đánh dấu đã khám phá với hiệu ứng hào quang động, thanh tiến độ và thông báo chúc mừng khi hoàn thành tất cả 8 địa điểm (`VillageProgressHeader`).
- **Tích hợp Home Navigation:** Chuyển Ngôi Làng Bắc Cực trên `HomeScreen` thành thẻ tính năng hoạt động (`HomeVillageCard`).

### 11.5. Phase 5 — Christmas Mini Games & Advent Storybook (Đã hoàn thành - PASS)
- **Christmas Mini Games (2 trò chơi offline hoàn chỉnh):**
  - *Christmas Memory Match:* Trò chơi lật thẻ tìm 6 cặp biểu tượng Giáng Sinh (12 thẻ), đếm số lượt thử, phát hiện ghép đúng/lệch kèm khóa thao tác chống lật ồ ạt, tự động lưu số lần thắng và kỷ lục ít lượt nhất.
  - *Catch the Gifts:* Trò chơi phản xạ hứng quà 30 giây với bộ đếm ngược chính xác, hộp quà rơi ngẫu nhiên trong khung an toàn, điểm thưởng cộng dồn khi chạm trúng, kết thúc lượt đúng mốc 0 giây và lưu điểm cao kỷ lục.
  - *Mini Games Hub & Storage:* Màn hình trung tâm hiển thị thành tích tổng hợp và điều hướng; lưu trữ lâu dài qua `MiniGamesStorage` và `SharedPreferencesMiniGamesStorage`.
- **Advent Storybook (Cuốn sách Giáng Sinh 24 chương):**
  - *Bố cục sách truyện phong cách lễ hội:* Bìa sách, thanh tiến độ kép (Số chương mở khóa và Số chương đã đọc), 24 thẻ chương với trạng thái rõ ràng (Khóa, Mở, Đã đọc).
  - *Trình đọc chương tương tác (`AdventChapterReaderScreen`):* Tiêu đề, câu chuyện Giáng Sinh ấm áp, câu danh ngôn lễ hội, gợi ý hoạt động/câu đố và nút đánh dấu đã đọc (idempotent).
  - *Cơ chế mở khóa minh bạch (`AdventUnlockRules`):* Chương 1 mở sẵn; các chương 2-24 mở khóa tuần tự dựa trên thành tích 2 mini-games và tiến độ đọc. Toàn bộ 24 chương đều mở được 100% offline mà không cần mua hàng hay game thứ ba.
  - *Lưu trữ tiến độ:* Sử dụng `AdventStorage` và `SharedPreferencesAdventStorage`.
- **Tích hợp toàn diện trên HomeScreen:** Cả 4 thẻ tính năng (`Santa Tracker`, `Ngôi Làng Bắc Cực`, `Trò Chơi Giáng Sinh`, `Lịch Advent`) đều hiển thị huy hiệu "Hoạt động". Toàn bộ 156 bài kiểm thử tự động đạt 100% PASS, 0 issue analyze, 100% chuẩn format.

---

## 12. Định hướng phát triển các Phase tiếp theo

- **Phase 6 — Polish, QA Testing & Release Readiness:** Tối ưu hóa hiệu năng toàn diện, kiểm thử hồi quy trên các thiết bị thực tế, tích hợp âm thanh lễ hội nhẹ nhàng tùy chọn, kiểm toán bảo mật và chuẩn bị bundle đóng gói phát hành.

---

## 13. Những quyết định kỹ thuật đã chốt & chưa xác định (TBD)

1. **Công nghệ hiển thị bản đồ cho Santa Tracker (Đã chốt ở Phase 3):** Sử dụng `CustomPainter` / Canvas vẽ bản đồ thế giới minh họa kết hợp tọa độ chuẩn hóa (`0.0..1.0`), hoạt động 100% offline, siêu nhẹ và không phụ thuộc dịch vụ bản đồ bên ngoài.
2. **Cơ chế lưu trữ dữ liệu cục bộ (Đã chốt ở Phase 4 & Phase 5):** Sử dụng `shared_preferences` bọc qua Clean Interface (`VillageStorage`, `MiniGamesStorage`, `AdventStorage`), hỗ trợ lưu trữ cục bộ nhẹ nhàng, tin cậy và hoàn toàn tách biệt khỏi tầng UI/Domain.
3. **Danh mục mini games cụ thể (Đã chốt ở Phase 5):** Triển khai đúng 2 trò chơi offline hoàn chỉnh: Lật thẻ tìm cặp (Christmas Memory Match) và Bắt quà Giáng Sinh 30 giây (Catch the Gifts).
4. **Cơ chế mở khóa Advent (Đã chốt ở Phase 5):** Mở khóa minh bạch theo tiến độ mini-games và số chương đã đọc, đảm bảo 24 chương đều có thể mở được 100% offline.
5. **Âm thanh hiệu ứng lễ hội (TBD cho Phase 6):** Lựa chọn thư viện âm thanh và cân đối kích thước file âm thanh nén để không làm tăng đột biến dung lượng ứng dụng.


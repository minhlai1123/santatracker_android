# BẢNG CHECKLIST KIỂM THỬ THỰC TẾ TRÊN ĐIỆN THOẠI (DEVICE TEST CHECKLIST)
## DỰ ÁN: CHRIMASTSATASTRACKER — PHASE 6: POLISH, FULL QA & RELEASE READINESS

Tài liệu này cung cấp quy trình và bảng biểu hướng dẫn chi tiết dành cho người dùng / QA tester tiến hành kiểm thử thủ công trực tiếp trên thiết bị Android vật lý sau khi cài đặt tệp APK Release.

---

### THÔNG TIN TẬP TIN CÀI ĐẶT (RELEASE ARTIFACT)
- **Tên tệp APK:** `app-release.apk`
- **Đường dẫn tệp:** `E:\Chrimastsatastracker\build\app\outputs\flutter-apk\app-release.apk`
- **Dung lượng:** `47,002,270 bytes` (~44.8 MB)
- **Cấu hình ký:** Android Debug Key (phục vụ cài đặt sideload trực tiếp không cần chứng chỉ Google Play)
- **Hệ điều hành Android tối thiểu (minSdk):** Android 5.0 (API level 21+)
- **Hệ điều hành Android khuyến nghị (targetSdk):** Android 14+ (API level 34+)

---

### HƯỚNG DẪN CÀI ĐẶT APK LÊN ĐIỆN THOẠI

1. **Sao chép tệp:** Kết nối điện thoại với máy tính qua cáp USB và chép tệp `app-release.apk` vào thư mục `Download` của điện thoại (hoặc gửi qua Telegram/Google Drive/Zalo lưu về máy).
2. **Cho phép cài đặt từ nguồn không xác định:** Mở ứng dụng Quản lý tệp (Files/File Manager) trên điện thoại, chọn tệp `app-release.apk`. Nếu thiết bị yêu cầu cấp quyền cài đặt ứng dụng từ nguồn này, chọn **Cho phép / Settings -> Allow from this source**.
3. **Cài đặt:** Nhấn **Cài đặt (Install)** và chờ quá trình hoàn tất.
4. **Mở ứng dụng:** Nhấn **Mở (Open)** để bắt đầu kiểm thử theo các bước bên dưới.

---

### BẢNG QUY TRÌNH KIỂM THỬ CHI TIẾT (14 BƯỚC)

| Bước | Hạng mục kiểm thử | Các thao tác thực hiện | Kết quả mong đợi | Kết quả thực tế (Người dùng điền) | Trạng thái |
| :---: | :--- | :--- | :--- | :--- | :---: |
| **1** | **Cài đặt APK trên thiết bị Android** | 1. Mở file `app-release.apk` từ trình quản lý file.<br>2. Tiến hành cài đặt. | Ứng dụng cài đặt thành công, hiển thị đúng biểu tượng và tên ứng dụng `Chrimastsatastracker`. Không bị Google Play Protect cảnh báo mã độc hại. | [ ] Cài đặt thành công<br>[ ] Báo lỗi | `NOT TESTED` |
| **2** | **Mở ứng dụng và kiểm tra màn hình chính** | 1. Chạm vào biểu tượng ứng dụng để khởi chạy.<br>2. Quan sát màn hình Trang Chủ (`HomeScreen`). | Ứng dụng khởi động nhanh (< 1.5s), hiển thị tiêu đề, tagline Giáng Sinh ấm cúng, thẻ xem trước đếm ngược và 4 thẻ tính năng hoạt động (`Santa Tracker`, `Ngôi Làng Bắc Cực`, `Trò Chơi Giáng Sinh`, `Lịch Advent`). Tất cả 4 thẻ đều có huy hiệu "Hoạt động". Không tràn màn hình. | [ ] Mở nhanh, hiển thị đủ 4 thẻ<br>[ ] Bị lỗi layout | `NOT TESTED` |
| **3** | **Kiểm tra Countdown** | 1. Nhấn nút "Xem Đếm Ngược" trên Trang Chủ.<br>2. Quan sát đồng hồ đếm ngược.<br>3. Chuyển app ra ngoài nền 5 giây rồi mở lại.<br>4. Nhấn "Quay lại Trang Chủ". | Đồng hồ đếm chính xác từng giây đến 00:00:00 ngày 25/12 theo giờ điện thoại. Hiển thị thông điệp ấm áp. Khi mở lại từ nền, đồng hồ vẫn nhảy chính xác không bị đứng. Quay lại Trang Chủ mượt mà. | [ ] Đếm đúng từng giây<br>[ ] Lỗi cập nhật | `NOT TESTED` |
| **4** | **Kiểm tra Santa Tracker** | 1. Nhấn "Mở Santa Tracker".<br>2. Nhấn "Bắt đầu hành trình".<br>3. Nhấn "Điểm tiếp theo" qua vài điểm dừng.<br>4. Thử "Tạm dừng" và "Tiếp tục".<br>5. Nhấn "Quay lại Trang Chủ". | Bản đồ thế giới CustomPainter hiển thị sắc nét, vệt hành trình và điểm dừng vẽ chính xác. Nút Bắt đầu đổi sang Tạm dừng/Tiếp tục mượt mà. Số quà đã phát và điểm dừng tiếp theo cập nhật tức thì. Không bị crash. | [ ] Bản đồ mượt, điều khiển đúng<br>[ ] Giật lag / lỗi | `NOT TESTED` |
| **5** | **Khám phá North Pole Village** | 1. Nhấn "Khám Phá Ngôi Làng".<br>2. Chạm vào một biểu tượng địa điểm bất kỳ trên bản đồ làng.<br>3. Đọc chi tiết và nhấn "Khám Phá Địa Điểm Này".<br>4. Đóng sheet chi tiết và khám phá thêm 1-2 địa điểm khác. | Bản đồ làng hiển thị 8 địa điểm sắc nét. Nhấn địa điểm mở bottom sheet thông tin chi tiết. Khi nhấn Khám phá, biểu tượng đổi sang trạng thái đã khám phá (vòng hào quang + dấu checkmark), thanh tiến độ tăng lên. | [ ] Khám phá và tăng tiến độ đúng<br>[ ] Lỗi chạm | `NOT TESTED` |
| **6** | **Chơi Christmas Memory Match** | 1. Nhấn "Chơi Trò Chơi" -> Vào hub Mini Games.<br>2. Nhấn "Bắt Đầu Chơi" tại thẻ Lật Thẻ Giáng Sinh.<br>3. Lật các thẻ để tìm 1 hoặc 2 cặp đúng.<br>4. Thử nhấn nhanh vào nhiều thẻ khi đang so sánh lệch.<br>5. Chơi hoàn thành cả 6 cặp (12 thẻ). | Lật thẻ có hiệu ứng mượt. Khi lật 2 thẻ không khớp, hệ thống khóa thao tác nhẹ trong ~0.9s rồi tự úp lại, không bị bấm loạn. Khi tìm đủ 6 cặp, xuất hiện hộp thoại chúc mừng chiến thắng và ghi nhận số lượt thử. | [ ] Chơi mượt, thắng có dialog<br>[ ] Lỗi lật thẻ | `NOT TESTED` |
| **7** | **Chơi Catch the Gifts** | 1. Quay lại hub Mini Games, nhấn "Bắt Đầu Chơi" tại thẻ Bắt Quà Giáng Sinh.<br>2. Nhấn "Bắt đầu chơi".<br>3. Chạm vào các hộp quà xuất hiện trên màn hình.<br>4. Thử chạm vào khoảng trống không có quà.<br>5. Chờ đồng hồ đếm về 0 giây. | Hộp quà xuất hiện ngẫu nhiên trong màn hình. Chạm trúng quà được cộng điểm và quà đổi vị trí ngay. Chạm khoảng trống không bị tính điểm. Đúng 0s trò chơi dừng lại ngay, hiện tổng kết điểm và lưu kỷ lục. | [ ] Bắt quà nhạy, hết giờ chuẩn 0s<br>[ ] Lỗi timer | `NOT TESTED` |
| **8** | **Mở các chương Advent Storybook** | 1. Quay lại Trang Chủ -> Nhấn "Khám Phá Sách Truyện".<br>2. Quan sát Chương 1 và các chương tiếp theo.<br>3. Chạm vào Chương 2 hoặc chương đang bị khóa.<br>4. Chạm vào Chương 1 (đang mở khóa). | Chương 1 luôn ở trạng thái "Đã mở". Chương bị khóa hiển thị biểu tượng ổ khóa; khi nhấn vào xuất hiện SnackBar thông báo rõ điều kiện mở khóa. Chạm Chương 1 mở trình đọc chương thành công. | [ ] Chương 1 mở, chương khóa có hint<br>[ ] Lỗi mở chương | `NOT TESTED` |
| **9** | **Đọc chương và Đánh dấu đã đọc** | 1. Trong trình đọc Chương 1, đọc câu chuyện, danh ngôn và câu đố.<br>2. Nhấn nút "Đánh dấu đã đọc".<br>3. Nhấn lại nút này lần nữa (kiểm tra tính idempotent).<br>4. Nhấn "Quay lại sách". | Nút chuyển sang trạng thái "Đã đọc". Nhấn lại không làm tăng số liệu hay lỗi app. Quay lại màn hình sách, thẻ Chương 1 có badge "Đã đọc", thanh tiến độ "Đã đọc: 1 / 24" cập nhật chính xác. Chương 4 mở khóa do thỏa mãn điều kiện đọc Chương 1. | [ ] Đánh dấu đã đọc chuẩn xác<br>[ ] Lỗi cập nhật | `NOT TESTED` |
| **10** | **Đóng ứng dụng hoàn toàn (Force Stop)** | 1. Mở trình đa nhiệm của Android (Recent Apps).<br>2. Vuốt tắt hoàn toàn ứng dụng Chrimastsatastracker (hoặc vào Cài đặt máy -> Ứng dụng -> Chrimastsatastracker -> Buộc dừng / Force Stop). | Ứng dụng được giải phóng hoàn toàn khỏi RAM hệ thống. | [ ] Đã đóng hoàn toàn app | `NOT TESTED` |
| **11** | **Mở lại ứng dụng và Kiểm tra Persistence** | 1. Mở lại ứng dụng từ màn hình chính.<br>2. Vào "Khám Phá Ngôi Làng" -> Kiểm tra các địa điểm đã khám phá ở bước 5.<br>3. Vào "Trò Chơi Giáng Sinh" -> Kiểm tra kỷ lục Memory Match và Catch the Gifts ở bước 6-7.<br>4. Vào "Lịch Advent" -> Kiểm tra Chương 1 vẫn là "Đã đọc" và Chương 4 vẫn mở. | Toàn bộ dữ liệu được lưu cục bộ trong SharedPreferences phục hồi nguyên vẹn 100%: số địa điểm làng đã khám phá giữ nguyên; điểm cao và số lần thắng mini games giữ nguyên; chương đã đọc và mở khóa giữ nguyên. | [ ] Dữ liệu phục hồi 100% đầy đủ<br>[ ] Bị mất dữ liệu | `NOT TESTED` |
| **12** | **Kiểm tra hoạt động Offline (Tắt mạng)** | 1. Bật Chế độ máy bay (Airplane Mode) hoặc tắt hoàn toàn Wi-Fi và Dữ liệu di động (4G/5G).<br>2. Mở ứng dụng và duyệt qua tất cả 5 màn hình.<br>3. Chơi thử mini game và đọc chương sách. | Toàn bộ ứng dụng hoạt động bình thường 100%, không báo lỗi mạng, không màn hình trắng, không mất ảnh/icon. Santa Tracker hiển thị banner chế độ ngoại tuyến minh bạch. | [ ] Hoạt động 100% offline hoàn hảo<br>[ ] Lỗi khi tắt mạng | `NOT TESTED` |
| **13** | **Kiểm tra xoay màn hình và đa nhiệm** | 1. Bật tự động xoay màn hình trên điện thoại.<br>2. Xoay ngang điện thoại tại Trang Chủ, Bản đồ Santa, Ngôi Làng, Mini Games và Sách Truyện.<br>3. Xoay dọc lại. | Ứng dụng xử lý co giãn mượt mà hoặc giữ cố định chiều dọc theo cấu hình (portrait), không bị vỡ layout, không tràn viền `RenderFlex overflow`. | [ ] Co giãn ổn định, không lỗi layout<br>[ ] Lỗi hiển thị khi xoay | `NOT TESTED` |
| **14** | **Kiểm tra độ ổn định và crash** | Sử dụng liên tục ứng dụng trong 5-10 phút, chuyển đổi nhanh giữa các màn hình. | Ứng dụng không bị đứng hình, không văng ứng dụng (crash), máy không bị nóng bất thường, mức tiêu thụ pin thấp. | [ ] Hoạt động mượt mà, không crash<br>[ ] Bị văng app | `NOT TESTED` |

---

### HƯỚNG DẪN THU THẬP BẰNG CHỨNG NẾU GẶP SỰ CỐ

Nếu trong quá trình kiểm thử bạn gặp bất kỳ hành vi bất thường, lỗi tràn viền hoặc crash:
1. **Chụp ảnh màn hình (Screenshot):** Nhấn giữ phím Nguồn + Giảm âm lượng để lưu lại hình ảnh lỗi.
2. **Ghi lại thao tác:** Ghi rõ bước đang thực hiện và dòng thông báo hiển thị trên màn hình.
3. **Thu thập Logcat (nếu có kết nối máy tính):**
   ```powershell
   adb logcat -d *:E > E:\Chrimastsatastracker\crash_log.txt
   ```
4. **Phản hồi:** Điền kết quả vào cột "Kết quả thực tế" và "Trạng thái" của bảng checklist trên và gửi lại cho đội ngũ phát triển.

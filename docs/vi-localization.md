# Việt hóa Daily You

## Môi trường và cách chạy

Dự án dùng Flutter SDK 3.47.2 và Dart 3.13.2 trong lần kiểm tra trên Windows. `pubspec.yaml` yêu cầu Dart từ 3.0.0 trở lên. Cài Flutter, Android SDK và Android Studio/JDK, sau đó chạy trong thư mục gốc:

```powershell
flutter doctor -v
flutter pub get
flutter gen-l10n
dart tool/check_vi_arb.dart
flutter analyze
flutter test
flutter build apk --debug --flavor fdroid
flutter devices
flutter run -d emulator-5554 --flavor fdroid
```

Trên Windows, Flutter cần quyền tạo symlink cho plugin. Bật **Developer Mode** trong Settings > System > For developers trước khi chạy `flutter pub get`. Với Android, chấp nhận các giấy phép SDK theo hướng dẫn của `flutter doctor` nếu được yêu cầu. Bản Windows cần Visual Studio với bộ công cụ C++ dành cho ứng dụng desktop.

Nếu không thể bật Developer Mode, `flutter pub get` có thể đã tải đủ package nhưng dừng trước khi sinh tệp đăng ký plugin Android. Khi `.flutter-plugins-dependencies` và `.dart_tool/package_config.json` đã xuất hiện, chạy:

```powershell
dart tool/generate_android_plugin_registrant.dart
flutter gen-l10n
flutter build apk --debug --flavor fdroid --no-pub
flutter run -d emulator-5554 --flavor fdroid --no-pub
```

Tệp Android registrant sinh ra được Git bỏ qua như thông thường; chạy lại script sau mỗi lần đổi dependencies. Trong lần kiểm tra trên JDK 25, `android/build.gradle` đặt Kotlin target bằng Java target của từng plugin để Gradle biên dịch được. `path_provider_android` được ghim ở 2.2.15 trong `pubspec.yaml` và lockfile để dùng bản khởi động ổn định trên emulator đã kiểm tra.

## Chọn tiếng Việt

Mở **Cài đặt > Ngôn ngữ > Ngôn ngữ ứng dụng**, rồi chọn **Tiếng Việt**. Trên Android 13 trở lên, cũng có thể dùng mục ngôn ngữ ứng dụng trong cài đặt hệ thống. Nếu chọn **Theo hệ thống**, Daily You dùng ngôn ngữ thiết bị khi được hỗ trợ. Lựa chọn ngôn ngữ đã lưu được giữ nguyên khi cập nhật ứng dụng.

`lib/l10n/intl_vi.arb` chứa đủ 332 thông điệp của bản tiếng Anh. `dart tool/check_vi_arb.dart` đối chiếu khóa, metadata, placeholder và các nhánh plural/select. `flutter gen-l10n` sinh `lib/l10n/generated/app_localizations_vi.dart`. Ngày giờ và nhãn ngày trong biểu đồ dùng locale đang chọn; dữ liệu nhật ký lưu trữ không bị thay đổi khi đổi ngôn ngữ.

## Nền tảng và giới hạn

Bản Android/desktop vẫn dùng mã khởi động native và các chức năng riêng của hệ điều hành. Bản Web dùng entrypoint riêng và IndexedDB cho nhật ký, thẻ, ảnh và cài đặt. Chạy `flutter run -d chrome --web-port 5000` rồi mở `http://localhost:5000`; xem README để biết luồng demo, sao lưu và giới hạn. Web không tự đồng bộ với dữ liệu Android/desktop. Thông báo, báo thức, tác vụ nền, chia sẻ từ ứng dụng khác, sinh trắc học, ghi âm và video vẫn là chức năng native.

Trên Windows chưa bật Developer Mode, `flutter pub get` tải được gói nhưng có thể dừng ở bước tạo symlink plugin; khi package config đã có, các lệnh `--no-pub` có thể chạy. Bản `fdroid` debug từng được build và mở trên emulator Pixel 6 (Android 15) với locale `vi-VN` trong lần Việt hóa trước. Kết quả kiểm thử mới cho Web được ghi trong báo cáo bàn giao, không suy ra rằng toàn bộ bộ test cũ đều qua trên Windows.
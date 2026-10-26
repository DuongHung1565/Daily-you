<p align="center">
<img width="500" src="assets/banner.gif" alt="Daily You Logo">
</p>
<div align="center">
  
# Daily You

[<img src="https://f-droid.org/badge/get-it-on.png" height="80">](https://f-droid.org/en/packages/com.demizo.daily_you/)
[<img src="https://gitlab.com/IzzyOnDroid/repo/-/raw/master/assets/IzzyOnDroid.png" height="80">](https://apt.izzysoft.de/fdroid/index/apk/com.demizo.daily_you)
[<img src="https://github.com/machiav3lli/oandbackupx/blob/034b226cea5c1b30eb4f6a6f313e4dadcbb0ece4/badge_github.png" alt="Get it on GitHub" height="80">](https://github.com/Demizo/Daily_You/releases/latest)

[<img src="https://img.shields.io/badge/Liberapay-F6C915?style=for-the-badge&logo=liberapay&logoColor=black" width="auto" height="100" alt="Donate using Liberapay">](https://liberapay.com/Daily-You/donate)
[<img src="https://img.shields.io/badge/Buy_Me_A_Coffee-FFDD00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black" width="auto" height="100" alt="Buy me a Coffee">](https://buymeacoffee.com/demizo)

### Every day is worth remembering…

---

</div>

Capture the moments that matter. **Daily You** helps you log your thoughts, track your mood, and keep a diary of meaningful moments, every day. Whether you're journaling, reflecting, or just noting what made you smile, **Daily You** gives you a private space that's truly your own.

Join a community that believes **your journal should be yours**, not a product.

<p align="center">
<img width="200" src="fastlane/metadata/android/en-US/images/phoneScreenshots/1_home.png" alt="home page">
<img width="200" src="fastlane/metadata/android/en-US/images/phoneScreenshots/2_gallery.png" alt="gallery page">
<img width="200" src="fastlane/metadata/android/en-US/images/phoneScreenshots/3_stats.png" alt="stats page ">
<img width="200" src="fastlane/metadata/android/en-US/images/phoneScreenshots/4_entry_view.png" alt="journal entry">
</p>

### Features

✍️ **Take daily logs:** Journal your thoughts, reflections, or routines.

📈 **Track your mood:** Gain insight into how your mood changes over time.

🖼️ **Keep photo memories:** Add pictures to enrich your memories.

📝 **Rich note taking:** Format notes your own way with Markdown.

🔔 **Gentle reminders:** Random daily nudges to keep you consistent.

🔒 **Control your data:** Choose where your data lives, including external storage.

🌐 **Offline-first:** Works without internet. Always.

**Daily You** is free, open source, and community supported. Built around the belief that your diary should be yours forever, not a subscription. No accounts, no ads, no locked features, and no tracking or data collection. Just your story, on your device, owned by you.

---

<p align="center">
<img width="500" src="assets/download_migrate_banner.gif" alt="Daily You Logo">
</p>

<div align="center">

## Download

[![Downloads](https://img.shields.io/github/downloads/Demizo/Daily_You/total)](https://github.com/Demizo/Daily_You/releases)
[<img src="https://shields.rbtlog.dev/simple/com.demizo.daily_you" alt="RB Status">](https://shields.rbtlog.dev/com.demizo.daily_you)

[<img src="https://f-droid.org/badge/get-it-on.png" height="80">](https://f-droid.org/en/packages/com.demizo.daily_you/)
[<img src="https://gitlab.com/IzzyOnDroid/repo/-/raw/master/assets/IzzyOnDroid.png" height="80">](https://apt.izzysoft.de/fdroid/index/apk/com.demizo.daily_you)
[<img src="https://github.com/machiav3lli/oandbackupx/blob/034b226cea5c1b30eb4f6a6f313e4dadcbb0ece4/badge_github.png" alt="Get it on GitHub" height="80">](https://github.com/Demizo/Daily_You/releases/latest)

</div>

### Migrate From Another App
Are you coming from another app? Simply go to `Settings > Backup & Restore > Import From Another App` to import a backup from another app. Feel free to request any apps not currently listed. **Note:** Imports from some apps may not be one-to-one since **Daily You** may have different features.

### Development
The full development environment is defined using [Nix](https://nixos.org/). Simply, install the [Nix Package Manager](https://nixos.org/download/), clone the repository, enter the project directory, and run `nix develop`, that's it! Alternatively, **Daily You** is built using Flutter. You can directly [install Flutter](https://docs.flutter.dev/get-started/install), clone the repository, enter the project directory, and run `flutter pub get`.

### Chạy bản Web tiếng Việt

Cài Flutter và Chrome, sau đó chạy trong thư mục gốc của dự án:

```powershell
flutter pub get
flutter gen-l10n
flutter run -d chrome --web-port 5000
```

Mở **http://localhost:5000**. Bản Web mặc định hiển thị tiếng Việt khi chưa có lựa chọn ngôn ngữ; có thể đổi ngôn ngữ trong **Cài đặt**. Trên Windows, `flutter pub get` cần quyền tạo symlink cho plugin (bật Developer Mode). Nếu dependencies đã được tải nhưng bước tạo symlink thất bại, có thể chạy lệnh Web với `--no-pub` sau khi kiểm tra `.dart_tool/package_config.json` đã được tạo.

Bản Web hỗ trợ tạo, xem, sửa, xóa và tìm kiếm nhật ký; chọn tâm trạng, gắn/lọc thẻ, xem ảnh trong thư viện và thống kê cơ bản. Có thể đính kèm ảnh PNG, JPEG hoặc WebP tối đa 5 MB mỗi ảnh. Dữ liệu nhật ký, ảnh, thẻ và ngôn ngữ được lưu bằng **IndexedDB** trong trình duyệt, gắn với nguồn `http://localhost:5000`; tải lại trang vẫn giữ dữ liệu. Chế độ ẩn danh, xóa dữ liệu trang hoặc đổi tên miền/cổng có thể làm dữ liệu không còn truy cập được. Dung lượng phụ thuộc hạn mức trình duyệt. Dùng **Cài đặt > Xuất bản sao lưu Web / Nhập bản sao lưu Web** để sao lưu/khôi phục tệp JSON của bản Web; dữ liệu Web không tự đồng bộ với Android hay desktop. Luồng xuất đã được kiểm tra trên Chrome; luồng nhập và lưu ảnh đã qua test repository nhưng chưa kiểm tra trọn vẹn qua hộp chọn tệp của Chrome headless.

Các tính năng phụ thuộc hệ điều hành như thông báo, báo thức, tác vụ nền, nhận chia sẻ, sinh trắc học, ghi âm, video, đường dẫn tệp tùy chọn và sao lưu theo định dạng native vẫn dành cho bản Android/desktop. Bản Web hiển thị thông báo tiếng Việt cho loại tệp đính kèm chưa hỗ trợ. Giao diện Web tập trung vào các thao tác nhật ký cần cho bản demo; các màn hình native vẫn dùng luồng khởi động cũ.

Kiểm tra mã và bản phát hành Web:

```powershell
dart tool/check_vi_arb.dart
flutter analyze --no-pub
flutter test --no-pub
flutter build web --no-pub
```

Để quay video demo: mở `http://localhost:5000`, cho thấy Trang chủ tiếng Việt, tạo nhật ký có nội dung và tâm trạng, mở lại mục để sửa, thử tìm kiếm/thẻ, tải lại trang để thấy dữ liệu vẫn còn, rồi mở Thư viện, Thống kê và Cài đặt. Xuất bản sao lưu nếu cần chứng minh khả năng mang dữ liệu đi.

---

<p align="center">
<img width="500" src="assets/support_banner.gif" alt="Daily You Logo">
</p>

<div align="center">
  
## Support The App

</div>

**Daily You** is _free forever_ since everyone deserves a journal that is truly their own. If you find yourself enjoying the app, please consider supporting its continued development.

[<img src="https://img.shields.io/badge/Liberapay-F6C915?style=for-the-badge&logo=liberapay&logoColor=black" width="auto" height="100" alt="Donate using Liberapay">](https://liberapay.com/Daily-You/donate)
[<img src="https://img.shields.io/badge/Buy_Me_A_Coffee-FFDD00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black" width="auto" height="100" alt="Buy me a Coffee">](https://buymeacoffee.com/demizo)

### Translations 
**Daily You** uses [Weblate](https://weblate.org) to easily manage translations. If you would like to help translate the app, please visit [the Daily You project on Weblate](https://hosted.weblate.org/projects/daily-you/). Everyone should have access to a journal!


## License
This software is free software licensed under the [GNU General Public License 3.0](LICENSE.txt). Additional terms under section 7 of that license apply; see [ADDITIONAL_TERMS.md](ADDITIONAL_TERMS.md).

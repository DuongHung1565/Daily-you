// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'Daily You';

  @override
  String get dailyReminderTitle => 'Ghi nhật ký hôm nay!';

  @override
  String get dailyReminderDescription => 'Ghi lại ngày hôm nay của bạn…';

  @override
  String get actionTakePhoto => 'Chụp ảnh';

  @override
  String get actionTakeVideo => 'Quay video';

  @override
  String get actionRecordAudio => 'Ghi âm';

  @override
  String get actionAddImage => 'Thêm ảnh';

  @override
  String get actionAddVideo => 'Thêm video';

  @override
  String get actionAddAudio => 'Thêm bản ghi âm';

  @override
  String get actionToday => 'Hôm nay';

  @override
  String get actionOtherDay => 'Ngày khác';

  @override
  String get pageHomeTitle => 'Trang chủ';

  @override
  String get jumpToMonthTitle => 'Chuyển đến tháng';

  @override
  String get jumpToLogTitle => 'Chuyển đến mục nhật ký';

  @override
  String get flashbacksTitle => 'Kỷ niệm';

  @override
  String get settingsFlashbacksExcludeBadDays => 'Không hiện những ngày buồn';

  @override
  String get flaskbacksEmpty => 'Chưa có kỷ niệm nào…';

  @override
  String get flashbackGoodDay => 'Một ngày vui';

  @override
  String get flashbackRandomDay => 'Một ngày bất kỳ';

  @override
  String flashbackWeek(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tuần trước',
      one: '$count tuần trước',
    );
    return '$_temp0';
  }

  @override
  String flashbackMonth(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tháng trước',
      one: '$count tháng trước',
    );
    return '$_temp0';
  }

  @override
  String flashbackYear(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count năm trước',
      one: '$count năm trước',
    );
    return '$_temp0';
  }

  @override
  String get flashbackOnThisDay => 'Ngày này năm xưa';

  @override
  String get pageGalleryTitle => 'Thư viện';

  @override
  String get searchLogsHint => 'Tìm trong nhật ký…';

  @override
  String logCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mục nhật ký',
      one: '$count mục nhật ký',
    );
    return '$_temp0';
  }

  @override
  String dayCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ngày',
      one: '$count ngày',
    );
    return '$_temp0';
  }

  @override
  String wordCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count từ',
      one: '$count từ',
    );
    return '$_temp0';
  }

  @override
  String get noLogs => 'Chưa có mục nhật ký nào…';

  @override
  String get noResults => 'Không tìm thấy kết quả…';

  @override
  String get sortDateTitle => 'Ngày';

  @override
  String get sortOrderAscendingTitle => 'Tăng dần';

  @override
  String get sortOrderDescendingTitle => 'Giảm dần';

  @override
  String get pageStatisticsTitle => 'Thống kê';

  @override
  String get statisticsNotEnoughData => 'Chưa đủ dữ liệu…';

  @override
  String get statisticsRangeOneMonth => '1 tháng';

  @override
  String get statisticsRangeSixMonths => '6 tháng';

  @override
  String get statisticsRangeOneYear => '1 năm';

  @override
  String get statisticsRangeAllTime => 'Toàn bộ thời gian';

  @override
  String chartSummaryTitle(Object tag) {
    return 'Tổng quan về $tag';
  }

  @override
  String chartByDayTitle(Object tag) {
    return '$tag theo ngày';
  }

  @override
  String chartOverTimeTitle(Object tag) {
    return '$tag theo thời gian';
  }

  @override
  String get chartGroupingLabel => 'Nhóm theo';

  @override
  String get chartGroupingDay => 'Ngày';

  @override
  String get chartGroupingWeek => 'Tuần';

  @override
  String get chartGroupingMonth => 'Tháng';

  @override
  String get chartGroupingYear => 'Năm';

  @override
  String get chartSmoothingLabel => 'Làm mượt';

  @override
  String streakCurrent(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Chuỗi hiện tại: $count ngày',
    );
    return '$_temp0';
  }

  @override
  String streakLongest(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Chuỗi dài nhất: $count ngày',
    );
    return '$_temp0';
  }

  @override
  String streakGreatDays(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Số ngày vui: $count',
    );
    return '$_temp0';
  }

  @override
  String streakSinceBadDay(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Từ ngày buồn gần nhất: $count ngày',
    );
    return '$_temp0';
  }

  @override
  String get errorExternalStorageAccessTitle =>
      'Không thể truy cập bộ nhớ ngoài';

  @override
  String get errorExternalStorageAccessDescription =>
      'Nếu bạn dùng bộ nhớ mạng, hãy kiểm tra dịch vụ đang hoạt động và thiết bị có kết nối mạng.\n\nNếu không, ứng dụng có thể đã mất quyền truy cập thư mục ngoài. Hãy vào Cài đặt và chọn lại thư mục để cấp quyền.\n\nLưu ý: Các thay đổi sẽ không được đồng bộ cho đến khi bạn khôi phục quyền truy cập bộ nhớ ngoài!';

  @override
  String get errorExternalStorageAccessContinue =>
      'Tiếp tục với dữ liệu trên thiết bị';

  @override
  String get databaseMigrationErrorTitle => 'Không thể chuyển dữ liệu của bạn';

  @override
  String get databaseMigrationErrorDescription =>
      'Các mục nhật ký của bạn vẫn an toàn nhưng chưa thể chuyển vào bộ nhớ của ứng dụng.\n\nHãy thử lại và báo lỗi nếu tình trạng tiếp diễn.';

  @override
  String get databaseMigrationErrorRetry => 'Thử lại';

  @override
  String get databaseNewerErrorTitle => 'Cần cập nhật ứng dụng';

  @override
  String get databaseNewerErrorDescription =>
      'Dữ liệu của bạn được lưu bằng phiên bản Daily You mới hơn. Phiên bản này không thể mở dữ liệu một cách an toàn. Hãy cập nhật ứng dụng để tiếp tục.';

  @override
  String get errorReport => 'Báo lỗi';

  @override
  String get lastModified => 'Đã chỉnh sửa';

  @override
  String get writeSomethingHint => 'Viết điều gì đó…';

  @override
  String get titleHint => 'Tiêu đề…';

  @override
  String get deleteLogTitle => 'Xóa mục nhật ký';

  @override
  String get deleteLogDescription => 'Bạn có muốn xóa mục nhật ký này không?';

  @override
  String get deletePhotoTitle => 'Xóa ảnh';

  @override
  String get deletePhotoDescription => 'Bạn có muốn xóa ảnh này không?';

  @override
  String get deleteAttachmentTitle => 'Xóa tệp đính kèm';

  @override
  String get deleteAttachmentDescription =>
      'Bạn có muốn xóa tệp đính kèm này không?';

  @override
  String get largeAttachmentWarningTitle => 'Tệp đính kèm lớn';

  @override
  String get largeAttachmentWarningDescription =>
      'Tệp này có dung lượng lớn và sẽ làm bản sao lưu lớn hơn.';

  @override
  String get dontShowAgain => 'Đừng hiện lại';

  @override
  String get pageSettingsTitle => 'Cài đặt';

  @override
  String get settingsAppearanceTitle => 'Giao diện';

  @override
  String get settingsTheme => 'Chủ đề';

  @override
  String get themeSystem => 'Theo hệ thống';

  @override
  String get themeLight => 'Sáng';

  @override
  String get themeDark => 'Tối';

  @override
  String get themeAmoled => 'AMOLED';

  @override
  String get settingsFirstDayOfWeek => 'Ngày đầu tuần';

  @override
  String get settingsCalendarSystem => 'Hệ lịch';

  @override
  String get calendarSystemGregorian => 'Dương lịch';

  @override
  String get calendarSystemJalali => 'Lịch Jalali';

  @override
  String get settingsUseSystemAccentColor => 'Dùng màu nhấn của hệ thống';

  @override
  String get settingsCustomAccentColor => 'Tùy chỉnh màu nhấn';

  @override
  String get settingsShowMarkdownToolbar => 'Hiện thanh công cụ Markdown';

  @override
  String get settingsShowFlashbacks => 'Hiện kỷ niệm';

  @override
  String get settingsChangeMoodIcons => 'Đổi biểu tượng tâm trạng';

  @override
  String get moodIconPrompt => 'Nhập một biểu tượng';

  @override
  String get settingsFlashbacksViewLayout => 'Cách hiển thị kỷ niệm';

  @override
  String get settingsGalleryViewLayout => 'Cách hiển thị thư viện';

  @override
  String get settingsHideImagesInGallery => 'Ẩn ảnh trong thư viện';

  @override
  String get settingsHideImages => 'Ẩn ảnh';

  @override
  String get pageCalendarTitle => 'Lịch';

  @override
  String get viewLayoutList => 'Danh sách';

  @override
  String get viewLayoutGrid => 'Lưới';

  @override
  String get settingsNotificationsTitle => 'Thông báo';

  @override
  String get settingsDailyReminderOnboarding =>
      'Bật nhắc nhở hằng ngày để duy trì thói quen viết nhật ký!';

  @override
  String get settingsNotificationsPermissionsPrompt =>
      'Ứng dụng sẽ xin quyền đặt báo thức để nhắc bạn vào thời điểm ngẫu nhiên hoặc giờ bạn chọn.';

  @override
  String get settingsDailyReminderTitle => 'Nhắc nhở hằng ngày';

  @override
  String get settingsOnThisDayDescription => 'Xem lại những kỷ niệm cũ';

  @override
  String get settingsDailyReminderDescription => 'Một lời nhắc nhẹ mỗi ngày';

  @override
  String get settingsReminderTime => 'Giờ nhắc';

  @override
  String get settingsFixedReminderTimeTitle => 'Giờ nhắc cố định';

  @override
  String get settingsFixedReminderTimeDescription =>
      'Chọn một giờ cố định để nhận lời nhắc';

  @override
  String get settingsAlwaysSendReminderTitle => 'Luôn gửi lời nhắc';

  @override
  String get settingsAlwaysSendReminderDescription =>
      'Vẫn nhắc khi bạn đã bắt đầu viết nhật ký';

  @override
  String get settingsCustomizeNotificationTitle => 'Tùy chỉnh thông báo';

  @override
  String get settingsTemplatesTitle => 'Mẫu nhật ký';

  @override
  String get settingsDefaultTemplate => 'Mẫu mặc định';

  @override
  String get manageTemplates => 'Quản lý mẫu';

  @override
  String get addTemplate => 'Thêm mẫu';

  @override
  String get newTemplate => 'Mẫu mới';

  @override
  String get noTemplateTitle => 'Không có';

  @override
  String get noTemplatesDescription => 'Bạn chưa tạo mẫu nào…';

  @override
  String get templateVariableTime => 'Thời gian';

  @override
  String get templateDefaultTimestampTitle => 'Ngày giờ';

  @override
  String templateDefaultTimestampBody(Object date, Object time) {
    return '$date - $time:';
  }

  @override
  String get templateDefaultSummaryTitle => 'Tóm tắt ngày';

  @override
  String get templateDefaultSummaryBody =>
      '### Tóm tắt\n- \n\n### Trích dẫn\n> ';

  @override
  String get templateDefaultReflectionTitle => 'Suy ngẫm';

  @override
  String get templateDefaultReflectionBody =>
      '### Hôm nay bạn thích điều gì?\n- \n\n### Bạn biết ơn điều gì?\n- \n\n### Bạn mong chờ điều gì?\n- ';

  @override
  String get settingsTagsTitle => 'Thẻ';

  @override
  String get manageTags => 'Quản lý thẻ';

  @override
  String get tagTypeLabelTitle => 'Nhãn';

  @override
  String get tagTypeTrackerTitle => 'Mục theo dõi';

  @override
  String get nameHint => 'Tên';

  @override
  String get tagColorLabel => 'Màu';

  @override
  String get iconPickerTitle => 'Chọn biểu tượng';

  @override
  String get iconPickerIconsTab => 'Biểu tượng';

  @override
  String get iconPickerCustomTab => 'Tùy chỉnh';

  @override
  String get iconPickerSearchHint => 'Tìm biểu tượng…';

  @override
  String get colorPickerTitle => 'Chọn màu';

  @override
  String get colorPickerPaletteTab => 'Màu sắc';

  @override
  String get iconGroupMoodPeople => 'Tâm trạng và con người';

  @override
  String get iconGroupHealth => 'Sức khỏe';

  @override
  String get iconGroupWorkFinance => 'Công việc và tài chính';

  @override
  String get iconGroupHabitsGoals => 'Thói quen và mục tiêu';

  @override
  String get iconGroupNature => 'Thiên nhiên';

  @override
  String get iconGroupFoodDrink => 'Ăn uống';

  @override
  String get iconGroupHome => 'Nhà cửa';

  @override
  String get iconGroupTravel => 'Du lịch';

  @override
  String get iconGroupSymbols => 'Ký hiệu';

  @override
  String get tagCategoryLabel => 'Danh mục';

  @override
  String get tagLabel => 'Thẻ';

  @override
  String get tagCategoryUncategorized => 'Chưa phân loại';

  @override
  String get newCategoryTitle => 'Danh mục mới';

  @override
  String get shareButtonLabel => 'Chia sẻ';

  @override
  String get importErrorDescription => 'Không thể nhập tệp!';

  @override
  String get exportErrorDescription => 'Không thể xuất tệp!';

  @override
  String get deleteTitle => 'Xóa';

  @override
  String deleteTagMessage(num count, Object name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: ' Thẻ này được dùng trong $count mục nhật ký.',
      one: ' Thẻ này được dùng trong 1 mục nhật ký.',
      zero: '',
    );
    return 'Xóa \"$name\"?$_temp0';
  }

  @override
  String deleteCategoryMessage(num count, Object name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: ' $count thẻ trong danh mục cũng sẽ bị xóa.',
      one: ' 1 thẻ trong danh mục cũng sẽ bị xóa.',
      zero: '',
    );
    return 'Xóa \"$name\"?$_temp0';
  }

  @override
  String deleteTemplateMessage(Object name) {
    return 'Xóa \"$name\"?';
  }

  @override
  String get filterTagsTitle => 'Lọc';

  @override
  String get tagFilterModeAny => 'Có ít nhất một thẻ';

  @override
  String get tagFilterModeAll => 'Có tất cả thẻ';

  @override
  String get clearAllFilters => 'Xóa tất cả bộ lọc';

  @override
  String get noTagsFilterLabel => 'Không có thẻ';

  @override
  String get addTagsTitle => 'Thêm thẻ';

  @override
  String get addTagsSearchHint => 'Tìm thẻ…';

  @override
  String get tagPickerSortManualLabel => 'Thứ tự thủ công';

  @override
  String get tagPickerSortUsageLabel => 'Sắp xếp theo lượt dùng';

  @override
  String get tagFavoriteName => 'Yêu thích';

  @override
  String get tagEnergyName => 'Năng lượng';

  @override
  String get tagCategoryActivitiesName => 'Hoạt động';

  @override
  String get tagExerciseName => 'Tập thể dục';

  @override
  String get tagSocializingName => 'Gặp gỡ mọi người';

  @override
  String get tagHobbyName => 'Sở thích';

  @override
  String get tagEntertainmentName => 'Giải trí';

  @override
  String get tagDiningName => 'Ăn uống';

  @override
  String get tagChoresName => 'Việc nhà';

  @override
  String get tagCategoryEmotionsName => 'Cảm xúc';

  @override
  String get tagExcitedName => 'Hào hứng';

  @override
  String get tagGratefulName => 'Biết ơn';

  @override
  String get tagCalmName => 'Bình yên';

  @override
  String get tagTiredName => 'Mệt mỏi';

  @override
  String get tagAnxiousName => 'Lo âu';

  @override
  String get tagAnnoyedName => 'Bực mình';

  @override
  String get welcomeLogBodyText =>
      '## Chào mừng đến với Daily You\n\n> Mỗi ngày đều đáng nhớ, hãy lưu lại những khoảnh khắc của bạn!\n\n**Daily You** miễn phí, có [mã nguồn mở](https://github.com/Demizo/Daily_You) và được cộng đồng hỗ trợ. Nhật ký của bạn thuộc về chính bạn:\n\n- Không quảng cáo\n- Không khóa tính năng\n- Không theo dõi hoặc thu thập dữ liệu\n\nDù bạn viết nhật ký, suy ngẫm hay chỉ ghi lại điều khiến mình mỉm cười, **Daily You** luôn là không gian riêng _thực sự thuộc về bạn_.';

  @override
  String get settingsStorageTitle => 'Lưu trữ và đồng bộ';

  @override
  String get settingsImageQuality => 'Chất lượng ảnh';

  @override
  String get settingsMediaQualityTitle => 'Chất lượng phương tiện';

  @override
  String get imageQualityHigh => 'Cao';

  @override
  String get imageQualityMedium => 'Trung bình';

  @override
  String get imageQualityLow => 'Thấp';

  @override
  String get imageQualityNoCompression => 'Không nén';

  @override
  String get settingsStorageUsage => 'Dung lượng đã dùng';

  @override
  String get settingsLogFolder => 'Thư mục nhật ký';

  @override
  String get settingsImageFolder => 'Thư mục ảnh';

  @override
  String get settingsExternalSyncTitle => 'Đồng bộ với vị trí ngoài';

  @override
  String get chooseFolderHint => 'Chọn thư mục';

  @override
  String get warningTitle => 'Cảnh báo';

  @override
  String get logFolderWarningDescription =>
      'Thư mục đã chọn có tệp \'daily_you.db\'. Tệp này sẽ ghi đè các mục nhật ký hiện có của bạn!';

  @override
  String get errorTitle => 'Lỗi';

  @override
  String get logFolderErrorDescription => 'Không thể đổi thư mục nhật ký!';

  @override
  String get imageFolderErrorDescription => 'Không thể đổi thư mục ảnh!';

  @override
  String get syncErrorDescription => 'Không thể đồng bộ với vị trí ngoài!';

  @override
  String get backupErrorDescription => 'Không thể tạo bản sao lưu!';

  @override
  String get restoreErrorDescription => 'Không thể khôi phục bản sao lưu!';

  @override
  String get settingsBackupRestoreTitle => 'Sao lưu và khôi phục';

  @override
  String get settingsBackup => 'Sao lưu';

  @override
  String get settingsRestore => 'Khôi phục';

  @override
  String get settingsRestorePromptDescription =>
      'Khôi phục bản sao lưu sẽ ghi đè dữ liệu hiện có của bạn!';

  @override
  String get settingsBackupPasswordProtect => 'Đặt mật khẩu cho bản sao lưu';

  @override
  String get backupEncryptedTitle => 'Bản sao lưu được mã hóa';

  @override
  String get backupEncryptedContent =>
      'Bản sao lưu này được bảo vệ bằng mật khẩu.';

  @override
  String get settingsAutoBackup => 'Tự động sao lưu';

  @override
  String get settingsAutoBackupLocation => 'Vị trí sao lưu';

  @override
  String get settingsAutoBackupInterval => 'Tần suất sao lưu';

  @override
  String get settingsAutoBackupIntervalDaily => 'Hằng ngày';

  @override
  String get settingsAutoBackupIntervalWeekly => 'Hằng tuần';

  @override
  String get settingsAutoBackupIntervalMonthly => 'Hằng tháng';

  @override
  String get settingsAutoBackupMaxCount => 'Số bản sao lưu cần giữ';

  @override
  String get settingsAutoBackupRequireCharging => 'Chỉ khi đang sạc';

  @override
  String settingsBackupLast(Object time) {
    return 'Lần sao lưu gần nhất: $time';
  }

  @override
  String get settingsBackupNever => 'Chưa từng sao lưu';

  @override
  String settingsAutoBackupNext(Object time) {
    return 'Lần sao lưu tiếp theo: $time';
  }

  @override
  String get settingsAutoBackupKeepAll => 'Tất cả';

  @override
  String get autoBackupFailedTitle => 'Sao lưu thất bại';

  @override
  String tranferStatus(Object percent) {
    return 'Đang chuyển… $percent%';
  }

  @override
  String creatingBackupStatus(Object percent) {
    return 'Đang tạo bản sao lưu… $percent%';
  }

  @override
  String restoringBackupStatus(Object percent) {
    return 'Đang khôi phục bản sao lưu… $percent%';
  }

  @override
  String encryptingBackupStatus(Object percent) {
    return 'Đang mã hóa bản sao lưu… $percent%';
  }

  @override
  String decryptingBackupStatus(Object percent) {
    return 'Đang giải mã bản sao lưu… $percent%';
  }

  @override
  String get cleanUpStatus => 'Đang dọn dẹp…';

  @override
  String migratingImagesStatus(Object current, Object total) {
    return 'Đang chuyển ảnh… $current/$total';
  }

  @override
  String get settingsExport => 'Xuất dữ liệu';

  @override
  String get settingsExportToAnotherFormat => 'Xuất sang định dạng khác';

  @override
  String get settingsExportFormatDescription =>
      'Không dùng tệp xuất này làm bản sao lưu!';

  @override
  String get exportLogs => 'Xuất nhật ký';

  @override
  String get exportImages => 'Xuất ảnh';

  @override
  String get exportIncludeTitle => 'Bao gồm';

  @override
  String get settingsImport => 'Nhập dữ liệu';

  @override
  String get settingsImportFromAnotherApp => 'Nhập từ ứng dụng khác';

  @override
  String get settingsTranslateCallToAction =>
      'Ai cũng nên có thể sử dụng nhật ký bằng ngôn ngữ của mình!';

  @override
  String get settingsHelpTranslate => 'Góp sức dịch ứng dụng';

  @override
  String get importLogs => 'Nhập nhật ký';

  @override
  String get importImages => 'Nhập ảnh';

  @override
  String get logFormatTitle => 'Chọn định dạng';

  @override
  String get logFormatDescription =>
      'Định dạng của ứng dụng khác có thể không hỗ trợ mọi tính năng. Hãy báo lỗi nếu gặp sự cố vì định dạng bên thứ ba có thể thay đổi bất kỳ lúc nào. Các mục nhật ký hiện có của bạn sẽ không bị ảnh hưởng!';

  @override
  String get formatDailyYouJson => 'Daily You (JSON)';

  @override
  String get formatDaybook => 'Daybook';

  @override
  String get formatDaylio => 'Daylio';

  @override
  String get formatDiarium => 'Diarium';

  @override
  String get formatDiaro => 'Diaro';

  @override
  String get formatMyBrain => 'My Brain';

  @override
  String get formatOneShot => 'OneShot';

  @override
  String get formatPixels => 'Pixels';

  @override
  String get formatMarkdown => 'Markdown';

  @override
  String get settingsDeleteAllLogsTitle => 'Xóa toàn bộ nhật ký';

  @override
  String get settingsDeleteAllLogsDescription =>
      'Bạn có muốn xóa tất cả mục nhật ký không?';

  @override
  String settingsDeleteAllLogsPrompt(Object prompt) {
    return 'Nhập \'$prompt\' để xác nhận. Bạn không thể hoàn tác thao tác này!';
  }

  @override
  String get settingsLanguageTitle => 'Ngôn ngữ';

  @override
  String get settingsAppLanguageTitle => 'Ngôn ngữ ứng dụng';

  @override
  String get settingsOverrideAppLanguageTitle => 'Dùng ngôn ngữ riêng';

  @override
  String get settingsSecurityTitle => 'Bảo mật';

  @override
  String get settingsSecurityRequirePassword => 'Yêu cầu mật khẩu';

  @override
  String get settingsSecurityEnterPassword => 'Nhập mật khẩu';

  @override
  String get settingsSecuritySetPassword => 'Đặt mật khẩu';

  @override
  String get settingsSecurityChangePassword => 'Đổi mật khẩu';

  @override
  String get settingsSecurityPassword => 'Mật khẩu';

  @override
  String get settingsSecurityConfirmPassword => 'Xác nhận mật khẩu';

  @override
  String get settingsSecurityOldPassword => 'Mật khẩu cũ';

  @override
  String get settingsSecurityIncorrectPassword => 'Mật khẩu không đúng';

  @override
  String get settingsSecurityPasswordsDoNotMatch => 'Mật khẩu không khớp';

  @override
  String get requiredPrompt => 'Bắt buộc';

  @override
  String get settingsSecurityBiometricUnlock => 'Mở khóa bằng sinh trắc học';

  @override
  String get unlockAppPrompt => 'Mở khóa ứng dụng';

  @override
  String get settingsAboutTitle => 'Giới thiệu';

  @override
  String get settingsVersion => 'Phiên bản';

  @override
  String get settingsLicense => 'Giấy phép';

  @override
  String get licenseGPLv3 => 'GPL-3.0';

  @override
  String get settingsSourceCode => 'Mã nguồn';

  @override
  String get settingsOpenSourceLicenses => 'Giấy phép mã nguồn mở';

  @override
  String get settingsMadeWithLove => 'Được tạo bằng ❤️';

  @override
  String get settingsConsiderSupporting => 'hãy cân nhắc ủng hộ';

  @override
  String get imagesTitle => 'Hình ảnh';

  @override
  String get audioTitle => 'Âm thanh';

  @override
  String get videoTitle => 'Video';

  @override
  String get tagMoodTitle => 'Tâm trạng';

  @override
  String get calendarTagDisplayLabel => 'Thẻ';

  @override
  String get selectTagTitle => 'Chọn thẻ';

  @override
  String get labelPresentLabel => 'Có';

  @override
  String get labelAbsentLabel => 'Không';

  @override
  String get labelCoverageLabel => 'Mức độ ghi nhận';

  @override
  String chartDistributionTitle(Object tag) {
    return 'Phân bố của $tag';
  }

  @override
  String get shareAddToLogPickerTitle => 'Chọn mục nhật ký';

  @override
  String get attachmentAddErrorDescription => 'Không thể thêm tệp đính kèm!';

  @override
  String get attachmentLoadFailed => 'Không thể mở tệp đính kèm này';

  @override
  String get attachmentNoAppToOpen => 'Không có ứng dụng nào mở được tệp này';

  @override
  String get recorderDiscardTitle => 'Bỏ bản ghi âm?';

  @override
  String get recorderDiscardDescription => 'Bản ghi âm này sẽ bị xóa.';

  @override
  String get recorderDiscardAction => 'Bỏ';

  @override
  String get recorderPermissionDenied => 'Cần quyền truy cập micrô để ghi âm';

  @override
  String get recorderErrorDescription => 'Không thể ghi âm!';

  @override
  String get webNewEntry => 'Mục nhật ký mới';

  @override
  String get webEditEntry => 'Sửa mục nhật ký';

  @override
  String get webSave => 'Lưu';

  @override
  String get webCancel => 'Hủy';

  @override
  String get webDelete => 'Xóa';

  @override
  String get webSearch => 'Tìm mục nhật ký';

  @override
  String get webAllEntries => 'Tất cả mục nhật ký';

  @override
  String get webMoodQuestion => 'Hôm nay bạn cảm thấy thế nào?';

  @override
  String get webMoodVeryBad => 'Rất tệ';

  @override
  String get webMoodBad => 'Không vui';

  @override
  String get webMoodNeutral => 'Bình thường';

  @override
  String get webMoodGood => 'Vui';

  @override
  String get webMoodGreat => 'Rất vui';

  @override
  String get webTagsHint => 'Ngăn cách các thẻ bằng dấu phẩy';

  @override
  String get webAddTag => 'Thêm thẻ';

  @override
  String get webStorageUnavailable =>
      'Trình duyệt này không truy cập được IndexedDB. Không thể lưu nhật ký tại đây.';

  @override
  String get webStorageFailure =>
      'Không thể lưu dữ liệu trong trình duyệt. Hãy kiểm tra dung lượng trống và quyền lưu trữ.';

  @override
  String get webImageTooLarge => 'Hãy chọn ảnh nhỏ hơn 5 MB.';

  @override
  String get webImageUnsupported => 'Bản Web chỉ hỗ trợ ảnh PNG, JPEG và WebP.';

  @override
  String get webImageReadFailure => 'Không thể đọc ảnh này.';

  @override
  String get webDeleteConfirm => 'Xóa mục nhật ký này cùng các ảnh đính kèm?';

  @override
  String get webEntrySaved => 'Đã lưu mục nhật ký.';

  @override
  String get webEntryDeleted => 'Đã xóa mục nhật ký.';

  @override
  String get webBrowserDataWarning =>
      'Nhật ký chỉ nằm trong trình duyệt trên thiết bị này và không tự đồng bộ với ứng dụng Android hoặc máy tính. Hãy xuất bản sao lưu trước khi xóa dữ liệu trình duyệt.';

  @override
  String get webPhotoOnly =>
      'Bản Web hiện chỉ hỗ trợ ảnh đính kèm. Âm thanh và video có trong ứng dụng cài trên thiết bị.';

  @override
  String get webPickImage => 'Chọn ảnh';

  @override
  String get webRemoveImage => 'Bỏ ảnh';

  @override
  String get webFilterByTag => 'Lọc theo thẻ';

  @override
  String get webGalleryEmpty => 'Chưa có ảnh';

  @override
  String get webBackupExport => 'Xuất bản sao lưu Web';

  @override
  String get webBackupImport => 'Nhập bản sao lưu Web';

  @override
  String get webImportSuccess => 'Đã nhập bản sao lưu Web.';

  @override
  String get webInvalidBackup =>
      'Tệp này không phải bản sao lưu Daily You Web hợp lệ.';

  @override
  String get webExportError => 'Không thể xuất bản sao lưu Web.';

  @override
  String get webImportError => 'Không thể nhập bản sao lưu Web.';
}

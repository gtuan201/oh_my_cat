// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Month`
  String get month {
    return Intl.message(
      'Month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `year`
  String get year {
    return Intl.message(
      'year',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `Yo! How are you feeling today?`
  String get feeling_today {
    return Intl.message(
      'Yo! How are you feeling today?',
      name: 'feeling_today',
      desc: '',
      args: [],
    );
  }

  /// `How did you feel that day?`
  String get feel_that_day {
    return Intl.message(
      'How did you feel that day?',
      name: 'feel_that_day',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Yes! Added successfully`
  String get success_add {
    return Intl.message(
      'Yes! Added successfully',
      name: 'success_add',
      desc: '',
      args: [],
    );
  }

  /// `Yes! Updated successfully`
  String get success_update {
    return Intl.message(
      'Yes! Updated successfully',
      name: 'success_update',
      desc: '',
      args: [],
    );
  }

  /// `How do you feel?`
  String get how_you_feel {
    return Intl.message(
      'How do you feel?',
      name: 'how_you_feel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Deleted successfully`
  String get success_delete {
    return Intl.message(
      'Deleted successfully',
      name: 'success_delete',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Please wait...`
  String get please_wait {
    return Intl.message(
      'Please wait...',
      name: 'please_wait',
      desc: '',
      args: [],
    );
  }

  /// `Address not found`
  String get address_not_found {
    return Intl.message(
      'Address not found',
      name: 'address_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Select location`
  String get select_location {
    return Intl.message(
      'Select location',
      name: 'select_location',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Relaxing Sounds`
  String get relaxing_sounds {
    return Intl.message(
      'Relaxing Sounds',
      name: 'relaxing_sounds',
      desc: '',
      args: [],
    );
  }

  /// `Self-Care`
  String get self_care {
    return Intl.message(
      'Self-Care',
      name: 'self_care',
      desc: '',
      args: [],
    );
  }

  /// `Quiz`
  String get quiz {
    return Intl.message(
      'Quiz',
      name: 'quiz',
      desc: '',
      args: [],
    );
  }

  /// `Quote about Mental Health`
  String get mental_health_quote {
    return Intl.message(
      'Quote about Mental Health',
      name: 'mental_health_quote',
      desc: '',
      args: [],
    );
  }

  /// `Start the Quiz`
  String get start_quiz {
    return Intl.message(
      'Start the Quiz',
      name: 'start_quiz',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from {
    return Intl.message(
      'From',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `Complete`
  String get complete {
    return Intl.message(
      'Complete',
      name: 'complete',
      desc: '',
      args: [],
    );
  }

  /// `Your result`
  String get your_result {
    return Intl.message(
      'Your result',
      name: 'your_result',
      desc: '',
      args: [],
    );
  }

  /// `Conclusion`
  String get conclusion {
    return Intl.message(
      'Conclusion',
      name: 'conclusion',
      desc: '',
      args: [],
    );
  }

  /// `Export Pdf`
  String get export_pdf {
    return Intl.message(
      'Export Pdf',
      name: 'export_pdf',
      desc: '',
      args: [],
    );
  }

  /// `Advice`
  String get advice {
    return Intl.message(
      'Advice',
      name: 'advice',
      desc: '',
      args: [],
    );
  }

  /// `Strengths`
  String get strengths {
    return Intl.message(
      'Strengths',
      name: 'strengths',
      desc: '',
      args: [],
    );
  }

  /// `Weaknesses`
  String get weaknesses {
    return Intl.message(
      'Weaknesses',
      name: 'weaknesses',
      desc: '',
      args: [],
    );
  }

  /// `Question`
  String get question {
    return Intl.message(
      'Question',
      name: 'question',
      desc: '',
      args: [],
    );
  }

  /// `Explore`
  String get explore {
    return Intl.message(
      'Explore',
      name: 'explore',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get statistics {
    return Intl.message(
      'Statistics',
      name: 'statistics',
      desc: '',
      args: [],
    );
  }

  /// `Test Results`
  String get test_results {
    return Intl.message(
      'Test Results',
      name: 'test_results',
      desc: '',
      args: [],
    );
  }

  /// `The scores of the tests will be shown here`
  String get test_scores_note {
    return Intl.message(
      'The scores of the tests will be shown here',
      name: 'test_scores_note',
      desc: '',
      args: [],
    );
  }

  /// `Mood Statistics`
  String get mood_statistics {
    return Intl.message(
      'Mood Statistics',
      name: 'mood_statistics',
      desc: '',
      args: [],
    );
  }

  /// `Based on your daily data`
  String get daily_data_note {
    return Intl.message(
      'Based on your daily data',
      name: 'daily_data_note',
      desc: '',
      args: [],
    );
  }

  /// `out of 11`
  String get out_of_total {
    return Intl.message(
      'out of 11',
      name: 'out_of_total',
      desc: '',
      args: [],
    );
  }

  /// `Show All`
  String get show_all {
    return Intl.message(
      'Show All',
      name: 'show_all',
      desc: '',
      args: [],
    );
  }

  /// `Collapse`
  String get collapse {
    return Intl.message(
      'Collapse',
      name: 'collapse',
      desc: '',
      args: [],
    );
  }

  /// `Add Mood Diary`
  String get add_mood_log {
    return Intl.message(
      'Add Mood Diary',
      name: 'add_mood_log',
      desc: '',
      args: [],
    );
  }

  /// `More data is needed for this chart. Please add your diary.`
  String get need_more_data {
    return Intl.message(
      'More data is needed for this chart. Please add your diary.',
      name: 'need_more_data',
      desc: '',
      args: [],
    );
  }

  /// `You have not taken this test yet!`
  String get no_test_taken {
    return Intl.message(
      'You have not taken this test yet!',
      name: 'no_test_taken',
      desc: '',
      args: [],
    );
  }

  /// `Latest Result`
  String get latest_result {
    return Intl.message(
      'Latest Result',
      name: 'latest_result',
      desc: '',
      args: [],
    );
  }

  /// `Results for`
  String get daily_results {
    return Intl.message(
      'Results for',
      name: 'daily_results',
      desc: '',
      args: [],
    );
  }

  /// `Test Result Statistics`
  String get test_result_statistics {
    return Intl.message(
      'Test Result Statistics',
      name: 'test_result_statistics',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Daily Reminder`
  String get daily_reminder {
    return Intl.message(
      'Daily Reminder',
      name: 'daily_reminder',
      desc: '',
      args: [],
    );
  }

  /// `Local Authentication`
  String get local_auth {
    return Intl.message(
      'Local Authentication',
      name: 'local_auth',
      desc: '',
      args: [],
    );
  }

  /// `Backup & Restore`
  String get backup_restore {
    return Intl.message(
      'Backup & Restore',
      name: 'backup_restore',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Emoji`
  String get emoji {
    return Intl.message(
      'Emoji',
      name: 'emoji',
      desc: '',
      args: [],
    );
  }

  /// `Widget`
  String get widget {
    return Intl.message(
      'Widget',
      name: 'widget',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Help Center`
  String get help_center {
    return Intl.message(
      'Help Center',
      name: 'help_center',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contact_us {
    return Intl.message(
      'Contact Us',
      name: 'contact_us',
      desc: '',
      args: [],
    );
  }

  /// `Backup your data to Google Drive in case you forget your password or lose your data.`
  String get backup_data {
    return Intl.message(
      'Backup your data to Google Drive in case you forget your password or lose your data.',
      name: 'backup_data',
      desc: '',
      args: [],
    );
  }

  /// `No backup data available`
  String get no_backup_data {
    return Intl.message(
      'No backup data available',
      name: 'no_backup_data',
      desc: '',
      args: [],
    );
  }

  /// `Backup successful`
  String get backup_success {
    return Intl.message(
      'Backup successful',
      name: 'backup_success',
      desc: '',
      args: [],
    );
  }

  /// `You are not logged into your Google account`
  String get not_logged_in {
    return Intl.message(
      'You are not logged into your Google account',
      name: 'not_logged_in',
      desc: '',
      args: [],
    );
  }

  /// `Backup Reminder`
  String get reminder_backup {
    return Intl.message(
      'Backup Reminder',
      name: 'reminder_backup',
      desc: '',
      args: [],
    );
  }

  /// `Existing Backups`
  String get existing_backups {
    return Intl.message(
      'Existing Backups',
      name: 'existing_backups',
      desc: '',
      args: [],
    );
  }

  /// `You have {count} records`
  String backup_count(Object count) {
    return Intl.message(
      'You have $count records',
      name: 'backup_count',
      desc: '',
      args: [count],
    );
  }

  /// `Backing up data...`
  String get backing_up_data {
    return Intl.message(
      'Backing up data...',
      name: 'backing_up_data',
      desc: '',
      args: [],
    );
  }

  /// `Backup to Google Drive`
  String get backup_to_google_drive {
    return Intl.message(
      'Backup to Google Drive',
      name: 'backup_to_google_drive',
      desc: '',
      args: [],
    );
  }

  /// `Tap to connect your account`
  String get tap_to_connect_account {
    return Intl.message(
      'Tap to connect your account',
      name: 'tap_to_connect_account',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to log out of this account?`
  String get logout_confirmation {
    return Intl.message(
      'Do you want to log out of this account?',
      name: 'logout_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout_confirm {
    return Intl.message(
      'Logout',
      name: 'logout_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Syncing data...`
  String get syncing_data {
    return Intl.message(
      'Syncing data...',
      name: 'syncing_data',
      desc: '',
      args: [],
    );
  }

  /// `Sync completed`
  String get sync_completed {
    return Intl.message(
      'Sync completed',
      name: 'sync_completed',
      desc: '',
      args: [],
    );
  }

  /// `Error! Please try again later`
  String get sync_error {
    return Intl.message(
      'Error! Please try again later',
      name: 'sync_error',
      desc: '',
      args: [],
    );
  }

  /// `Deleting data...`
  String get deleting_data {
    return Intl.message(
      'Deleting data...',
      name: 'deleting_data',
      desc: '',
      args: [],
    );
  }

  /// `Deleted successfully`
  String get deleted_success {
    return Intl.message(
      'Deleted successfully',
      name: 'deleted_success',
      desc: '',
      args: [],
    );
  }

  /// `Error! Please try again later`
  String get delete_error {
    return Intl.message(
      'Error! Please try again later',
      name: 'delete_error',
      desc: '',
      args: [],
    );
  }

  /// `None`
  String get no {
    return Intl.message(
      'None',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Daily`
  String get daily {
    return Intl.message(
      'Daily',
      name: 'daily',
      desc: '',
      args: [],
    );
  }

  /// `Every 3 Days`
  String get every3Days {
    return Intl.message(
      'Every 3 Days',
      name: 'every3Days',
      desc: '',
      args: [],
    );
  }

  /// `Weekly`
  String get weekly {
    return Intl.message(
      'Weekly',
      name: 'weekly',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get monthly {
    return Intl.message(
      'Monthly',
      name: 'monthly',
      desc: '',
      args: [],
    );
  }

  /// `Select reminder time`
  String get selectReminderTime {
    return Intl.message(
      'Select reminder time',
      name: 'selectReminderTime',
      desc: '',
      args: [],
    );
  }

  /// `Existing backups`
  String get existingBackup {
    return Intl.message(
      'Existing backups',
      name: 'existingBackup',
      desc: '',
      args: [],
    );
  }

  /// `No records found`
  String get noRecords {
    return Intl.message(
      'No records found',
      name: 'noRecords',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in all information`
  String get fill_all_info {
    return Intl.message(
      'Please fill in all information',
      name: 'fill_all_info',
      desc: '',
      args: [],
    );
  }

  /// `Cannot delete this item`
  String get cannot_delete {
    return Intl.message(
      'Cannot delete this item',
      name: 'cannot_delete',
      desc: '',
      args: [],
    );
  }

  /// `Reminder Settings`
  String get setup_reminder {
    return Intl.message(
      'Reminder Settings',
      name: 'setup_reminder',
      desc: '',
      args: [],
    );
  }

  /// `Add Daily Reminder`
  String get add_daily_reminder {
    return Intl.message(
      'Add Daily Reminder',
      name: 'add_daily_reminder',
      desc: '',
      args: [],
    );
  }

  /// `Add Reminder`
  String get add_reminder {
    return Intl.message(
      'Add Reminder',
      name: 'add_reminder',
      desc: '',
      args: [],
    );
  }

  /// `Reminder Time`
  String get reminder_time {
    return Intl.message(
      'Reminder Time',
      name: 'reminder_time',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Notification Content`
  String get notification_content {
    return Intl.message(
      'Notification Content',
      name: 'notification_content',
      desc: '',
      args: [],
    );
  }

  /// `Enter text`
  String get enter_text {
    return Intl.message(
      'Enter text',
      name: 'enter_text',
      desc: '',
      args: [],
    );
  }

  /// `Lock Code`
  String get lock_code {
    return Intl.message(
      'Lock Code',
      name: 'lock_code',
      desc: '',
      args: [],
    );
  }

  /// `Set Password`
  String get set_password {
    return Intl.message(
      'Set Password',
      name: 'set_password',
      desc: '',
      args: [],
    );
  }

  /// `Your device does not support this feature`
  String get device_not_supported {
    return Intl.message(
      'Your device does not support this feature',
      name: 'device_not_supported',
      desc: '',
      args: [],
    );
  }

  /// `Use Biometric`
  String get use_biometric {
    return Intl.message(
      'Use Biometric',
      name: 'use_biometric',
      desc: '',
      args: [],
    );
  }

  /// `Enable Biometric Authentication`
  String get enable_biometric_auth {
    return Intl.message(
      'Enable Biometric Authentication',
      name: 'enable_biometric_auth',
      desc: '',
      args: [],
    );
  }

  /// `Authenticate to access the app`
  String get auth_to_access {
    return Intl.message(
      'Authenticate to access the app',
      name: 'auth_to_access',
      desc: '',
      args: [],
    );
  }

  /// `Authentication cancelled`
  String get authentication_cancelled {
    return Intl.message(
      'Authentication cancelled',
      name: 'authentication_cancelled',
      desc: '',
      args: [],
    );
  }

  /// `Device is not enrolled for biometric authentication`
  String get device_not_enrolled {
    return Intl.message(
      'Device is not enrolled for biometric authentication',
      name: 'device_not_enrolled',
      desc: '',
      args: [],
    );
  }

  /// `Authentication error`
  String get authentication_error {
    return Intl.message(
      'Authentication error',
      name: 'authentication_error',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error`
  String get unknown_error {
    return Intl.message(
      'Unknown error',
      name: 'unknown_error',
      desc: '',
      args: [],
    );
  }

  /// `Later`
  String get later {
    return Intl.message(
      'Later',
      name: 'later',
      desc: '',
      args: [],
    );
  }

  /// `Open Settings`
  String get open_settings {
    return Intl.message(
      'Open Settings',
      name: 'open_settings',
      desc: '',
      args: [],
    );
  }

  /// `To use this feature, you need to enable biometric authentication in system settings.`
  String get biometric_auth_message {
    return Intl.message(
      'To use this feature, you need to enable biometric authentication in system settings.',
      name: 'biometric_auth_message',
      desc: '',
      args: [],
    );
  }

  /// `Enter a 4-digit password`
  String get enter_password {
    return Intl.message(
      'Enter a 4-digit password',
      name: 'enter_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get password_mismatch {
    return Intl.message(
      'Passwords do not match',
      name: 'password_mismatch',
      desc: '',
      args: [],
    );
  }

  /// `Authentication failed`
  String get authentication_failed {
    return Intl.message(
      'Authentication failed',
      name: 'authentication_failed',
      desc: '',
      args: [],
    );
  }

  /// `Reset theme`
  String get reset_theme {
    return Intl.message(
      'Reset theme',
      name: 'reset_theme',
      desc: '',
      args: [],
    );
  }

  /// `Preview theme wallpaper`
  String get preview_theme_wallpaper {
    return Intl.message(
      'Preview theme wallpaper',
      name: 'preview_theme_wallpaper',
      desc: '',
      args: [],
    );
  }

  /// `Apply theme`
  String get apply_theme {
    return Intl.message(
      'Apply theme',
      name: 'apply_theme',
      desc: '',
      args: [],
    );
  }

  /// `Preview emoji`
  String get preview_emoji {
    return Intl.message(
      'Preview emoji',
      name: 'preview_emoji',
      desc: '',
      args: [],
    );
  }

  /// `Use it`
  String get use_it {
    return Intl.message(
      'Use it',
      name: 'use_it',
      desc: '',
      args: [],
    );
  }

  /// `Widget`
  String get widgetTitle {
    return Intl.message(
      'Widget',
      name: 'widgetTitle',
      desc: '',
      args: [],
    );
  }

  /// `Guide to adding a widget to your home screen:`
  String get widgetInstructions {
    return Intl.message(
      'Guide to adding a widget to your home screen:',
      name: 'widgetInstructions',
      desc: '',
      args: [],
    );
  }

  /// `1. On the home screen, press and hold on an empty area until a menu appears.`
  String get widgetStep1 {
    return Intl.message(
      '1. On the home screen, press and hold on an empty area until a menu appears.',
      name: 'widgetStep1',
      desc: '',
      args: [],
    );
  }

  /// `2. Tap on Widgets.`
  String get widgetStep2 {
    return Intl.message(
      '2. Tap on Widgets.',
      name: 'widgetStep2',
      desc: '',
      args: [],
    );
  }

  /// `3. Find widgets provided by Oh My Cat. Tap and hold the widget you want to add, then drag and drop it to the appropriate area.`
  String get widgetStep3 {
    return Intl.message(
      '3. Find widgets provided by Oh My Cat. Tap and hold the widget you want to add, then drag and drop it to the appropriate area.',
      name: 'widgetStep3',
      desc: '',
      args: [],
    );
  }

  /// `The evaluation was conducted on {date}`
  String evaluation_date(Object date) {
    return Intl.message(
      'The evaluation was conducted on $date',
      name: 'evaluation_date',
      desc: '',
      args: [date],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Choose Language`
  String get chooseLanguage {
    return Intl.message(
      'Choose Language',
      name: 'chooseLanguage',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

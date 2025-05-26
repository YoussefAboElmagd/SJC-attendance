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

  /// `Don’t have an account ?`
  String get Dont_have_an_account {
    return Intl.message(
      'Don’t have an account ?',
      name: 'Dont_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get Login_button {
    return Intl.message(
      'Login',
      name: 'Login_button',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get Login_text {
    return Intl.message(
      'Login',
      name: 'Login_text',
      desc: '',
      args: [],
    );
  }

  /// `Forgetten password ?`
  String get Forgetten_password {
    return Intl.message(
      'Forgetten password ?',
      name: 'Forgetten_password',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get Email_form_field {
    return Intl.message(
      'Email',
      name: 'Email_form_field',
      desc: '',
      args: [],
    );
  }

  /// `mohamedtamer25@gmail.com`
  String get Email_validator_form_field {
    return Intl.message(
      'mohamedtamer25@gmail.com',
      name: 'Email_validator_form_field',
      desc: '',
      args: [],
    );
  }

  /// `mohamedtamer25@gmail.com`
  String get Email_hint_form_field {
    return Intl.message(
      'mohamedtamer25@gmail.com',
      name: 'Email_hint_form_field',
      desc: '',
      args: [],
    );
  }

  /// `email mustn't be empty`
  String get email_mustnot_be_empty {
    return Intl.message(
      'email mustn\'t be empty',
      name: 'email_mustnot_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `password mustn't be empty`
  String get password_mustnot_be_empty {
    return Intl.message(
      'password mustn\'t be empty',
      name: 'password_mustnot_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get password_text {
    return Intl.message(
      'password',
      name: 'password_text',
      desc: '',
      args: [],
    );
  }

  /// `enter your password`
  String get password_hint_text {
    return Intl.message(
      'enter your password',
      name: 'password_hint_text',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get sign_up {
    return Intl.message(
      'Sign up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Total Working Hour`
  String get Total_Working_Hour {
    return Intl.message(
      'Total Working Hour',
      name: 'Total_Working_Hour',
      desc: '',
      args: [],
    );
  }

  /// `Paid Period`
  String get Paid_Period {
    return Intl.message(
      'Paid Period',
      name: 'Paid_Period',
      desc: '',
      args: [],
    );
  }

  /// `Clock In`
  String get Clock_In {
    return Intl.message(
      'Clock In',
      name: 'Clock_In',
      desc: '',
      args: [],
    );
  }

  /// `Clock Out`
  String get Clock_Out {
    return Intl.message(
      'Clock Out',
      name: 'Clock_Out',
      desc: '',
      args: [],
    );
  }

  /// `Authentication Failed`
  String get Authentication_Failed {
    return Intl.message(
      'Authentication Failed',
      name: 'Authentication_Failed',
      desc: '',
      args: [],
    );
  }

  /// `Biometric authentication failed. Please try again.`
  String get Biometric_authentication_failed_Please_try_again {
    return Intl.message(
      'Biometric authentication failed. Please try again.',
      name: 'Biometric_authentication_failed_Please_try_again',
      desc: '',
      args: [],
    );
  }

  /// `Locked Out`
  String get Locked_Out {
    return Intl.message(
      'Locked Out',
      name: 'Locked_Out',
      desc: '',
      args: [],
    );
  }

  /// `Too many failed attempts. Try again later.`
  String get Too_many_failed_attempts_Try_again_later {
    return Intl.message(
      'Too many failed attempts. Try again later.',
      name: 'Too_many_failed_attempts_Try_again_later',
      desc: '',
      args: [],
    );
  }

  /// `Let’s Clock-In!`
  String get Lets_Clock_In {
    return Intl.message(
      'Let’s Clock-In!',
      name: 'Lets_Clock_In',
      desc: '',
      args: [],
    );
  }

  /// `Don’t miss your clock in schedule`
  String get Dont_miss_your_clock_in_schedule {
    return Intl.message(
      'Don’t miss your clock in schedule',
      name: 'Dont_miss_your_clock_in_schedule',
      desc: '',
      args: [],
    );
  }

  /// `Total Hours`
  String get Total_Hours {
    return Intl.message(
      'Total Hours',
      name: 'Total_Hours',
      desc: '',
      args: [],
    );
  }

  /// `Clock in & Out`
  String get Clock_in_Out {
    return Intl.message(
      'Clock in & Out',
      name: 'Clock_in_Out',
      desc: '',
      args: [],
    );
  }

  /// `No checkIn`
  String get No_checkIn {
    return Intl.message(
      'No checkIn',
      name: 'No_checkIn',
      desc: '',
      args: [],
    );
  }

  /// `No checkout`
  String get No_checkout {
    return Intl.message(
      'No checkout',
      name: 'No_checkout',
      desc: '',
      args: [],
    );
  }

  /// `Today schedule`
  String get Today_schedule {
    return Intl.message(
      'Today schedule',
      name: 'Today_schedule',
      desc: '',
      args: [],
    );
  }

  /// `view month work`
  String get view_month_work {
    return Intl.message(
      'view month work',
      name: 'view_month_work',
      desc: '',
      args: [],
    );
  }

  /// `No date`
  String get No_date {
    return Intl.message(
      'No date',
      name: 'No_date',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get Today {
    return Intl.message(
      'Today',
      name: 'Today',
      desc: '',
      args: [],
    );
  }

  /// `All Month work`
  String get All_Month_work {
    return Intl.message(
      'All Month work',
      name: 'All_Month_work',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get Language_text {
    return Intl.message(
      'Language',
      name: 'Language_text',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get lang_arabic {
    return Intl.message(
      'Arabic',
      name: 'lang_arabic',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get lang_en {
    return Intl.message(
      'English',
      name: 'lang_en',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get sign_button {
    return Intl.message(
      'Sign In',
      name: 'sign_button',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get sign_text {
    return Intl.message(
      'Sign In',
      name: 'sign_text',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to my account`
  String get sign_sub_text {
    return Intl.message(
      'Sign in to my account',
      name: 'sign_sub_text',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get Email {
    return Intl.message(
      'Email',
      name: 'Email',
      desc: '',
      args: [],
    );
  }

  /// `My Email`
  String get Email_hint {
    return Intl.message(
      'My Email',
      name: 'Email_hint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get email_validation {
    return Intl.message(
      'Please enter your email',
      name: 'email_validation',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `My Password`
  String get password_hint {
    return Intl.message(
      'My Password',
      name: 'password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get password_validation {
    return Intl.message(
      'Please enter your password',
      name: 'password_validation',
      desc: '',
      args: [],
    );
  }

  /// `Remember Me`
  String get Remember_Me {
    return Intl.message(
      'Remember Me',
      name: 'Remember_Me',
      desc: '',
      args: [],
    );
  }

  /// `language`
  String get change_language_button {
    return Intl.message(
      'language',
      name: 'change_language_button',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password ?`
  String get Forgot_Password {
    return Intl.message(
      'Forgot Password ?',
      name: 'Forgot_Password',
      desc: '',
      args: [],
    );
  }

  /// `Navigate Your Work\nJourney Efficient & Easy`
  String get on_borading_title {
    return Intl.message(
      'Navigate Your Work\nJourney Efficient & Easy',
      name: 'on_borading_title',
      desc: '',
      args: [],
    );
  }

  /// `Increase your work management & career development radically`
  String get on_borading_sub_title {
    return Intl.message(
      'Increase your work management & career development radically',
      name: 'on_borading_sub_title',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout_button {
    return Intl.message(
      'Logout',
      name: 'logout_button',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no_continue_button {
    return Intl.message(
      'No',
      name: 'no_continue_button',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to logout ?`
  String get logout_and_login_again {
    return Intl.message(
      'Are you sure to logout ?',
      name: 'logout_and_login_again',
      desc: '',
      args: [],
    );
  }

  /// `Working Period`
  String get Working_Period_text {
    return Intl.message(
      'Working Period',
      name: 'Working_Period_text',
      desc: '',
      args: [],
    );
  }

  /// `Month working Period`
  String get month_Working_Period_text {
    return Intl.message(
      'Month working Period',
      name: 'month_Working_Period_text',
      desc: '',
      args: [],
    );
  }

  /// `Your working time in this paid period`
  String get working_time_text {
    return Intl.message(
      'Your working time in this paid period',
      name: 'working_time_text',
      desc: '',
      args: [],
    );
  }

  /// `Your working time in this month`
  String get month_working_time_text {
    return Intl.message(
      'Your working time in this month',
      name: 'month_working_time_text',
      desc: '',
      args: [],
    );
  }

  /// `No Working Time Available`
  String get No_work_entries_available_text {
    return Intl.message(
      'No Working Time Available',
      name: 'No_work_entries_available_text',
      desc: '',
      args: [],
    );
  }

  /// `It looks like you don’t have any working time in this period. Don’t worry, this space will be updated as new working time submitted.`
  String get have_any_working_text {
    return Intl.message(
      'It looks like you don’t have any working time in this period. Don’t worry, this space will be updated as new working time submitted.',
      name: 'have_any_working_text',
      desc: '',
      args: [],
    );
  }

  /// `It looks like you don’t have any working time in this month. Don’t worry, this space will be updated as new working time submitted.`
  String get have_any_month_working_text {
    return Intl.message(
      'It looks like you don’t have any working time in this month. Don’t worry, this space will be updated as new working time submitted.',
      name: 'have_any_month_working_text',
      desc: '',
      args: [],
    );
  }

  /// `No Working Time Available`
  String get No_work_entries_available {
    return Intl.message(
      'No Working Time Available',
      name: 'No_work_entries_available',
      desc: '',
      args: [],
    );
  }

  /// `Would you like to authenticate with your fingerprint instead?`
  String get Would_fingerprint {
    return Intl.message(
      'Would you like to authenticate with your fingerprint instead?',
      name: 'Would_fingerprint',
      desc: '',
      args: [],
    );
  }

  /// `This device supports face recognition. Would you like to authenticate with your face?`
  String get Would_face {
    return Intl.message(
      'This device supports face recognition. Would you like to authenticate with your face?',
      name: 'Would_face',
      desc: '',
      args: [],
    );
  }

  /// `Would you like to authenticate using your device biometrics?`
  String get Would_face_finger {
    return Intl.message(
      'Would you like to authenticate using your device biometrics?',
      name: 'Would_face_finger',
      desc: '',
      args: [],
    );
  }

  /// `Authenticate`
  String get Authenticate_button {
    return Intl.message(
      'Authenticate',
      name: 'Authenticate_button',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get Cancel {
    return Intl.message(
      'Cancel',
      name: 'Cancel',
      desc: '',
      args: [],
    );
  }

  /// `Authentication failed:`
  String get Authentication_failed {
    return Intl.message(
      'Authentication failed:',
      name: 'Authentication_failed',
      desc: '',
      args: [],
    );
  }

  /// `Authentication error:`
  String get Authentication_error {
    return Intl.message(
      'Authentication error:',
      name: 'Authentication_error',
      desc: '',
      args: [],
    );
  }

  /// `Location permissions are denied please allow location to continue`
  String get Location_permissions_denied {
    return Intl.message(
      'Location permissions are denied please allow location to continue',
      name: 'Location_permissions_denied',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred`
  String get An_unexpected_error {
    return Intl.message(
      'An unexpected error occurred',
      name: 'An_unexpected_error',
      desc: '',
      args: [],
    );
  }

  /// `Location services are disabled`
  String get Location_disabled {
    return Intl.message(
      'Location services are disabled',
      name: 'Location_disabled',
      desc: '',
      args: [],
    );
  }

  /// `Location permissions are permanently denied please allow location to continue`
  String get Location_permissions_denied_please {
    return Intl.message(
      'Location permissions are permanently denied please allow location to continue',
      name: 'Location_permissions_denied_please',
      desc: '',
      args: [],
    );
  }

  /// `Expense Summary`
  String get Expense_Summary {
    return Intl.message(
      'Expense Summary',
      name: 'Expense_Summary',
      desc: '',
      args: [],
    );
  }

  /// `Claim your expenses here.`
  String get Claim_expenses {
    return Intl.message(
      'Claim your expenses here.',
      name: 'Claim_expenses',
      desc: '',
      args: [],
    );
  }

  /// `Total Expense`
  String get Total_Expense_Text {
    return Intl.message(
      'Total Expense',
      name: 'Total_Expense_Text',
      desc: '',
      args: [],
    );
  }

  /// `Period text`
  String get Period_text {
    return Intl.message(
      'Period text',
      name: 'Period_text',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get Total_text {
    return Intl.message(
      'Total',
      name: 'Total_text',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get Review_text {
    return Intl.message(
      'Review',
      name: 'Review_text',
      desc: '',
      args: [],
    );
  }

  /// `Approved`
  String get Approved_Text {
    return Intl.message(
      'Approved',
      name: 'Approved_Text',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get Review_Text {
    return Intl.message(
      'Review',
      name: 'Review_Text',
      desc: '',
      args: [],
    );
  }

  /// `Rejected`
  String get Rejected_text {
    return Intl.message(
      'Rejected',
      name: 'Rejected_text',
      desc: '',
      args: [],
    );
  }

  /// `Submit Expense`
  String get Submit_Expense {
    return Intl.message(
      'Submit Expense',
      name: 'Submit_Expense',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get Type_text {
    return Intl.message(
      'Type',
      name: 'Type_text',
      desc: '',
      args: [],
    );
  }

  /// `Ensure All Document Well Prepared`
  String get Ensure_All_Document {
    return Intl.message(
      'Ensure All Document Well Prepared',
      name: 'Ensure_All_Document',
      desc: '',
      args: [],
    );
  }

  /// `1000+ Expenses already approved`
  String get Expenses_approved_text {
    return Intl.message(
      '1000+ Expenses already approved',
      name: 'Expenses_approved_text',
      desc: '',
      args: [],
    );
  }

  /// `Fill Claim Information`
  String get Fill_Claim_Information {
    return Intl.message(
      'Fill Claim Information',
      name: 'Fill_Claim_Information',
      desc: '',
      args: [],
    );
  }

  /// `Information about claim details`
  String get Information_about_claim_details {
    return Intl.message(
      'Information about claim details',
      name: 'Information_about_claim_details',
      desc: '',
      args: [],
    );
  }

  /// `Upload Claim Document`
  String get Upload_Claim_Document {
    return Intl.message(
      'Upload Claim Document',
      name: 'Upload_Claim_Document',
      desc: '',
      args: [],
    );
  }

  /// `Format should be in .pdf .jpeg .png less than 5MB`
  String get Format_should_be_in_pdf {
    return Intl.message(
      'Format should be in .pdf .jpeg .png less than 5MB',
      name: 'Format_should_be_in_pdf',
      desc: '',
      args: [],
    );
  }

  /// `Expense Category`
  String get Expense_Category {
    return Intl.message(
      'Expense Category',
      name: 'Expense_Category',
      desc: '',
      args: [],
    );
  }

  /// `Select Category`
  String get Select_Category {
    return Intl.message(
      'Select Category',
      name: 'Select_Category',
      desc: '',
      args: [],
    );
  }

  /// `Transaction Date`
  String get Transaction_Date {
    return Intl.message(
      'Transaction Date',
      name: 'Transaction_Date',
      desc: '',
      args: [],
    );
  }

  /// `Enter Transaction Date`
  String get Enter_Transaction_Date {
    return Intl.message(
      'Enter Transaction Date',
      name: 'Enter_Transaction_Date',
      desc: '',
      args: [],
    );
  }

  /// `Expense Amount`
  String get Expense_Amount {
    return Intl.message(
      'Expense Amount',
      name: 'Expense_Amount',
      desc: '',
      args: [],
    );
  }

  /// `Enter Amount`
  String get Enter_Amount {
    return Intl.message(
      'Enter Amount',
      name: 'Enter_Amount',
      desc: '',
      args: [],
    );
  }

  /// `Submit Date`
  String get Submit_Date {
    return Intl.message(
      'Submit Date',
      name: 'Submit_Date',
      desc: '',
      args: [],
    );
  }

  /// `Close Message`
  String get Close_Message {
    return Intl.message(
      'Close Message',
      name: 'Close_Message',
      desc: '',
      args: [],
    );
  }

  /// `Expense Description`
  String get Expense_Description {
    return Intl.message(
      'Expense Description',
      name: 'Expense_Description',
      desc: '',
      args: [],
    );
  }

  /// `Select Expense Category`
  String get Select_Expense_Category {
    return Intl.message(
      'Select Expense Category',
      name: 'Select_Expense_Category',
      desc: '',
      args: [],
    );
  }

  /// `Enter Expense Description`
  String get Enter_Expense_Description {
    return Intl.message(
      'Enter Expense Description',
      name: 'Enter_Expense_Description',
      desc: '',
      args: [],
    );
  }

  /// `Select file type`
  String get select_file_type {
    return Intl.message(
      'Select file type',
      name: 'select_file_type',
      desc: '',
      args: [],
    );
  }

  /// `image`
  String get image_text {
    return Intl.message(
      'image',
      name: 'image_text',
      desc: '',
      args: [],
    );
  }

  /// `PDF`
  String get pdf_document {
    return Intl.message(
      'PDF',
      name: 'pdf_document',
      desc: '',
      args: [],
    );
  }

  /// `DOCS`
  String get word_document {
    return Intl.message(
      'DOCS',
      name: 'word_document',
      desc: '',
      args: [],
    );
  }

  /// `Permission denied`
  String get permission_denied {
    return Intl.message(
      'Permission denied',
      name: 'permission_denied',
      desc: '',
      args: [],
    );
  }

  /// `some errors occurred`
  String get error_occurred {
    return Intl.message(
      'some errors occurred',
      name: 'error_occurred',
      desc: '',
      args: [],
    );
  }

  /// `Selected`
  String get selected_text {
    return Intl.message(
      'Selected',
      name: 'selected_text',
      desc: '',
      args: [],
    );
  }

  /// `permission permanently denied`
  String get permission_permanently_denied {
    return Intl.message(
      'permission permanently denied',
      name: 'permission_permanently_denied',
      desc: '',
      args: [],
    );
  }

  /// `settings`
  String get settings {
    return Intl.message(
      'settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close_button {
    return Intl.message(
      'Close',
      name: 'close_button',
      desc: '',
      args: [],
    );
  }

  /// `Leave Summary`
  String get Leave_Summary {
    return Intl.message(
      'Leave Summary',
      name: 'Leave_Summary',
      desc: '',
      args: [],
    );
  }

  /// `Submit Leave`
  String get Submit_Leave_text {
    return Intl.message(
      'Submit Leave',
      name: 'Submit_Leave_text',
      desc: '',
      args: [],
    );
  }

  /// `Total Leave`
  String get Total_Leave {
    return Intl.message(
      'Total Leave',
      name: 'Total_Leave',
      desc: '',
      args: [],
    );
  }

  /// `Available`
  String get Available_text {
    return Intl.message(
      'Available',
      name: 'Available_text',
      desc: '',
      args: [],
    );
  }

  /// `Leave Used`
  String get Leave_Used {
    return Intl.message(
      'Leave Used',
      name: 'Leave_Used',
      desc: '',
      args: [],
    );
  }

  /// `No Leave Submitted!`
  String get No_Leave_Submitted {
    return Intl.message(
      'No Leave Submitted!',
      name: 'No_Leave_Submitted',
      desc: '',
      args: [],
    );
  }

  /// `Ready to catch some fresh air? Click “Submit Leave” and \ntake that well-deserved break!`
  String get Ready_to_catch_some_fresh_air {
    return Intl.message(
      'Ready to catch some fresh air? Click “Submit Leave” and \ntake that well-deserved break!',
      name: 'Ready_to_catch_some_fresh_air',
      desc: '',
      args: [],
    );
  }

  /// `Submit Now`
  String get Submit_Leave_button {
    return Intl.message(
      'Submit Now',
      name: 'Submit_Leave_button',
      desc: '',
      args: [],
    );
  }

  /// `Fill Leave Information`
  String get Fill_Leave_Information {
    return Intl.message(
      'Fill Leave Information',
      name: 'Fill_Leave_Information',
      desc: '',
      args: [],
    );
  }

  /// `Information about leave details`
  String get Information_leave_details {
    return Intl.message(
      'Information about leave details',
      name: 'Information_leave_details',
      desc: '',
      args: [],
    );
  }

  /// `Leave Category`
  String get Leave_Category {
    return Intl.message(
      'Leave Category',
      name: 'Leave_Category',
      desc: '',
      args: [],
    );
  }

  /// `Leave Duration`
  String get Leave_Duration {
    return Intl.message(
      'Leave Duration',
      name: 'Leave_Duration',
      desc: '',
      args: [],
    );
  }

  /// `Task Delegation`
  String get Task_Delegation {
    return Intl.message(
      'Task Delegation',
      name: 'Task_Delegation',
      desc: '',
      args: [],
    );
  }

  /// `Emergency Contact During Leave Period`
  String get Emergency_Period {
    return Intl.message(
      'Emergency Contact During Leave Period',
      name: 'Emergency_Period',
      desc: '',
      args: [],
    );
  }

  /// `Leave Description`
  String get Leave_Description {
    return Intl.message(
      'Leave Description',
      name: 'Leave_Description',
      desc: '',
      args: [],
    );
  }

  /// `Enter Leave Description`
  String get Enter_Leave_Description {
    return Intl.message(
      'Enter Leave Description',
      name: 'Enter_Leave_Description',
      desc: '',
      args: [],
    );
  }

  /// `Select Leave category`
  String get Select_Leave_category {
    return Intl.message(
      'Select Leave category',
      name: 'Select_Leave_category',
      desc: '',
      args: [],
    );
  }

  /// `Leave Date`
  String get Leave_Date {
    return Intl.message(
      'Leave Date',
      name: 'Leave_Date',
      desc: '',
      args: [],
    );
  }

  /// `Select Duration`
  String get Select_Duration {
    return Intl.message(
      'Select Duration',
      name: 'Select_Duration',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home_text {
    return Intl.message(
      'Home',
      name: 'home_text',
      desc: '',
      args: [],
    );
  }

  /// `Challanges Awaiting`
  String get challanges_awaiting {
    return Intl.message(
      'Challanges Awaiting',
      name: 'challanges_awaiting',
      desc: '',
      args: [],
    );
  }

  /// `Let’s tackle your to do list`
  String get Lets_tackle_your_to_do_list {
    return Intl.message(
      'Let’s tackle your to do list',
      name: 'Lets_tackle_your_to_do_list',
      desc: '',
      args: [],
    );
  }

  /// `Summary of Your Work`
  String get Summary_of_Your_Work {
    return Intl.message(
      'Summary of Your Work',
      name: 'Summary_of_Your_Work',
      desc: '',
      args: [],
    );
  }

  /// `Your current task progress`
  String get current_task_progress {
    return Intl.message(
      'Your current task progress',
      name: 'current_task_progress',
      desc: '',
      args: [],
    );
  }

  /// `To Do`
  String get To_Do {
    return Intl.message(
      'To Do',
      name: 'To_Do',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get Done_text {
    return Intl.message(
      'Done',
      name: 'Done_text',
      desc: '',
      args: [],
    );
  }

  /// `Sprint 20 - Burnout Stats`
  String get Sprint_Burnout_Stats {
    return Intl.message(
      'Sprint 20 - Burnout Stats',
      name: 'Sprint_Burnout_Stats',
      desc: '',
      args: [],
    );
  }

  /// `You've completed 8 more tasks than usual, maintain your task with your supervisor`
  String get completed_tasks_maintain {
    return Intl.message(
      'You\'ve completed 8 more tasks than usual, maintain your task with your supervisor',
      name: 'completed_tasks_maintain',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get All_text {
    return Intl.message(
      'All',
      name: 'All_text',
      desc: '',
      args: [],
    );
  }

  /// `In Progress`
  String get In_Progress_text {
    return Intl.message(
      'In Progress',
      name: 'In_Progress_text',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get Finish_text {
    return Intl.message(
      'Finish',
      name: 'Finish_text',
      desc: '',
      args: [],
    );
  }

  /// `Wiring Dashboard Analytics`
  String get Wiring_Dashboard_Analytics {
    return Intl.message(
      'Wiring Dashboard Analytics',
      name: 'Wiring_Dashboard_Analytics',
      desc: '',
      args: [],
    );
  }

  /// `Create Task`
  String get Create_Task_button {
    return Intl.message(
      'Create Task',
      name: 'Create_Task_button',
      desc: '',
      args: [],
    );
  }

  /// `Create New Task`
  String get Create_New_Task {
    return Intl.message(
      'Create New Task',
      name: 'Create_New_Task',
      desc: '',
      args: [],
    );
  }

  /// `Attachment`
  String get Attachment_text {
    return Intl.message(
      'Attachment',
      name: 'Attachment_text',
      desc: '',
      args: [],
    );
  }

  /// `Format should be in .pdf .jpeg .png less than 5MB`
  String get Format_should_MB {
    return Intl.message(
      'Format should be in .pdf .jpeg .png less than 5MB',
      name: 'Format_should_MB',
      desc: '',
      args: [],
    );
  }

  /// `Task Title`
  String get Task_Title {
    return Intl.message(
      'Task Title',
      name: 'Task_Title',
      desc: '',
      args: [],
    );
  }

  /// `Enter Task Title`
  String get Enter_Task_Title {
    return Intl.message(
      'Enter Task Title',
      name: 'Enter_Task_Title',
      desc: '',
      args: [],
    );
  }

  /// `Task Description`
  String get Task_Description {
    return Intl.message(
      'Task Description',
      name: 'Task_Description',
      desc: '',
      args: [],
    );
  }

  /// `Enter Task Description`
  String get Enter_Task_Description {
    return Intl.message(
      'Enter Task Description',
      name: 'Enter_Task_Description',
      desc: '',
      args: [],
    );
  }

  /// `Assign To`
  String get Assign_To {
    return Intl.message(
      'Assign To',
      name: 'Assign_To',
      desc: '',
      args: [],
    );
  }

  /// `Select Member`
  String get Select_Member {
    return Intl.message(
      'Select Member',
      name: 'Select_Member',
      desc: '',
      args: [],
    );
  }

  /// `Priority`
  String get Priority {
    return Intl.message(
      'Priority',
      name: 'Priority',
      desc: '',
      args: [],
    );
  }

  /// `Select Priority`
  String get Select_Priority {
    return Intl.message(
      'Select Priority',
      name: 'Select_Priority',
      desc: '',
      args: [],
    );
  }

  /// `Tags`
  String get Tags {
    return Intl.message(
      'Tags',
      name: 'Tags',
      desc: '',
      args: [],
    );
  }

  /// `Select tag`
  String get Select_tag {
    return Intl.message(
      'Select tag',
      name: 'Select_tag',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'Task Details' key

  /// `amount`
  String get amount {
    return Intl.message(
      'amount',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Department`
  String get Department_text {
    return Intl.message(
      'Department',
      name: 'Department_text',
      desc: '',
      args: [],
    );
  }

  /// `Request type`
  String get Request_type {
    return Intl.message(
      'Request type',
      name: 'Request_type',
      desc: '',
      args: [],
    );
  }

  /// `Select Department`
  String get Select_Department {
    return Intl.message(
      'Select Department',
      name: 'Select_Department',
      desc: '',
      args: [],
    );
  }

  /// `Enter Department`
  String get Enter_Department {
    return Intl.message(
      'Enter Department',
      name: 'Enter_Department',
      desc: '',
      args: [],
    );
  }

  /// `Select Request type`
  String get Select_Request_type {
    return Intl.message(
      'Select Request type',
      name: 'Select_Request_type',
      desc: '',
      args: [],
    );
  }

  /// `Enter Request type`
  String get Enter_Request_type {
    return Intl.message(
      'Enter Request type',
      name: 'Enter_Request_type',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get new_section_text {
    return Intl.message(
      'New',
      name: 'new_section_text',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get Pending_section_text {
    return Intl.message(
      'Pending',
      name: 'Pending_section_text',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done_section_text {
    return Intl.message(
      'Done',
      name: 'done_section_text',
      desc: '',
      args: [],
    );
  }

  /// `Expenses Details`
  String get Expenses_Details {
    return Intl.message(
      'Expenses Details',
      name: 'Expenses_Details',
      desc: '',
      args: [],
    );
  }

  /// `mustn't be empty`
  String get mustnot_be_empty {
    return Intl.message(
      'mustn\'t be empty',
      name: 'mustnot_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `Successfully sent expenses`
  String get Successfully_sent_expenses {
    return Intl.message(
      'Successfully sent expenses',
      name: 'Successfully_sent_expenses',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '' key
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
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

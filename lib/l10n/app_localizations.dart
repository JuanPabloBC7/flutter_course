import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @accountSection.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT'**
  String get accountSection;

  /// No description provided for @addContact.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addContact;

  /// No description provided for @addToBag.
  ///
  /// In en, this message translates to:
  /// **'Add to bag'**
  String get addToBag;

  /// No description provided for @bamWallet.
  ///
  /// In en, this message translates to:
  /// **'BAM Wallet'**
  String get bamWallet;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @cartCount.
  ///
  /// In en, this message translates to:
  /// **'Cart - {count} items'**
  String cartCount(int count);

  /// No description provided for @emptyCart.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get emptyCart;

  /// No description provided for @noFavoritesYet.
  ///
  /// In en, this message translates to:
  /// **'No favorites yet'**
  String get noFavoritesYet;

  /// No description provided for @checkSpamFolder.
  ///
  /// In en, this message translates to:
  /// **'Check your spam folder if you don\'t see the email'**
  String get checkSpamFolder;

  /// No description provided for @colorLabel.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get colorLabel;

  /// No description provided for @configAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get configAbout;

  /// No description provided for @configAboutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get configAboutSubtitle;

  /// No description provided for @configAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get configAppearance;

  /// No description provided for @configAppearanceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Colors and layout'**
  String get configAppearanceSubtitle;

  /// No description provided for @configAutoSave.
  ///
  /// In en, this message translates to:
  /// **'Auto-Save'**
  String get configAutoSave;

  /// No description provided for @configAutoSaveSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Save transactions automatically'**
  String get configAutoSaveSubtitle;

  /// No description provided for @configBiometricLogin.
  ///
  /// In en, this message translates to:
  /// **'Biometric Login'**
  String get configBiometricLogin;

  /// No description provided for @configBiometricLoginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use fingerprint or face ID'**
  String get configBiometricLoginSubtitle;

  /// No description provided for @configChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get configChangePassword;

  /// No description provided for @configChangePasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update your credentials'**
  String get configChangePasswordSubtitle;

  /// No description provided for @configContactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get configContactSupport;

  /// No description provided for @configContactSupportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get in touch with us'**
  String get configContactSupportSubtitle;

  /// No description provided for @configDataStorage.
  ///
  /// In en, this message translates to:
  /// **'DATA & STORAGE'**
  String get configDataStorage;

  /// No description provided for @configDarkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get configDarkMode;

  /// No description provided for @configDarkModeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Switch appearance theme'**
  String get configDarkModeSubtitle;

  /// No description provided for @configExportData.
  ///
  /// In en, this message translates to:
  /// **'Export Data'**
  String get configExportData;

  /// No description provided for @configExportDataSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Download your information'**
  String get configExportDataSubtitle;

  /// No description provided for @configGeneral.
  ///
  /// In en, this message translates to:
  /// **'GENERAL'**
  String get configGeneral;

  /// No description provided for @configHelpCenter.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get configHelpCenter;

  /// No description provided for @configHelpCenterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'FAQ and guides'**
  String get configHelpCenterSubtitle;

  /// No description provided for @configLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get configLanguage;

  /// No description provided for @configNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get configNotifications;

  /// No description provided for @configNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Push and in-app alerts'**
  String get configNotificationsSubtitle;

  /// No description provided for @configSecurity.
  ///
  /// In en, this message translates to:
  /// **'SECURITY'**
  String get configSecurity;

  /// No description provided for @configStorageUsage.
  ///
  /// In en, this message translates to:
  /// **'Storage Usage'**
  String get configStorageUsage;

  /// No description provided for @configStorageUsageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'24.5 MB used'**
  String get configStorageUsageSubtitle;

  /// No description provided for @configSupport.
  ///
  /// In en, this message translates to:
  /// **'SUPPORT'**
  String get configSupport;

  /// No description provided for @configTitle.
  ///
  /// In en, this message translates to:
  /// **'Configuration'**
  String get configTitle;

  /// No description provided for @configTwoFactorAuth.
  ///
  /// In en, this message translates to:
  /// **'Two-Factor Auth'**
  String get configTwoFactorAuth;

  /// No description provided for @configTwoFactorAuthSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Extra layer of security'**
  String get configTwoFactorAuthSubtitle;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteAccountDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone. All your data will be permanently removed.'**
  String get deleteAccountDialogMessage;

  /// No description provided for @deleteAccountDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Account?'**
  String get deleteAccountDialogTitle;

  /// No description provided for @ecommerceTitle.
  ///
  /// In en, this message translates to:
  /// **'E-Commerce'**
  String get ecommerceTitle;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailSent.
  ///
  /// In en, this message translates to:
  /// **'Email Sent!'**
  String get emailSent;

  /// No description provided for @emailSentDescription.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent a password reset link to your email address. Please check your inbox.'**
  String get emailSentDescription;

  /// No description provided for @errorLoadingProducts.
  ///
  /// In en, this message translates to:
  /// **'Error loading products'**
  String get errorLoadingProducts;

  /// No description provided for @favoritesCount.
  ///
  /// In en, this message translates to:
  /// **'Favorites - {count} items'**
  String favoritesCount(int count);

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @filterExpenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get filterExpenses;

  /// No description provided for @filterIncome.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get filterIncome;

  /// No description provided for @filterTransactions.
  ///
  /// In en, this message translates to:
  /// **'Filter Transactions'**
  String get filterTransactions;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get goBack;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get goodEvening;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get goodMorning;

  /// No description provided for @historyTitle.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get historyTitle;

  /// No description provided for @interestDesignSystems.
  ///
  /// In en, this message translates to:
  /// **'Design Systems'**
  String get interestDesignSystems;

  /// No description provided for @interestResearch.
  ///
  /// In en, this message translates to:
  /// **'User Research'**
  String get interestResearch;

  /// No description provided for @interestServiceDesign.
  ///
  /// In en, this message translates to:
  /// **'Service Design'**
  String get interestServiceDesign;

  /// No description provided for @interestStrategy.
  ///
  /// In en, this message translates to:
  /// **'Strategy'**
  String get interestStrategy;

  /// No description provided for @interestTesting.
  ///
  /// In en, this message translates to:
  /// **'User Testing'**
  String get interestTesting;

  /// No description provided for @interestUI.
  ///
  /// In en, this message translates to:
  /// **'User Interface'**
  String get interestUI;

  /// No description provided for @interestUX.
  ///
  /// In en, this message translates to:
  /// **'User Experience'**
  String get interestUX;

  /// No description provided for @interestUXWriting.
  ///
  /// In en, this message translates to:
  /// **'UX Writing'**
  String get interestUXWriting;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English (US)'**
  String get languageEnglish;

  /// No description provided for @languageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Español'**
  String get languageSpanish;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Success!'**
  String get loginSuccess;

  /// No description provided for @loginSuccessRedirecting.
  ///
  /// In en, this message translates to:
  /// **'Login successful! Redirecting...'**
  String get loginSuccessRedirecting;

  /// No description provided for @menuAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get menuAbout;

  /// No description provided for @menuAboutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get menuAboutSubtitle;

  /// No description provided for @menuConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Configuration'**
  String get menuConfiguration;

  /// No description provided for @menuConfigurationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'App settings and preferences'**
  String get menuConfigurationSubtitle;

  /// No description provided for @menuContactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get menuContactUs;

  /// No description provided for @menuContactUsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get in touch with support'**
  String get menuContactUsSubtitle;

  /// No description provided for @menuDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get menuDashboard;

  /// No description provided for @menuDashboardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Overview and statistics'**
  String get menuDashboardSubtitle;

  /// No description provided for @menuEcommerce.
  ///
  /// In en, this message translates to:
  /// **'E-Commerce'**
  String get menuEcommerce;

  /// No description provided for @menuEcommerceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Browse products and shop'**
  String get menuEcommerceSubtitle;

  /// No description provided for @menuHelpCenter.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get menuHelpCenter;

  /// No description provided for @menuHelpCenterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'FAQ and guides'**
  String get menuHelpCenterSubtitle;

  /// No description provided for @menuHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get menuHistory;

  /// No description provided for @menuHistorySubtitle.
  ///
  /// In en, this message translates to:
  /// **'View past transactions'**
  String get menuHistorySubtitle;

  /// No description provided for @menuLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get menuLanguage;

  /// No description provided for @menuNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get menuNotifications;

  /// No description provided for @menuNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your alerts'**
  String get menuNotificationsSubtitle;

  /// No description provided for @menuPrivacySecurity.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security'**
  String get menuPrivacySecurity;

  /// No description provided for @menuPrivacySecuritySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Protect your account'**
  String get menuPrivacySecuritySubtitle;

  /// No description provided for @menuProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get menuProfile;

  /// No description provided for @menuProfileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View and edit your profile'**
  String get menuProfileSubtitle;

  /// No description provided for @menuTitle.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menuTitle;

  /// No description provided for @menuTransfers.
  ///
  /// In en, this message translates to:
  /// **'Transfers'**
  String get menuTransfers;

  /// No description provided for @menuTransfersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Send and receive transfers'**
  String get menuTransfersSubtitle;

  /// No description provided for @navigation.
  ///
  /// In en, this message translates to:
  /// **'NAVIGATION'**
  String get navigation;

  /// No description provided for @navCart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get navCart;

  /// No description provided for @navDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get navDashboard;

  /// No description provided for @navExplore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get navExplore;

  /// No description provided for @navFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get navFavorites;

  /// No description provided for @navHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get navHistory;

  /// No description provided for @navMenu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get navMenu;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @navTransfers.
  ///
  /// In en, this message translates to:
  /// **'Transfers'**
  String get navTransfers;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @noFilteredTransactions.
  ///
  /// In en, this message translates to:
  /// **'No {filter} transactions found'**
  String noFilteredTransactions(String filter);

  /// No description provided for @noTransactionsYet.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet'**
  String get noTransactionsYet;

  /// No description provided for @onboardingInterestsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your interests.'**
  String get onboardingInterestsSubtitle;

  /// No description provided for @onboardingInterestsTitle.
  ///
  /// In en, this message translates to:
  /// **'Personalise your\nexperience'**
  String get onboardingInterestsTitle;

  /// No description provided for @onboardingSubtitle1.
  ///
  /// In en, this message translates to:
  /// **'Enjoy these pre-made components and worry only about creating the best product ever.'**
  String get onboardingSubtitle1;

  /// No description provided for @onboardingSubtitle3.
  ///
  /// In en, this message translates to:
  /// **'Your data is protected with industry-standard encryption and biometric authentication.'**
  String get onboardingSubtitle3;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Create a prototype in just a few minutes'**
  String get onboardingTitle1;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Secure and reliable banking'**
  String get onboardingTitle3;

  /// No description provided for @optionBankTransfer.
  ///
  /// In en, this message translates to:
  /// **'Bank Transfer'**
  String get optionBankTransfer;

  /// No description provided for @optionBankTransferSubtitle.
  ///
  /// In en, this message translates to:
  /// **'To bank account'**
  String get optionBankTransferSubtitle;

  /// No description provided for @optionInternational.
  ///
  /// In en, this message translates to:
  /// **'International'**
  String get optionInternational;

  /// No description provided for @optionInternationalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Send abroad'**
  String get optionInternationalSubtitle;

  /// No description provided for @optionMobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get optionMobile;

  /// No description provided for @optionMobileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'To phone number'**
  String get optionMobileSubtitle;

  /// No description provided for @optionQRCode.
  ///
  /// In en, this message translates to:
  /// **'QR Code'**
  String get optionQRCode;

  /// No description provided for @optionQRCodeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Scan to pay'**
  String get optionQRCodeSubtitle;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'or continue with'**
  String get orContinueWith;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @productAddedToCart.
  ///
  /// In en, this message translates to:
  /// **'{name} added to cart!'**
  String productAddedToCart(String name);

  /// No description provided for @productDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get productDescription;

  /// No description provided for @productNotFound.
  ///
  /// In en, this message translates to:
  /// **'Product not found'**
  String get productNotFound;

  /// No description provided for @productDescriptionText.
  ///
  /// In en, this message translates to:
  /// **'The perfect T-shirt for when you want to feel comfortable but still stylish. Amazing for all occasions. Made of 100% cotton fabric in your colours. Its modern style gives a lighter look to the outfit. Perfect for the warmest days.'**
  String get productDescriptionText;

  /// No description provided for @profileAccountSettings.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT SETTINGS'**
  String get profileAccountSettings;

  /// No description provided for @profileActiveSessions.
  ///
  /// In en, this message translates to:
  /// **'Active Sessions'**
  String get profileActiveSessions;

  /// No description provided for @profileActiveSessionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'2 devices connected'**
  String get profileActiveSessionsSubtitle;

  /// No description provided for @profileBiometricAuth.
  ///
  /// In en, this message translates to:
  /// **'Biometric Authentication'**
  String get profileBiometricAuth;

  /// No description provided for @profileBiometricAuthSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Fingerprint and Face ID'**
  String get profileBiometricAuthSubtitle;

  /// No description provided for @profileChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get profileChangePassword;

  /// No description provided for @profileChangePasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update your credentials'**
  String get profileChangePasswordSubtitle;

  /// No description provided for @profileDangerZone.
  ///
  /// In en, this message translates to:
  /// **'DANGER ZONE'**
  String get profileDangerZone;

  /// No description provided for @profileDateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get profileDateOfBirth;

  /// No description provided for @profileDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get profileDeleteAccount;

  /// No description provided for @profileDeleteAccountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Permanently remove your data'**
  String get profileDeleteAccountSubtitle;

  /// No description provided for @profileEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get profileEmail;

  /// No description provided for @profileFullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get profileFullName;

  /// No description provided for @profileLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profileLanguage;

  /// No description provided for @profileLogOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get profileLogOut;

  /// No description provided for @profileLogOutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign out of your account'**
  String get profileLogOutSubtitle;

  /// No description provided for @profileNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get profileNotifications;

  /// No description provided for @profileNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage push notifications'**
  String get profileNotificationsSubtitle;

  /// No description provided for @profilePersonalInfo.
  ///
  /// In en, this message translates to:
  /// **'PERSONAL INFORMATION'**
  String get profilePersonalInfo;

  /// No description provided for @profilePhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get profilePhoneNumber;

  /// No description provided for @profileSecurity.
  ///
  /// In en, this message translates to:
  /// **'SECURITY'**
  String get profileSecurity;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileTwoFactorAuth.
  ///
  /// In en, this message translates to:
  /// **'Two-Factor Authentication'**
  String get profileTwoFactorAuth;

  /// No description provided for @profileTwoFactorAuthSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Extra layer of security'**
  String get profileTwoFactorAuthSubtitle;

  /// No description provided for @profileUsername.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get profileUsername;

  /// No description provided for @quickActionReceive.
  ///
  /// In en, this message translates to:
  /// **'Receive'**
  String get quickActionReceive;

  /// No description provided for @quickActionScan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get quickActionScan;

  /// No description provided for @quickActionSend.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get quickActionSend;

  /// No description provided for @quickActionTransfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get quickActionTransfer;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @resetPasswordDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address and we\'ll send you a link to reset your password.'**
  String get resetPasswordDescription;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @routeNotFound.
  ///
  /// In en, this message translates to:
  /// **'Route not found: {uri}'**
  String routeNotFound(String uri);

  /// No description provided for @searchProductsPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search products...'**
  String get searchProductsPlaceholder;

  /// No description provided for @sectionForThisSummer.
  ///
  /// In en, this message translates to:
  /// **'For this summer'**
  String get sectionForThisSummer;

  /// No description provided for @sectionFrequentContacts.
  ///
  /// In en, this message translates to:
  /// **'FREQUENT CONTACTS'**
  String get sectionFrequentContacts;

  /// No description provided for @sectionOverview.
  ///
  /// In en, this message translates to:
  /// **'OVERVIEW'**
  String get sectionOverview;

  /// No description provided for @sectionPerfectForYou.
  ///
  /// In en, this message translates to:
  /// **'Perfect for you'**
  String get sectionPerfectForYou;

  /// No description provided for @sectionRecentTransactions.
  ///
  /// In en, this message translates to:
  /// **'RECENT TRANSACTIONS'**
  String get sectionRecentTransactions;

  /// No description provided for @sectionRecentTransfers.
  ///
  /// In en, this message translates to:
  /// **'RECENT TRANSFERS'**
  String get sectionRecentTransfers;

  /// No description provided for @sectionTransferOptions.
  ///
  /// In en, this message translates to:
  /// **'TRANSFER OPTIONS'**
  String get sectionTransferOptions;

  /// No description provided for @secureBanking.
  ///
  /// In en, this message translates to:
  /// **'Secure Banking'**
  String get secureBanking;

  /// No description provided for @seeMore.
  ///
  /// In en, this message translates to:
  /// **'See more'**
  String get seeMore;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @sendMoney.
  ///
  /// In en, this message translates to:
  /// **'Send Money'**
  String get sendMoney;

  /// No description provided for @sendMoneySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Transfer to anyone, anywhere'**
  String get sendMoneySubtitle;

  /// No description provided for @showAllTransactions.
  ///
  /// In en, this message translates to:
  /// **'Show all transactions'**
  String get showAllTransactions;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your credentials to continue'**
  String get signInSubtitle;

  /// No description provided for @sizeLabel.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get sizeLabel;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @statExpenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get statExpenses;

  /// No description provided for @statExpensesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'-3.2% vs last month'**
  String get statExpensesSubtitle;

  /// No description provided for @statIncome.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get statIncome;

  /// No description provided for @statIncomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'+12.5% vs last month'**
  String get statIncomeSubtitle;

  /// No description provided for @statSavings.
  ///
  /// In en, this message translates to:
  /// **'Savings'**
  String get statSavings;

  /// No description provided for @statSavingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Goal: \$5,000'**
  String get statSavingsSubtitle;

  /// No description provided for @statTransactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get statTransactions;

  /// No description provided for @statTransactionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get statTransactionsSubtitle;

  /// No description provided for @statusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get statusCompleted;

  /// No description provided for @statusFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get statusFailed;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @supportSection.
  ///
  /// In en, this message translates to:
  /// **'SUPPORT'**
  String get supportSection;

  /// No description provided for @thisMonth.
  ///
  /// In en, this message translates to:
  /// **'this month'**
  String get thisMonth;

  /// No description provided for @toastCameraAccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Camera permission is required to scan QR codes.'**
  String get toastCameraAccessMessage;

  /// No description provided for @toastCameraAccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Camera Access'**
  String get toastCameraAccessTitle;

  /// No description provided for @toastReceiveMoneyMessage.
  ///
  /// In en, this message translates to:
  /// **'Share your account details to receive funds.'**
  String get toastReceiveMoneyMessage;

  /// No description provided for @toastReceiveMoneyTitle.
  ///
  /// In en, this message translates to:
  /// **'Receive Money'**
  String get toastReceiveMoneyTitle;

  /// No description provided for @toastSendMoneyMessage.
  ///
  /// In en, this message translates to:
  /// **'Your transfer has been initiated successfully.'**
  String get toastSendMoneyMessage;

  /// No description provided for @toastSendMoneyTitle.
  ///
  /// In en, this message translates to:
  /// **'Send Money'**
  String get toastSendMoneyTitle;

  /// No description provided for @toastTransferLimitMessage.
  ///
  /// In en, this message translates to:
  /// **'Daily transfer limit is \$10,000. Contact support to increase.'**
  String get toastTransferLimitMessage;

  /// No description provided for @toastTransferLimitTitle.
  ///
  /// In en, this message translates to:
  /// **'Transfer Limit'**
  String get toastTransferLimitTitle;

  /// No description provided for @totalBalance.
  ///
  /// In en, this message translates to:
  /// **'Total Balance'**
  String get totalBalance;

  /// No description provided for @transactionHistoryWillAppear.
  ///
  /// In en, this message translates to:
  /// **'Your transaction history will appear here'**
  String get transactionHistoryWillAppear;

  /// No description provided for @transfersTitle.
  ///
  /// In en, this message translates to:
  /// **'Transfers'**
  String get transfersTitle;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred.'**
  String get unexpectedError;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get welcome;

  /// No description provided for @welcomeQuote.
  ///
  /// In en, this message translates to:
  /// **'Press the Forgot password? link or the Login button to navigate within the app.'**
  String get welcomeQuote;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

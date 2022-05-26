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

  /// `Let's sign you in.`
  String get letsSignYouIn {
    return Intl.message(
      'Let\'s sign you in.',
      name: 'letsSignYouIn',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back.\nWe missed you!`
  String get welcomeBackWeMissedYou {
    return Intl.message(
      'Welcome back.\nWe missed you!',
      name: 'welcomeBackWeMissedYou',
      desc: '',
      args: [],
    );
  }

  /// `Create Account!`
  String get createAccount {
    return Intl.message(
      'Create Account!',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
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

  /// `Don't have an account?  `
  String get dontHaveAnAccount {
    return Intl.message(
      'Don\'t have an account?  ',
      name: 'dontHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Buyer`
  String get buyer {
    return Intl.message(
      'Buyer',
      name: 'buyer',
      desc: '',
      args: [],
    );
  }

  /// `Seller`
  String get seller {
    return Intl.message(
      'Seller',
      name: 'seller',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Shop by Brand`
  String get shopByBrand {
    return Intl.message(
      'Shop by Brand',
      name: 'shopByBrand',
      desc: '',
      args: [],
    );
  }

  /// `No Selected Products`
  String get noSelectedProducts {
    return Intl.message(
      'No Selected Products',
      name: 'noSelectedProducts',
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

  /// `Delete Product`
  String get deleteProduct {
    return Intl.message(
      'Delete Product',
      name: 'deleteProduct',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this product?`
  String get areYouSureYouWantToDeleteThisProduct {
    return Intl.message(
      'Are you sure you want to delete this product?',
      name: 'areYouSureYouWantToDeleteThisProduct',
      desc: '',
      args: [],
    );
  }

  /// `Approve`
  String get approve {
    return Intl.message(
      'Approve',
      name: 'approve',
      desc: '',
      args: [],
    );
  }

  /// `Add your magical product!`
  String get addYourMagicalProduct {
    return Intl.message(
      'Add your magical product!',
      name: 'addYourMagicalProduct',
      desc: '',
      args: [],
    );
  }

  /// `Brand & model`
  String get brandModel {
    return Intl.message(
      'Brand & model',
      name: 'brandModel',
      desc: '',
      args: [],
    );
  }

  /// `Short description`
  String get shortDescription {
    return Intl.message(
      'Short description',
      name: 'shortDescription',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Add Product`
  String get addProduct {
    return Intl.message(
      'Add Product',
      name: 'addProduct',
      desc: '',
      args: [],
    );
  }

  /// `Choose available sizes`
  String get chooseAvailableSizes {
    return Intl.message(
      'Choose available sizes',
      name: 'chooseAvailableSizes',
      desc: '',
      args: [],
    );
  }

  /// `Select all`
  String get selectAll {
    return Intl.message(
      'Select all',
      name: 'selectAll',
      desc: '',
      args: [],
    );
  }

  /// `Select photos`
  String get selectPhotos {
    return Intl.message(
      'Select photos',
      name: 'selectPhotos',
      desc: '',
      args: [],
    );
  }

  /// `You can choose only four pictures`
  String get youCanChooseOnlyFourPictures {
    return Intl.message(
      'You can choose only four pictures',
      name: 'youCanChooseOnlyFourPictures',
      desc: '',
      args: [],
    );
  }

  /// `Unnamed Album`
  String get unnamedAlbum {
    return Intl.message(
      'Unnamed Album',
      name: 'unnamedAlbum',
      desc: '',
      args: [],
    );
  }

  /// `Size Guide`
  String get sizeGuide {
    return Intl.message(
      'Size Guide',
      name: 'sizeGuide',
      desc: '',
      args: [],
    );
  }

  /// `Choose your size`
  String get chooseYourSize {
    return Intl.message(
      'Choose your size',
      name: 'chooseYourSize',
      desc: '',
      args: [],
    );
  }

  /// `Go to cart`
  String get goToCart {
    return Intl.message(
      'Go to cart',
      name: 'goToCart',
      desc: '',
      args: [],
    );
  }

  /// `Add to cart`
  String get addToCart {
    return Intl.message(
      'Add to cart',
      name: 'addToCart',
      desc: '',
      args: [],
    );
  }

  /// `Your Cart`
  String get yourCart {
    return Intl.message(
      'Your Cart',
      name: 'yourCart',
      desc: '',
      args: [],
    );
  }

  /// `Cart is empty`
  String get cartIsEmpty {
    return Intl.message(
      'Cart is empty',
      name: 'cartIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Please add some products`
  String get pleaseAddedSomeProducts {
    return Intl.message(
      'Please add some products',
      name: 'pleaseAddedSomeProducts',
      desc: '',
      args: [],
    );
  }

  /// `Buying success!`
  String get buyingSuccess {
    return Intl.message(
      'Buying success!',
      name: 'buyingSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Have a good day.`
  String get haveAGoodDay {
    return Intl.message(
      'Have a good day.',
      name: 'haveAGoodDay',
      desc: '',
      args: [],
    );
  }

  /// `Buy`
  String get buy {
    return Intl.message(
      'Buy',
      name: 'buy',
      desc: '',
      args: [],
    );
  }

  /// `Data updated`
  String get dataUpdated {
    return Intl.message(
      'Data updated',
      name: 'dataUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Select size`
  String get selectSize {
    return Intl.message(
      'Select size',
      name: 'selectSize',
      desc: '',
      args: [],
    );
  }

  /// `Show all`
  String get showAll {
    return Intl.message(
      'Show all',
      name: 'showAll',
      desc: '',
      args: [],
    );
  }

  /// `Processing Data...`
  String get processingData {
    return Intl.message(
      'Processing Data...',
      name: 'processingData',
      desc: '',
      args: [],
    );
  }

  /// `Data Error`
  String get dataError {
    return Intl.message(
      'Data Error',
      name: 'dataError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter some text`
  String get pleaseEnterSomeText {
    return Intl.message(
      'Please enter some text',
      name: 'pleaseEnterSomeText',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter More Than Three Characters`
  String get pleaseEnterMoreThanThreeCharacters {
    return Intl.message(
      'Please Enter More Than Three Characters',
      name: 'pleaseEnterMoreThanThreeCharacters',
      desc: '',
      args: [],
    );
  }

  /// `Invalid state`
  String get invalidState {
    return Intl.message(
      'Invalid state',
      name: 'invalidState',
      desc: '',
      args: [],
    );
  }

  /// `User is not exist`
  String get userIsNotExist {
    return Intl.message(
      'User is not exist',
      name: 'userIsNotExist',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
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
      Locale.fromSubtags(languageCode: 'ru'),
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

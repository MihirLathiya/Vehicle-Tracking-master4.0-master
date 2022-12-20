import 'package:get_storage/get_storage.dart';

class PreferenceManager {
  static GetStorage getStorage = GetStorage();

  static String loginStatus = "loginStatus";
  static String accountNo = "accountNo";
  static String name = "name";
  static String email = "email";
  static String whatsApp = "whatsApp";
  static String number = "number";
  static String companyName = "companyName";
  static String barier = "barier";
  static String companyAddress = "companyAddress";
  static String placeId = "placeId";
  static String name1 = "name1";
  static String placeName = "placeName";
  static String duration = "duration";

  ///Device Id

  static Future setLogin(bool value) async {
    await getStorage.write(loginStatus, value);
  }

  static getLogin() {
    return getStorage.read(loginStatus);
  }

  /// NAME

  static Future setName(String value) async {
    await getStorage.write(name, value);
  }

  static getName() {
    return getStorage.read(name);
  }

  static Future setName1(String value) async {
    await getStorage.write(name1, value);
  }

  static getName1() {
    return getStorage.read(name1);
  }

  /// NAME

  static Future setDuration(String value) async {
    await getStorage.write(duration, value);
  }

  static getDuration() {
    return getStorage.read(duration);
  }

  /// PLACE ID

  static Future setPlaceId(String value) async {
    await getStorage.write(placeId, value);
  }

  static getPlaceId() {
    return getStorage.read(placeId);
  }

  /// PLACE NAME

  static Future setPlaceName(String value) async {
    await getStorage.write(placeName, value);
  }

  static getPlaceName() {
    return getStorage.read(placeName);
  }

  /// NAME

  static Future setBariear(String value) async {
    await getStorage.write(barier, value);
  }

  static getBariear() {
    return getStorage.read(barier);
  }

  /// NUMBER

  static Future setNumber(String value) async {
    await getStorage.write(number, value);
  }

  static getNumber() {
    return getStorage.read(number);
  }

  /// EMAIL

  static Future setEmail(String value) async {
    await getStorage.write(email, value);
  }

  static getEmail() {
    return getStorage.read(email);
  }

  /// WHATS APP

  static Future setWhatsApp(String value) async {
    await getStorage.write(whatsApp, value);
  }

  static getWhatsApp() {
    return getStorage.read(whatsApp);
  }

  /// COMPANY NAME

  static Future setCompanyName(String value) async {
    await getStorage.write(companyName, value);
  }

  static getCompanyName() {
    return getStorage.read(companyName);
  }

  /// COMPANT ADDRESS

  static Future setCompanyAddress(String value) async {
    await getStorage.write(companyAddress, value);
  }

  static getCompanyAddress() {
    return getStorage.read(companyAddress);
  }

  /// ACCOUNT NO

  static Future setAccountNo(String value) async {
    await getStorage.write(accountNo, value);
  }

  static getAccountNo() {
    return getStorage.read(accountNo);
  }

  static Future getClear() {
    return getStorage.erase();
  }
}

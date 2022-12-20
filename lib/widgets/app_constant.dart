class Constant {
  static final API_URL = 'https://i.invoiceapi.ml/api/customer/';

  static Uri getUrl(String url) {
    return Uri.parse(url);
  }

  static final USER_REGISTER = 'register';
  static final CREATE_PASSWORD = 'createPassword';
}

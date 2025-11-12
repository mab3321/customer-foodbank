class Setting {
  Setting({
    this.status,
    this.data,
  });

  Setting.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? SettingData.fromJson(json['data']) : null;
  }
  int? status;
  SettingData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class SettingData {
  SettingData({
    this.siteName,
    this.siteEmail,
    this.sitePhoneNumber,
    this.siteDescription,
    this.stripeKey,
    this.stripeSecret,
    this.googleMapApiKey,
    this.currencyName,
    this.currencyCode,
    this.siteLogo,
    this.customerAppName,
    this.customerAppLogo,
    this.supportPhone,
    this.paystacKey,
    this.razorpayKey,
    this.razorpaySecret,
  });

  SettingData.fromJson(dynamic json) {
    siteName = json['site_name'];
    siteEmail = json['site_email'];
    sitePhoneNumber = json['site_phone_number'];
    siteDescription = json['site_description'];
    stripeKey = json['stripe_key'];
    stripeSecret = json['stripe_secret'];
    paystacKey = json['paystack_key'];
    razorpayKey = json['razorpay_key'];
    razorpaySecret = json['razorpay_secret'];
    googleMapApiKey = json['google_map_api_key'];
    currencyName = json['currency_name'];
    currencyCode = json['currency_code'];
    siteLogo = json['site_logo'];
    customerAppName = json['customer_app_name'];
    customerAppLogo = json['customer_app_logo'];
    supportPhone = json['support_phone'];
  }
  String? siteName;
  String? siteEmail;
  String? sitePhoneNumber;
  String? siteDescription;
  String? paystacKey;
  String? razorpayKey;
  String? razorpaySecret;
  String? stripeKey;
  String? stripeSecret;
  String? googleMapApiKey;
  String? currencyName;
  String? currencyCode;
  String? siteLogo;
  String? customerAppName;
  String? customerAppLogo;
  String? supportPhone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['site_name'] = siteName;
    map['site_email'] = siteEmail;
    map['site_phone_number'] = sitePhoneNumber;
    map['site_description'] = siteDescription;
    map['stripe_key'] = stripeKey;
    map['stripe_secret'] = stripeSecret;
    map['stripe_secret'] = stripeSecret;
    map['paystack_key'] = paystacKey;
    map['razorpay_key'] = razorpayKey;
    map['razorpay_secret'] = razorpaySecret;
    map['google_map_api_key'] = googleMapApiKey;
    map['currency_name'] = currencyName;
    map['currency_code'] = currencyCode;
    map['site_logo'] = siteLogo;
    map['customer_app_name'] = customerAppName;
    map['customer_app_logo'] = customerAppLogo;
    map['support_phone'] = supportPhone;
    return map;
  }
}

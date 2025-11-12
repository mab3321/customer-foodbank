class RazorPay {
  String? email;
  String? phone;
  String? adress;
  String? description;
  int? amount;
  String? name;
  String? latitude;
  String? longitude;
  String? razorpayKey;
  String? razorpaySecret;
  int? orderTypeSelect;

  RazorPay(
      {this.email,
      this.phone,
      this.razorpaySecret,
      this.razorpayKey,
      this.description,
      this.amount,
      this.name,
      this.latitude,
      this.longitude,
      this.orderTypeSelect,
      this.adress});
}

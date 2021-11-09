class Donation {
  int donationID;
  String donationName;
  String date;
  List donationCategories;
  List donationQuantities;
  String imgPath;
  String status;

  Donation(
      {this.donationID,
      this.donationName,
      this.date,
      this.donationCategories,
      this.donationQuantities,
      this.imgPath,
      this.status});

  factory Donation.fromJSON(Map<String, dynamic> data) {
    return Donation(
        donationID: data['donationID'],
        donationName: data['donationName'],
        date: data['date'],
        donationCategories: data['donationCategories'],
        donationQuantities: data['donationQuantities'],
        imgPath: data['imgPath'],
        status: data['status']);
  }
}

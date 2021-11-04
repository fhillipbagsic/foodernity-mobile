class Donation {
  int donationID;
  String donationName;
  String dateTimePosted;
  List donationCategories;
  List donationQuantities;
  List donationExpiries;
  String imgPath;
  String status;

  Donation(
      {this.donationID,
      this.donationName,
      this.dateTimePosted,
      this.donationCategories,
      this.donationQuantities,
      this.donationExpiries,
      this.imgPath,
      this.status});
}

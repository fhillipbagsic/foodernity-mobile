class Announcement {
  final int distributedDonationID;
  final String donationImage;
  final String date;
  final String donationRecipient;
  final List donationCategory;
  final List donationQuantity;
  final String recipientLocation;
  final String donationRemarks;

  Announcement(
      {this.distributedDonationID,
      this.donationImage,
      this.date,
      this.donationRecipient,
      this.donationCategory,
      this.donationQuantity,
      this.recipientLocation,
      this.donationRemarks});

  factory Announcement.fromJSON(Map<String, dynamic> data) {
    return Announcement(
        distributedDonationID: data['distributedDonationID'],
        donationImage: data['donationImage'],
        date: data['date'],
        donationRecipient: data['donationRecipient'],
        donationCategory: data['donationCategory'],
        donationQuantity: data['donationQuantity'],
        recipientLocation: data['recipientLocation'],
        donationRemarks: data['donationRemarks']);
  }
}

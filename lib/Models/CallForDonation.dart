class CallForDonation {
  final int callForDonationID;
  final String title;
  final String imgPath;
  final String description;
  final String date;

  CallForDonation(
      {this.callForDonationID,
      this.title,
      this.imgPath,
      this.description,
      this.date});

  factory CallForDonation.fromJSON(Map<String, dynamic> data) {
    return CallForDonation(
        callForDonationID: data['callForDonationID'],
        title: data['title'],
        imgPath: data['imgPath'],
        description: data['description'],
        date: data['date']);
  }
}

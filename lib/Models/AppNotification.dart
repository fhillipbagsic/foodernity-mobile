class AppNotification {
  int notificationID;
  int donationID;
  String donorEmail;
  String donationName;
  String notificationMessage;

  AppNotification(
      {this.notificationID,
      this.donationID,
      this.donorEmail,
      this.donationName,
      this.notificationMessage});

  factory AppNotification.fromJSON(Map<String, dynamic> data) {
    return AppNotification(
      notificationID: data['notificationID'],
      donationID: data['donationID'],
      donorEmail: data['donorEmail'],
      donationName: data['donorEmail'],
      notificationMessage: data['notificationMessage'],
    );
  }
}

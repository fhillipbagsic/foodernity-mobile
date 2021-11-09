import 'package:flutter/material.dart';
import 'package:my_app/Models/Donation.dart';
import 'package:my_app/Pages/MyDonations/donation_detail.dart';

class DonationItem extends StatefulWidget {
  final Donation donation;

  const DonationItem({this.donation});

  @override
  _DonationItemState createState() => _DonationItemState();
}

class _DonationItemState extends State<DonationItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      margin: EdgeInsets.symmetric(vertical: 5.0),
      color: Colors.white,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image.network(
              widget.donation.imgPath,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.only(left: 10.0),
            // color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.donation.donationName,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 3,
                ),
                _getStatus(widget.donation.status),
                SizedBox(
                  height: 3,
                ),
                _getDescription(widget.donation.status),
                SizedBox(
                  height: 3,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DonationDetail(
                          donation: widget.donation,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'View more',
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(33, 150, 243, 1),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 15.0,
                          color: Color.fromRGBO(33, 150, 243, 1),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}

Widget _getStatus(String status) {
  switch (status) {
    case 'pending':
      return _status(Icons.hourglass_full_rounded, 'Pending Donation',
          Color.fromRGBO(33, 150, 243, 1));
    case 'accepted':
      return _status(Icons.check_circle_rounded, 'Donation Accepted',
          Color.fromRGBO(102, 187, 106, 1));
    case 'received':
      return _status(Icons.inventory, 'Donation Received',
          Color.fromRGBO(255, 167, 38, 1));
    default:
      return _status(Icons.warning, 'Error', Colors.black);
  }
}

Widget _status(icon, description, color) {
  return (Row(
    children: [
      Icon(
        icon,
        color: color,
        size: 15.0,
      ),
      SizedBox(
        width: 2.0,
      ),
      Text(
        description,
        style: TextStyle(
            color: color, fontWeight: FontWeight.bold, fontSize: 14.0),
      ),
    ],
  ));
}

Widget _getDescription(String status) {
  switch (status) {
    case 'pending':
      return _description('The food bank is still reviewing your donation.');
    case 'accepted':
      return _description('You can now proceed to deliver your donation.');
    case 'received':
      return _description(
          'Your donation has been received by the organization.');
    default:
      return _description('Error');
  }
}

Widget _description(description) {
  return Text(
    description,
    style: TextStyle(fontSize: 13.0),
  );
}

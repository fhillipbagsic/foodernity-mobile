import 'package:flutter/material.dart';
import 'package:my_app/Models/Announcement.dart';
import 'package:my_app/Pages/Announcement/announcement_detail.dart';
import 'package:sizer/sizer.dart';

class AnnouncementItem extends StatelessWidget {
  final Announcement announcement;

  const AnnouncementItem({this.announcement});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    children: [
                      Image.network(
                        announcement.donationImage,
                        width: 100.w,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      ListTile(
                        title: Text(
                          announcement.date,
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 12),
                        ),
                        subtitle: Text(
                          announcement.donationRecipient,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                              color: Colors.grey[600]),
                        ),
                        trailing: Wrap(
                          spacing: 1,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ListingDetails(
                                      announcement: announcement,
                                    ),
                                  ),
                                );
                              },
                              child: Icon(Icons.navigate_next_sharp,
                                  color: Colors.blue),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}


/*

Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        announcement.date,
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 12),
                      ),
                      subtitle: Text(
                        announcement.donationRecipient,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                            color: Colors.grey[600]),
                      ),
                      trailing: Wrap(
                        spacing: 1,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ListingDetails(
                                            announcement: announcement,
                                          )));
                            },
                            child: Icon(Icons.navigate_next_sharp,
                                color: Colors.blue),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ), */
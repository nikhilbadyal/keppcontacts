import 'package:flutter/material.dart';

class ContactSingleInfoRow extends StatelessWidget {
  const ContactSingleInfoRow(
      {required this.singleInfo, required this.singleIcon, required this.info})
      : super();

  final String singleInfo;
  final String info;
  final IconData singleIcon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(top: 6, left: 24, bottom: 6),
      leading: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Icon(
          singleIcon,
          size: 28,
        ),
      ),
      title: Text("$info"),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Text("$singleInfo",style: TextStyle(fontWeight: FontWeight.bold),),
      ),
    );
  }
}

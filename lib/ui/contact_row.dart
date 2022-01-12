import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:keepcontacts/pages/singlecontact_page.dart';

class ContactRow extends StatefulWidget {
  final Contact contact;
  final Function(Contact contact) setStateCaller;

  ContactRow(this.contact, this.setStateCaller) : super();

  @override
  _ContactRowState createState() => _ContactRowState();
}

class _ContactRowState extends State<ContactRow> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SingleContactPage(
              contact: this.widget.contact,
              setStateCaller: widget.setStateCaller,
            ),
          ),
        );
      },
      leading:
          (widget.contact.avatar != null && widget.contact.avatar!.length > 0)
              ? CircleAvatar(
                  backgroundImage: MemoryImage(widget.contact.avatar!),
                  maxRadius: 20,
                )
              : widget.contact.initials().isEmpty
                  ? CircleAvatar(
                      maxRadius: 20,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/images/user.png'),
                    )
                  : CircleAvatar(
                      maxRadius: 20,
                      // backgroundColor: Colors.white,
                      child: onPic(),
                    ),
      contentPadding: EdgeInsets.only(top: 6, left: 16, bottom: 6),
      title: Text(
        "${widget.contact.displayName}",
        style: TextStyle(color: Colors.white),
      ),
      subtitle: widget.contact.phones!.length > 0
          ? Text(
              "${widget.contact.phones!.elementAt(0).value}",
              style: TextStyle(color: Colors.white70),
            )
          : null,
      trailing: Padding(
        padding: const EdgeInsets.only(right: 24),
        child: Icon(
          Icons.phone_outlined,
          size: 28,
        ),
      ),
    );
  }

  Widget onPic() {
    var name = widget.contact.initials();
    return Text(name);
  }
}

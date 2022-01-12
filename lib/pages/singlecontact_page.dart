import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keepcontacts/ui/contact_singleinfo_row.dart';
import 'package:pedantic/pedantic.dart';

class SingleContactPage extends StatelessWidget {
  final Contact contact;
  final Function(Contact contact) setStateCaller;

  SingleContactPage({required this.contact, required this.setStateCaller})
      : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              unawaited(ContactsService.deleteContact(contact));
              Navigator.of(context).pop();
              setStateCaller(contact);
            },
          ),
        ],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Center(
            child: (contact.avatar != null && contact.avatar!.length > 0)
                ? CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: MemoryImage(contact.avatar!),
                    maxRadius: 48,
                  )
                : contact.initials().isEmpty
                    ? CircleAvatar(
                        backgroundColor: Colors.transparent,
                        maxRadius: 48,
                        backgroundImage: AssetImage('assets/images/user.png'),
                      )
                    : CircleAvatar(
                        maxRadius: 48,
                        backgroundColor: Colors.transparent,
                        // backgroundColor: Colors.white,
                        child: onPic(),
                      ),
          ),
          SizedBox(
            height: 16,
          ),
          Column(children: [
            Text(
              "${contact.displayName}",
              style: Theme.of(context).textTheme.headline1,
            ),
          ]),
          SizedBox(
            height: 16,
          ),
          ContactSingleInfoRow(
            info: 'Name',
            singleInfo: contact.givenName ?? "",
            singleIcon: Icons.account_circle_outlined,
          ),
          ContactSingleInfoRow(
            info: 'Middle Name',
            singleInfo: contact.middleName ?? "",
            singleIcon: Icons.account_circle_outlined,
          ),
          ContactSingleInfoRow(
            info: 'Prefix',
            singleInfo: contact.prefix ?? "",
            singleIcon: Icons.account_circle_outlined,
          ),
          ContactSingleInfoRow(
            info: 'Suffix',
            singleInfo: contact.suffix ?? "",
            singleIcon: Icons.account_circle_outlined,
          ),
          ContactSingleInfoRow(
            info: 'Family Name',
            singleInfo: contact.familyName ?? "",
            singleIcon: Icons.account_circle_outlined,
          ),
          SizedBox(
            height: 16,
          ),
          ContactSingleInfoRow(
            info: 'Birthday',
            singleInfo: contact.birthday != null
                ? DateFormat('dd-MM-yyyy')
                    .format(contact.birthday ?? DateTime.now())
                : "",
            singleIcon: Icons.account_circle_outlined,
          ),
          ContactSingleInfoRow(
            info: 'Account Type',
            singleInfo: (contact.androidAccountType != null)
                ? contact.androidAccountName.toString()
                : "",
            singleIcon: Icons.account_circle_outlined,
          ),
          ContactSingleInfoRow(
            info: 'Account Type',
            singleInfo: (contact.androidAccountType != null)
                ? contact.androidAccountTypeRaw.toString()
                : "",
            singleIcon: Icons.account_circle_outlined,
          ),
          ContactSingleInfoRow(
            info: 'Account Type',
            singleInfo: (contact.androidAccountType != null)
                ? contact.androidAccountType.toString()
                : "",
            singleIcon: Icons.account_circle_outlined,
          ),
          ContactSingleInfoRow(
            info: 'Job',
            singleInfo: contact.jobTitle ?? "",
            singleIcon: Icons.account_circle_outlined,
          ),
          ContactSingleInfoRow(
            info: 'Company',
            singleInfo: contact.company ?? "",
            singleIcon: Icons.account_circle_outlined,
          ),
          SizedBox(
            height: 16,
          ),
          ItemsTile("Emails", contact.emails ?? []),
          ItemsTile("Phones", contact.phones ?? []),
          AddressesTile(contact.postalAddresses ?? []),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 28,
          ),
          ContactSingleInfoRow(
            info: 'Display Name',
            singleInfo: "@${contact.displayName}",
            singleIcon: Icons.account_circle_outlined,
          )
        ]),
      ),
    );
  }

  Widget onPic() {
    var name = contact.initials();
    return Text(name);
  }

  getEmail() {
    var str = contact.emails == null
        ? "No Email"
        : contact.emails!.length > 0
            ? contact.emails!.elementAt(0).value
            : "No Email";
    return str;
  }
}

class ItemsTile extends StatelessWidget {
  ItemsTile(this._title, this._items);

  final Iterable<Item> _items;
  final String _title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(title: Text(_title)),
        Column(
          children: _items
              .map(
                (i) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListTile(
                    title: Text(i.label ?? ""),
                    trailing: Text(i.value ?? ""),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class AddressesTile extends StatelessWidget {
  AddressesTile(this._addresses);

  final Iterable<PostalAddress> _addresses;

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(title: Text("Addresses")),
        Column(
          children: _addresses
              .map((a) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text("Street"),
                          trailing: Text(a.street ?? ""),
                        ),
                        ListTile(
                          title: Text("Postcode"),
                          trailing: Text(a.postcode ?? ""),
                        ),
                        ListTile(
                          title: Text("City"),
                          trailing: Text(a.city ?? ""),
                        ),
                        ListTile(
                          title: Text("Region"),
                          trailing: Text(a.region ?? ""),
                        ),
                        ListTile(
                          title: Text("Country"),
                          trailing: Text(a.country ?? ""),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

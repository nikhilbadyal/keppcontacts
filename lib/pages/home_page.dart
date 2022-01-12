import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:keepcontacts/ui/contact_row.dart';

class ContactsApp extends StatelessWidget {
  ContactsApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[900],
        brightness: Brightness.dark,
        primaryColor: Colors.green,
        accentColor: Colors.greenAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 24, color: Colors.white),
          headline6: TextStyle(fontSize: 16, color: Colors.green),
        ),
      ),
      home: MyHomePage(
        title: 'Contact',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future myFuture = Future(() {});
  List<Contact>? contacts;

  void callSetState(Contact contact) {
    setState(() {
      contacts!.removeWhere((c) => c.identifier == contact.identifier);
    });
  }

  Future getContacts() async {
    contacts = (await ContactsService.getContacts()).toList();
  }

  @override
  void initState() {
    myFuture = getContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: myFuture,
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.done &&
            contacts != null) {
          return body(context);
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }

  Widget body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //TODO
        /*actions: [
          Icon(
            Icons.search,
            size: 26,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Icon(
              Icons.more_vert,
              size: 26,
            ),
          ),
        ],*/
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Text(
                    "Contacts",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: contacts!.length,
              itemBuilder: (BuildContext context, int index) {
                Contact _thisPerson = contacts!.elementAt(index);
                if (isEmptyContact(_thisPerson)) {
                  return Container(
                    width: 0,
                    height: 0,
                  );
                }
                return ContactRow(_thisPerson, callSetState);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.person_add_alt_1),
      ),
    );
  }

  bool isEmptyContact(Contact thisPerson) {
    return thisPerson.displayName == null &&
        thisPerson.familyName == null &&
        thisPerson.prefix == null &&
        thisPerson.suffix == null &&
        thisPerson.givenName == null &&
        (thisPerson.phones == null || thisPerson.phones!.length == 0) &&
        (thisPerson.emails == null || thisPerson.emails!.length == 0);
  }
}

import 'package:crud/Model/Contact.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Contact> contacts = List.empty(growable: true);
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(
                  'assets/icons/phone-call.png',
                  width: 40,
                  height: 40,
                ),
              ),
              Text(
                'ContactCatalog',
                style: TextStyle(color: Colors.white, fontFamily: 'Open Sans'),
              ),
            ],
          ),
          backgroundColor: Color.fromRGBO(94, 7, 110, 0.863),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Contact Name',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: numberController,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                  hintText: 'Contact Number',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        String name = nameController.text.trim();
                        String contact = numberController.text.trim();
                        if (name.isNotEmpty && contact.isNotEmpty) {
                          setState(() {
                            nameController.text = '';
                            numberController.text = '';
                            contacts.add(Contact(name: name, contact: contact));
                          });
                        }
                      },
                      child: Text('SAVE',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  ElevatedButton(
                      onPressed: () {
                        String name = nameController.text.trim();
                        String contact = numberController.text.trim();

                        if (name.isNotEmpty && contact.isNotEmpty) {
                          setState(() {
                            nameController.text = '';
                            numberController.text = '';
                            contacts[selectedIndex].name = name;
                            contacts[selectedIndex].contact = contact;
                            selectedIndex = -1;
                          });
                        }
                      },
                      child: Text('UPDATE',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
              SizedBox(
                height: 100,
              ),
              contacts.isEmpty
                  ? Center(
                      child: Text('No Contact yet',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.grey)))
                  : Expanded(
                      child: ListView.builder(
                        itemCount: contacts.length,
                        itemBuilder: (context, index) => getRow(index),
                      ),
                    ),
            ],
          ),
        ));
  }

  Widget getRow(int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListTile(
          leading: CircleAvatar(
            child: Text(contacts[index].name[0]),
            backgroundColor: index % 2 == 0 ? Colors.pink : Colors.purple,
            foregroundColor: Colors.white,
          ),
          title:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              contacts[index].name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(contacts[index].contact),
          ]),
          trailing: SizedBox(
            width: 60,
            child: Row(children: [
              InkWell(
                onTap: () {
                  nameController.text = contacts[index].name;
                  numberController.text = contacts[index].contact;
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Icon(Icons.edit),
              ),
              SizedBox(width: 10),
              InkWell(
                onTap: () {
                  setState(() {
                    contacts.removeAt(index);
                  });
                },
                child: Icon(Icons.delete),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

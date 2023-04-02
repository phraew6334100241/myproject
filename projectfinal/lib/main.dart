import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectfinal/screens/create_account_screen.dart';
import 'package:projectfinal/screens/login_screen.dart';
import 'package:projectfinal/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectfinal/screens/new_item_screen.dart';
import 'package:projectfinal/screens/edit_item_scren.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyProject',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Color.fromARGB(
              255, 38, 126, 169), // กำหนดสี background ของ AppBar
        ),
        fontFamily: 'Kanit',
      ),
      home: LoginScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _searchController = TextEditingController();
  String searchText = '';

  @override
  void initState() {
    super.initState();
    _searchController.text = '';
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchItem() {
    setState(() {
      searchText = _searchController.text.toLowerCase().trim();
    });
  }

  bool _isItemMatched(DocumentSnapshot item) {
    if (searchText.isEmpty) {
      return true;
    }
    final name = item["name"] as String;
    return name.toLowerCase().contains(searchText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: _searchItem,
            icon: const Icon(Icons.search),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'ค้นหารายชื่อผู้ป่วย',
              ),
              controller: _searchController,
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("items").snapshots(),
        builder: ((context, snapshot) {
          final dataDocuments = snapshot.data?.docs;
          if (dataDocuments == null) return const Text("No data");
          final filteredItems = dataDocuments.where(_isItemMatched).toList();
          if (filteredItems.isEmpty) return const Text("ไม่พบข้อมูลคนไข้");
          return ListView.builder(
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              final item = filteredItems[index];
              return ListTile(
                title: Text(item["name"].toString()),
                onTap: () => _editItemScreen(
                  item.id,
                  item["name"],
                  item["old"],
                  item["weight"],
                  item["high"],
                  item["Cond"],
                  item["phonenumber"],
                  item["address"],
                  item["gender"],
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewItem,
        tooltip: 'สร้างประวัติคนไข้ใหม่',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _createNewItem() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NewItemScreen()));
  }

  _editItemScreen(
    String documentid,
    String itemName,
    String itemOld,
    String itemWeight,
    String itemHigh,
    String itemCond,
    String itemPhone,
    String itemAdd,
    String itemGender,
  ) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditItemScreen(
                  documentid,
                  itemName,
                  itemOld,
                  itemWeight,
                  itemHigh,
                  itemCond,
                  itemPhone,
                  itemAdd,
                  itemGender,
                )));
  }
}

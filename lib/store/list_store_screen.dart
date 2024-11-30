import 'package:app_packtrack/process_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:app_packtrack/store/add_store_screen.dart'; // Import màn hình AddStoreScreen

class StoreListScreen extends StatefulWidget {
  @override
  _StoreListScreenState createState() => _StoreListScreenState();
}

class _StoreListScreenState extends State<StoreListScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _databaseRef =
      FirebaseDatabase.instance.ref().child('users');

  List<Map> stores = [];

  @override
  void initState() {
    super.initState();
    _fetchStores();
  }

  void _fetchStores() async {
    String uid = _auth.currentUser!.uid; // Lấy UID của người dùng hiện tại

    DataSnapshot snapshot = await _databaseRef.child(uid).child('stores').get();

    if (snapshot.exists) {
      Map<dynamic, dynamic> storeData = snapshot.value as Map<dynamic, dynamic>;
      setState(() {
        stores = storeData.entries.map((entry) {
          return {
            'storeName': entry.value['storeName'],
            'storePhone': entry.value['storePhone'],
            'storeAddress': entry.value['storeAddress'],
          };
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cửa Hàng', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Chuyển đến màn hình thêm cửa hàng và chờ màn hình quay lại
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AddStoreScreen(onStoreAdded: _fetchStores)),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Tìm kiếm cửa hàng...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: stores.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                leading: Icon(
                  Icons.store,
                  size: 40,
                  color: Colors.blueAccent,
                ),
                title: Text(
                  stores[index]['storeName'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Địa chỉ: ${stores[index]['storeAddress']}',
                      style: TextStyle(color: Colors.black54),
                    ),
                    Text(
                      'SĐT: ${stores[index]['storePhone']}',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProcessScreen()),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:app_packtrack/store_screen.dart'; // Import màn hình AddStoreScreen

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
        title: Text('Danh Sách Cửa Hàng'),
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
      ),
      body: ListView.builder(
        itemCount: stores.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(stores[index]['storeName']),
            subtitle: Text(
              'Phone: ${stores[index]['storePhone']}, Address: ${stores[index]['storeAddress']}',
            ),
          );
        },
      ),
    );
  }
}

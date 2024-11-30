import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddStoreScreen extends StatefulWidget {
  final Function onStoreAdded; // Callback function to update the store list

  AddStoreScreen({required this.onStoreAdded});

  @override
  _AddStoreScreenState createState() => _AddStoreScreenState();
}

class _AddStoreScreenState extends State<AddStoreScreen> {
  final TextEditingController _storeNameController = TextEditingController();
  final TextEditingController _storePhoneController = TextEditingController();
  final TextEditingController _storeAddressController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _databaseRef =
      FirebaseDatabase.instance.ref().child('users');

  void _addStore() async {
    String storeName = _storeNameController.text;
    String storePhone = _storePhoneController.text;
    String storeAddress = _storeAddressController.text;

    if (storeName.isEmpty || storePhone.isEmpty || storeAddress.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vui lòng điền đầy đủ thông tin cửa hàng.')),
      );
      return;
    }

    String uid = _auth.currentUser!.uid; // Lấy UID của người dùng hiện tại

    // Thêm cửa hàng vào Firebase
    DatabaseReference storeRef = _databaseRef.child(uid).child('stores').push();
    await storeRef.set({
      'storeName': storeName,
      'storePhone': storePhone,
      'storeAddress': storeAddress,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Cửa hàng đã được thêm thành công!')),
    );

    // Gọi callback để cập nhật danh sách cửa hàng
    widget.onStoreAdded();

    // Quay lại màn hình danh sách cửa hàng sau khi thêm cửa hàng mới
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Thêm Cửa Hàng')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _storeNameController,
              decoration: InputDecoration(
                labelText: 'Tên Cửa Hàng',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _storePhoneController,
              decoration: InputDecoration(
                labelText: 'Số Điện Thoại',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _storeAddressController,
              decoration: InputDecoration(
                labelText: 'Địa Chỉ',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _addStore,
              child: Text('Thêm Cửa Hàng'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

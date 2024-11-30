import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MyAccountScreen extends StatefulWidget {
  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  // Thực hiện tải dữ liệu từ Firebase Realtime Database
  Future<Map<String, String>> _getUserData() async {
    User? user = FirebaseAuth.instance.currentUser; // Lấy người dùng hiện tại

    if (user == null) {
      // Nếu người dùng chưa đăng nhập
      throw Exception('Người dùng chưa đăng nhập');
    }

    try {
      // Lấy dữ liệu của người dùng từ Realtime Database bằng UID
      final DatabaseReference userRef = FirebaseDatabase.instance
          .ref() // Sử dụng ref() thay vì reference()
          .child('users')
          .child(user.uid); // UID của người dùng hiện tại

      DataSnapshot snapshot =
          await userRef.get(); // Sử dụng get() thay vì once()

      // Kiểm tra nếu dữ liệu người dùng tồn tại
      if (snapshot.value == null) {
        throw Exception('Dữ liệu người dùng không tồn tại');
      }

      // Kiểm tra xem snapshot.value có phải là một Map hay không
      if (snapshot.value is Map) {
        // Chuyển dữ liệu thành Map<String, dynamic>
        Map<dynamic, dynamic> userMap = snapshot.value as Map<dynamic, dynamic>;

        // Trả về dữ liệu dưới dạng Map<String, String>
        return {
          'name': userMap['name'] ?? 'Chưa có tên',
          'phone': userMap['phone'] ?? 'Chưa có số điện thoại',
          'email': userMap['email'] ?? 'Chưa có email',
        };
      } else {
        throw Exception('Dữ liệu không đúng định dạng');
      }
    } catch (e) {
      throw Exception('Lỗi tải dữ liệu: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tài Khoản Của Tôi"),
      ),
      body: FutureBuilder<Map<String, String>>(
        future: _getUserData(), // Lấy dữ liệu từ Realtime Database
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi tải dữ liệu: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Không có dữ liệu'));
          }

          // Lấy dữ liệu từ snapshot
          var userData = snapshot.data!;
          String name = userData['name']!;
          String phone = userData['phone']!;
          String email = userData['email']!;

          return Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoItem('Họ và tên', name),
                _buildInfoItem('Số điện thoại', phone),
                _buildInfoItem('Email', email),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

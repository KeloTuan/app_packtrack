import 'package:app_packtrack/account/account_screen.dart';
import 'package:app_packtrack/process_screen.dart';
import 'package:app_packtrack/store/list_store_screen.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Quy trình',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.store),
          label: 'Cửa hàng',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.video_library),
          label: 'Ghi hình',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.help),
          label: 'Hỗ trợ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Tài khoản',
        ),
      ],
      onTap: (index) {
        if (index == 0) {
          // Khi nhấn vào icon Quy trình
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProcessScreen()),
          );
        }
        if (index == 1) {
          // Khi nhấn vào icon Cửa hàng
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StoreListScreen()),
          );
        }
        if (index == 4) {
          // Khi nhấn vào icon Tài khoản
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AccountScreen()),
          );
        }
        // Bạn có thể thêm các hành động khác cho các item khác tại đây
      },
      selectedItemColor: Colors.black, // Màu cho mục được chọn
      unselectedItemColor: Colors.black54, // Màu cho mục không được chọn
      backgroundColor: Colors.black54, // Màu nền của BottomNavigationBar
    );
  }
}

import 'package:app_packtrack/bar/bottom_nav.dart';
import 'package:app_packtrack/store/store_selected_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_packtrack/store/store_provider.dart'; // Import storeSelectedProvider

class ProcessScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Lấy thông tin cửa hàng đã được chọn từ storeSelectedProvider
    final store = ref.watch(storeSelectedProvider);

    if (store == null) {
      return Scaffold(
        body: Center(child: Text('Không có cửa hàng được chọn.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(store.storeName), // Hiển thị tên cửa hàng trên AppBar
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Tên cửa hàng: ${store.storeName}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'SĐT: ${store.storePhone}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Địa chỉ: ${store.storeAddress}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Spacer(),
          BottomNav(), // Gọi BottomNav chứa các biểu tượng
        ],
      ),
    );
  }
}

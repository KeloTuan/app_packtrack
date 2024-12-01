import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_packtrack/store/store_provider.dart';

class AddStoreScreen extends ConsumerStatefulWidget {
  final String uid;

  const AddStoreScreen({required this.uid, Key? key}) : super(key: key);

  @override
  ConsumerState<AddStoreScreen> createState() => _AddStoreScreenState();
}

class _AddStoreScreenState extends ConsumerState<AddStoreScreen> {
  final TextEditingController _storeNameController = TextEditingController();
  final TextEditingController _storePhoneController = TextEditingController();
  final TextEditingController _storeAddressController = TextEditingController();

  // Sửa lại _addStore để sử dụng ref
  void _addStore(BuildContext context, WidgetRef ref) async {
    final storeName = _storeNameController.text.trim();
    final storePhone = _storePhoneController.text.trim();
    final storeAddress = _storeAddressController.text.trim();

    if (storeName.isEmpty || storePhone.isEmpty || storeAddress.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng điền đầy đủ thông tin')),
      );
      return;
    }

    final store = Store(
      storeName: storeName,
      storePhone: storePhone,
      storeAddress: storeAddress,
    );

    // Sử dụng storeProvider với tham số uid
    await ref
        .read(storeProvider(widget.uid).notifier)
        .addStore(widget.uid, store);

    Navigator.pop(context); // Quay lại màn hình trước
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thêm Cửa Hàng')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _storeNameController,
              decoration: const InputDecoration(labelText: 'Tên Cửa Hàng'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _storePhoneController,
              decoration: const InputDecoration(labelText: 'Số Điện Thoại'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _storeAddressController,
              decoration: const InputDecoration(labelText: 'Địa Chỉ'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () =>
                  _addStore(context, ref), // Đã sửa gọi _addStore(context, ref)
              child: const Text('Thêm Cửa Hàng'),
            ),
          ],
        ),
      ),
    );
  }
}

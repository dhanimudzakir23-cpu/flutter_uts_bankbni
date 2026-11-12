import 'package:flutter/material.dart';
import 'package:bni_mobile_pay/core/colors.dart';

class ServiceScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final String? message;
  const ServiceScreen({super.key, required this.title, required this.icon, this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(color: AppColors.teal.withAlpha(30), shape: BoxShape.circle),
              child: Icon(icon, size: 46, color: AppColors.teal),
            ),
            const SizedBox(height: 20),
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text(message ?? 'Halaman ini adalah simulasi. Fitur lengkap akan tersedia pada versi berikutnya.',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.grey, height: 1.4)),
            const SizedBox(height: 24),
            FilledButton(onPressed: () => Navigator.pop(context), child: const Text('Kembali')),
          ]),
        ),
      ),
    );
  }
}

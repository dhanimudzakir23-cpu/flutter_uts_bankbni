import 'package:flutter/material.dart';
import 'package:bni_mobile_pay/core/colors.dart';

class QrisScreen extends StatefulWidget {
  const QrisScreen({super.key});

  @override
  State<QrisScreen> createState() => _QrisScreenState();
}

class _QrisScreenState extends State<QrisScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _c =
      AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
  bool _flash = false;

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  void _simulate() {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.check_circle_rounded, color: AppColors.green, size: 54),
        title: const Text('Pembayaran Berhasil'),
        content: const Text('Simulasi pembayaran QRIS ke "Warung BNI MOBILE" sebesar Rp25.000.',
            textAlign: TextAlign.center),
        actions: [FilledButton(onPressed: () => Navigator.pop(ctx), child: const Text('Selesai'))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111827),
      appBar: AppBar(
        title: const Text('QRIS'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 110),
          child: Column(children: [
            const Text('Arahkan kamera ke kode QRIS',
                style: TextStyle(color: Colors.white70, fontSize: 14)),
            const SizedBox(height: 28),
            SizedBox(
              width: 260,
              height: 260,
              child: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.orange, width: 3),
                    color: Colors.white10,
                  ),
                ),
                AnimatedBuilder(
                  animation: _c,
                  builder: (_, __) => Positioned(
                    left: 16,
                    right: 16,
                    top: 14 + 226 * _c.value,
                    child: Container(height: 3, color: AppColors.orange),
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 28),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconButton.filledTonal(
                onPressed: () => setState(() => _flash = !_flash),
                icon: Icon(_flash ? Icons.flash_on_rounded : Icons.flash_off_rounded),
              ),
              const SizedBox(width: 16),
              IconButton.filledTonal(
                onPressed: () => ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Galeri dibuka (simulasi)'))),
                icon: const Icon(Icons.photo_library_rounded),
              ),
            ]),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton.icon(
                onPressed: _simulate,
                icon: const Icon(Icons.qr_code_scanner_rounded),
                label: const Text('Simulasi Scan'),
                style: FilledButton.styleFrom(
                    backgroundColor: AppColors.orange,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

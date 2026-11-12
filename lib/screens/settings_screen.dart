import 'package:flutter/material.dart';
import 'package:bni_mobile_pay/core/colors.dart';
import 'package:bni_mobile_pay/data/dummy.dart';
import 'package:bni_mobile_pay/screens/service_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _bio = true;
  bool _notif = true;

  Future<void> _logout() async {
    final messenger = ScaffoldMessenger.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Keluar dari BNI MOBILE PAY?'),
        content: const Text('Anda harus masuk kembali untuk mengakses akun Anda.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Keluar')),
        ],
      ),
    );
    if (ok == true) messenger.showSnackBar(const SnackBar(content: Text('Anda telah keluar (simulasi)')));
  }

  void _open(String t, IconData i) =>
      Navigator.push(context, MaterialPageRoute(builder: (_) => ServiceScreen(title: t, icon: i)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 110),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(color: AppColors.teal, borderRadius: BorderRadius.circular(20)),
            child: const Row(children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Text(Dummy.initials,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.teal)),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(Dummy.userName,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white)),
                  Text('Rekening ${'1786609623'}', style: TextStyle(fontSize: 12, color: Colors.white70)),
                ]),
              ),
            ]),
          ),
          const SizedBox(height: 12),
          SwitchListTile(
            value: _bio,
            title: const Text('Login biometrik'),
            secondary: const Icon(Icons.fingerprint_rounded, color: AppColors.orange),
            onChanged: (v) => setState(() => _bio = v),
          ),
          SwitchListTile(
            value: _notif,
            title: const Text('Notifikasi transaksi'),
            secondary: const Icon(Icons.notifications_active_rounded, color: AppColors.orange),
            onChanged: (v) => setState(() => _notif = v),
          ),
          for (final m in const [
            ('Ubah PIN', Icons.lock_rounded),
            ('Bahasa', Icons.language_rounded),
            ('Pusat Bantuan', Icons.support_agent_rounded),
            ('Tentang Aplikasi', Icons.info_rounded),
          ])
            ListTile(
              leading: Icon(m.$2, color: AppColors.orange),
              title: Text(m.$1),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => _open(m.$1, m.$2),
            ),
          const SizedBox(height: 12),
          SizedBox(
            height: 50,
            child: OutlinedButton.icon(
              onPressed: _logout,
              icon: const Icon(Icons.logout_rounded),
              label: const Text('Keluar'),
              style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.red,
                  side: const BorderSide(color: AppColors.red),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
            ),
          ),
        ],
      ),
    );
  }
}

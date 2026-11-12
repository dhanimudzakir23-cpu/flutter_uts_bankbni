import 'package:flutter/material.dart';
import 'package:bni_mobile_pay/core/colors.dart';
import 'package:bni_mobile_pay/data/dummy.dart';
import 'package:bni_mobile_pay/screens/service_screen.dart';
import 'package:bni_mobile_pay/screens/transfer_screen.dart';
import 'package:bni_mobile_pay/widgets/balance_card.dart';
import 'package:bni_mobile_pay/widgets/menu_circle.dart';
import 'package:bni_mobile_pay/widgets/promo_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Set<String> _visible = {for (final m in Dummy.menus) m.label};

  void _push(Widget page) => Navigator.push(context, MaterialPageRoute(builder: (_) => page));

  void _toast(String m) => ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(m)));

  void _openMenu(MenuData m) {
    if (m.label == 'Transfer') {
      _push(const TransferScreen());
    } else {
      _push(ServiceScreen(title: m.label, icon: m.icon));
    }
  }

  Future<void> _logout() async {
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
    if (ok == true) _toast('Anda telah keluar (simulasi)');
  }

  void _notifications() {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Notifikasi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          for (final n in const [
            ('Gaji masuk Rp8.500.000', 'Hari ini, 09:00', Icons.arrow_downward_rounded),
            ('Promo cashback QRIS 10%', 'Kemarin', Icons.local_offer_rounded),
            ('Tips keamanan: jangan bagikan OTP', '2 hari lalu', Icons.shield_rounded),
          ])
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 136, 87, 49).withAlpha(30),
                  child: Icon(n.$3, color: AppColors.orange, size: 20)),
              title: Text(n.$1, style: const TextStyle(fontSize: 14)),
              subtitle: Text(n.$2, style: const TextStyle(fontSize: 11)),
            ),
        ]),
      ),
    );
  }

  void _arrangeMenu() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) => SizedBox(
          height: MediaQuery.of(ctx).size.height * 0.7,
          child: Column(children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Atur Menu', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              ),
            ),
            Expanded(
              child: ListView(children: [
                for (final m in Dummy.menus)
                  CheckboxListTile(
                    value: _visible.contains(m.label),
                    activeColor: AppColors.orange,
                    title: Text(m.label),
                    secondary: Icon(m.icon, color: m.colors.last),
                    onChanged: (v) {
                      if (v == false && _visible.length <= 4) return; // minimal 4 menu
                      setS(() {});
                      setState(() => v == true ? _visible.add(m.label) : _visible.remove(m.label));
                    },
                  ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  onPressed: () => Navigator.pop(ctx),
                  style: FilledButton.styleFrom(backgroundColor: AppColors.orange),
                  child: const Text('Selesai'),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void _allMenus() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 28),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Semua Layanan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: Dummy.menus.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, mainAxisExtent: 106, crossAxisSpacing: 4),
            itemBuilder: (_, i) => MenuCircle(
              data: Dummy.menus[i],
              onTap: () {
                Navigator.pop(ctx);
                _openMenu(Dummy.menus[i]);
              },
            ),
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final shown = Dummy.menus.where((m) => _visible.contains(m.label)).toList();
    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 150),
        children: [
          Row(children: [
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(color: AppColors.teal, shape: BoxShape.circle),
              child: const Icon(Icons.waves_rounded, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 8),
            const Text('BNI MOBILE',
                style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: 1, color: AppColors.teal)),
            const Spacer(),
            Stack(children: [
              IconButton(
                onPressed: _notifications,
                icon: const Icon(Icons.notifications_none_rounded, color: AppColors.orange, size: 28),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                    width: 9,
                    height: 9,
                    decoration: BoxDecoration(
                        color: AppColors.red,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5))),
              ),
            ]),
            IconButton(
              onPressed: _logout,
              icon: const Icon(Icons.logout_rounded, color: AppColors.orange, size: 26),
            ),
          ]),
          const SizedBox(height: 14),
          Row(children: [
            Container(
              width: 62,
              height: 62,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.teal, AppColors.tealDark]),
              ),
              child: const Text(Dummy.initials,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Selamat Datang,', style: TextStyle(fontSize: 14, color: AppColors.grey)),
                SizedBox(height: 2),
                Text(Dummy.userName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, letterSpacing: 0.5, color: AppColors.text)),
              ]),
            ),
          ]),
          const SizedBox(height: 16),
          const BalanceCard(),
          const SizedBox(height: 14),
          Row(children: [
            GestureDetector(
              onTap: () => _toast('Anda memiliki ${Dummy.points} poin'),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.line)),
                child: const Row(mainAxisSize: MainAxisSize.min, children: [
                  Text('POIN',
                      style: TextStyle(fontWeight: FontWeight.w900, color: AppColors.orange, fontSize: 13)),
                  SizedBox(width: 10),
                  Text('${Dummy.points}', style: TextStyle(fontWeight: FontWeight.w600)),
                ]),
              ),
            ),
            const Spacer(),
            OutlinedButton.icon(
              onPressed: _arrangeMenu,
              icon: const Icon(Icons.edit_outlined, size: 18),
              label: const Text('Atur Menu'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.orange,
                side: const BorderSide(color: AppColors.orange),
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            ),
          ]),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: shown.length + 1,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, mainAxisExtent: 106, crossAxisSpacing: 4),
            itemBuilder: (_, i) => i == shown.length
                ? MenuCircle(data: null, onTap: _allMenus)
                : MenuCircle(data: shown[i], onTap: () => _openMenu(shown[i])),
          ),
          const SizedBox(height: 8),
          const Text('Promo & Informasi',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: AppColors.text)),
          const Divider(height: 24, color: AppColors.line),
          PromoCarousel(
            onTap: (p) => _push(ServiceScreen(title: p.title, icon: p.icon, message: p.subtitle)),
          ),
        ],
      ),
    );
  }
}

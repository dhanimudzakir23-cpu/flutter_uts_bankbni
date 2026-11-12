import 'package:flutter/material.dart';
import 'package:bni_mobile_pay/core/colors.dart';
import 'package:bni_mobile_pay/core/format.dart';
import 'package:bni_mobile_pay/data/dummy.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int _f = 0;
  static const _labels = ['Semua', 'Uang Masuk', 'Uang Keluar'];

  void _detail(Txn t) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(t.icon, size: 38, color: AppColors.teal),
          const SizedBox(height: 10),
          Text(t.title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(rupiah(t.amount, sign: true),
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: t.income ? AppColors.green : AppColors.text)),
          const SizedBox(height: 14),
          for (final r in [('Kategori', t.category), ('Waktu', t.date), ('Status', 'Berhasil')])
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(children: [
                Text(r.$1, style: const TextStyle(color: AppColors.grey)),
                const Spacer(),
                Text(r.$2),
              ]),
            ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = Dummy.txns.where((t) => _f == 0 || (_f == 1 ? t.income : !t.income)).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat')),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
          child: Row(children: [
            for (var i = 0; i < _labels.length; i++)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(_labels[i], style: const TextStyle(fontSize: 12)),
                  selected: _f == i,
                  onSelected: (_) => setState(() => _f = i),
                ),
              ),
          ]),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 110),
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 1, color: AppColors.line),
            itemBuilder: (_, i) {
              final t = items[i];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 4),
                onTap: () => _detail(t),
                leading: CircleAvatar(
                  backgroundColor: (t.income ? AppColors.green : AppColors.orange).withAlpha(30),
                  child: Icon(t.icon, size: 20, color: t.income ? AppColors.green : AppColors.orange),
                ),
                title: Text(t.title, maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                subtitle: Text('${t.category} • ${t.date}', style: const TextStyle(fontSize: 11)),
                trailing: Text(rupiah(t.amount, sign: true),
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: t.income ? AppColors.green : AppColors.text)),
              );
            },
          ),
        ),
      ]),
    );
  }
}

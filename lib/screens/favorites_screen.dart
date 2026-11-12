import 'package:flutter/material.dart';
import 'package:bni_mobile_pay/core/colors.dart';
import 'package:bni_mobile_pay/data/dummy.dart';
import 'package:bni_mobile_pay/screens/transfer_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  Future<void> _add(BuildContext context) async {
    final name = TextEditingController();
    final number = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Tambah Favorit'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: name, decoration: const InputDecoration(labelText: 'Nama')),
          TextField(
              controller: number,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Nomor rekening')),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Simpan')),
        ],
      ),
    );
    if (ok == true && name.text.trim().isNotEmpty && number.text.trim().length >= 6) {
      favorites.value = [...favorites.value, Fav(name.text.trim(), number.text.trim())];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorit')),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton.extended(
          heroTag: 'fav',
          onPressed: () => _add(context),
          backgroundColor: AppColors.orange,
          foregroundColor: Colors.white,
          icon: const Icon(Icons.add_rounded),
          label: const Text('Tambah'),
        ),
      ),
      body: ValueListenableBuilder<List<Fav>>(
        valueListenable: favorites,
        builder: (context, list, _) => list.isEmpty
            ? const Center(child: Text('Belum ada favorit', style: TextStyle(color: AppColors.grey)))
            : ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 160),
                itemCount: list.length,
                separatorBuilder: (_, __) => const Divider(height: 1, color: AppColors.line),
                itemBuilder: (_, i) {
                  final f = list[i];
                  return Dismissible(
                    key: ValueKey('${f.name}${f.number}'),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: AppColors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 5),
                      child: const Icon(Icons.delete_rounded, color: Colors.white),
                    ),
                    onDismissed: (_) => favorites.value = [...list]..removeAt(i),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.teal.withAlpha(30),
                        child: Text(f.name[0], style: const TextStyle(color: AppColors.teal, fontWeight: FontWeight.w700)),
                      ),
                      title: Text(f.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text(f.number),
                      trailing: const Icon(Icons.star_rounded, color: AppColors.orange),
                      onTap: () => Navigator.push(
                          context, MaterialPageRoute(builder: (_) => TransferScreen(prefill: f.number))),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class ModToolsScreen extends StatelessWidget {
  final String name;
  const ModToolsScreen({super.key, required this.name});

  void navigateToEdit(BuildContext context) {
    Routemaster.of(context).push('/edit-community/$name');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mod Tools'),
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.add_moderator_rounded,
            ),
            title: const Text('Add Moderators'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.edit,
            ),
            title: const Text('Edit Moderators'),
            onTap: () {
              navigateToEdit(context);
            },
          ),
        ],
      ),
    );
  }
}

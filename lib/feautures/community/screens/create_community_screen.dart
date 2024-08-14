import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_fullstack/core/common/loader.dart';
import 'package:reddit_fullstack/feautures/community/controller/commuinty_controller.dart';
import 'package:reddit_fullstack/theme/pallet.dart';

class CreateCommunityScreen extends ConsumerStatefulWidget {
  const CreateCommunityScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends ConsumerState<CreateCommunityScreen> {
  final communityController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    communityController.dispose();
  }
  void createCommunity(){
    ref.read(communityControlProvider.notifier).createCommunity(
      communityController.text.trim(),
     context);
    
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(communityControlProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a community'),
      ),
      body:isLoading ? const Loader() : Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Align(
                alignment: Alignment.topLeft, child: Text('Community name')),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: communityController,
              decoration: const InputDecoration(
                hintText: 'r/Community_name',
                filled: true,
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(18),
              ),
              maxLength: 21,
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: createCommunity,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Pallet.blueColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Create community',
                style: TextStyle(fontSize: 18, color: Pallet.whiteColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

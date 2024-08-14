// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_fullstack/core/common/error_text.dart';
import 'package:reddit_fullstack/core/common/loader.dart';
import 'package:reddit_fullstack/core/constants/constants.dart';
import 'package:reddit_fullstack/core/utils.dart';
import 'package:reddit_fullstack/feautures/community/controller/commuinty_controller.dart';
import 'package:reddit_fullstack/models/community_model.dart';
import 'package:reddit_fullstack/theme/pallet.dart';

class EditCommunityScreev extends ConsumerStatefulWidget {
  final String name;
  const EditCommunityScreev({
    super.key,
    required this.name,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditCommunityScreevState();
}

class _EditCommunityScreevState extends ConsumerState<EditCommunityScreev> {
  File? bannerFile;
  File? profileFile;

  void selectBannerImage() async {
    final res = await pickImage();
    setState(() {
      bannerFile = File(res.files.first.path!);
    });
    }

  void selectProfileImage() async {
    final res = await pickImage();
    setState(() {
      profileFile = File(res.files.first.path!);
    });
    }

  void save(Community community) {
    ref.read(communityControlProvider.notifier).editCommunity(
          profileFile: profileFile,
          bannerFile: bannerFile,
          context: context,
          community: community,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(communityControlProvider);
    return ref.watch(getCommunityByNameProvider(widget.name)).when(
        data: (community) => Scaffold(
              backgroundColor: const Color.fromRGBO(18, 18, 18, 1),
              appBar: AppBar(
                backgroundColor: const Color.fromRGBO(18, 18, 18, 1),
                title: const Text('Edit Community'),
                actions: [
                  TextButton(
                    onPressed: ()=> save(community  ),
                    child: const Text('Save'),
                  ),
                ],
              ),
              body:isLoading? const Loader(): Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: selectBannerImage,
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              color: Pallet.darkModeAppTheme.textTheme
                                  .bodyMedium!.color!,
                              radius: const Radius.circular(10),
                              dashPattern: const [10, 4],
                              strokeCap: StrokeCap.round,
                              child: Container(
                                  width: double.infinity,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: bannerFile != null
                                      ? Image.file(bannerFile!)
                                      : community.banner.isEmpty ||
                                              community.banner ==
                                                  Constants.bannerDefault
                                          ? const Center(
                                              child: Icon(
                                                Icons.camera_alt_rounded,
                                                size: 40,
                                              ),
                                            )
                                          : Image.network(community.banner)),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: GestureDetector(
                                onTap: selectProfileImage,
                                child: profileFile != null
                                    ? CircleAvatar(
                                        backgroundImage:
                                            FileImage(profileFile!),
                                        radius: 32,
                                      )
                                    : CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(community.avatar),
                                        radius: 32,
                                      )),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        error: (error, stackTrace) => ErrorText(error: error.toString()),
        loading: () => const Loader());
  }
}

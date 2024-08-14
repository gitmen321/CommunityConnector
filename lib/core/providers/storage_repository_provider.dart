 import 'dart:io';
 import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reddit_fullstack/core/failure.dart';
import 'package:reddit_fullstack/core/providers/firebase_providers.dart';
import 'package:reddit_fullstack/core/type_def.dart';

final storageRepositoryprovider = Provider((ref)=> StorageRepository(firebaseStorage: ref.watch(storageProvider),),);

class StorageRepository {
  final FirebaseStorage _firebaseStorage;

  StorageRepository({required FirebaseStorage firebaseStorage}): _firebaseStorage = firebaseStorage;

  FutureEither<String>storeFile({required String path, required String id, required File? file})async{
    try {
      final ref = _firebaseStorage.ref().child('path').child(id);

      UploadTask uploadTask = ref.putFile(file!);

      final snapShot =await uploadTask;
      
      return right(await snapShot.ref.getDownloadURL());
    } catch (e) {
      return Left(Failure(e.toString()));
      
    }
  }
  
}
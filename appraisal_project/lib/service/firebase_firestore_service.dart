import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:appraisal_project/screens/form/datamodel/appraisal.dart';

final CollectionReference noteCollection =
    Firestore.instance.collection('notes');

class FirebaseFirestoreService {
  static final FirebaseFirestoreService _instance =
      new FirebaseFirestoreService.internal();

  factory FirebaseFirestoreService() => _instance;

  FirebaseFirestoreService.internal();

  Future<Appraisal> createNote(
      String id,
      String address,
      String city,
      String state,
      String zip,
      String borrower,
      String owner,
      String county,
      String description,
      String parcel) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(noteCollection.document());

      final Appraisal note = new Appraisal(id, address, city, state, zip,
          borrower, owner, county, description, parcel);
      final Map<String, dynamic> data = note.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Appraisal.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getNoteList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = noteCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  Future<dynamic> updateNote(Appraisal note) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(noteCollection.document(note.id));

      await tx.update(ds.reference, note.toMap());
      return {'updated': true};
    };

    return Firestore.instance
        .runTransaction(updateTransaction)
        .then((result) => result['updated'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }

  Future<dynamic> deleteNote(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(noteCollection.document(id));

      await tx.delete(ds.reference);
      return {'deleted': true};
    };

    return Firestore.instance
        .runTransaction(deleteTransaction)
        .then((result) => result['deleted'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }
}

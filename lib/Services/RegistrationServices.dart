import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/RegistrationModel.dart';

class RegistrationServices {
  Future createAccount(RegistrationModel model) async {
    return await FirebaseFirestore.instance
        .collection('createAccount')
        .doc(model.docId)
        .set(model.toJson());
  }
}

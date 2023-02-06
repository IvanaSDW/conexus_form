import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conexus_form/core/models/Customer.dart';
import 'package:conexus_form/core/services/response.dart';
import 'package:conexus_form/utils/db_names.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _customers = _firestore
    .collection(CUSTOMERS_TABLE_NAME)
    .withConverter<Customer>(
        fromFirestore: (snapshot, _) => Customer.fromJson(snapshot.data()!),
        toFirestore: (customer, _) => customer.toJson());

class CustomerCrud {
  Future<FirebaseResponse> addCustomer(Customer customer) async {
    FirebaseResponse response = FirebaseResponse();
    DocumentReference document = _customers.doc(customer.id);
    DocumentSnapshot customerSnapshot = await document.get();
    if (customerSnapshot.exists) {
      response.code = 409;
      response.message = 'A customer with that ID already exists';
    } else {
      await document.set(customer).then((value) {
        response.code = 200;
        response.message = 'Successfully added to database';
      }).catchError((error) {
        response.code = 500;
        response.message = error;
      });
    }
    return response;
  }

  Future<FirebaseResponse> editCustomer(
  {required String customerId, required Map<String, dynamic> newData}
      ) async {
    FirebaseResponse response = FirebaseResponse();
    await _customers.doc(customerId).update(newData).then((value) {
      response.code = 200;
      response.message = 'Successfully updated in database';
    }).catchError((error) {
      response.code = 500;
      response.message = error;
    });
    return response;
  }

  Stream<QuerySnapshot<Customer>> fetchCustomers() {
    return _customers
        .withConverter(
            fromFirestore: (snapshot, _) => Customer.fromJson(snapshot.data()!),
            toFirestore: ((customer, _) => customer.toJson()))
        .snapshots();
  }

}

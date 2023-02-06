
import '../../utils/db_names.dart';

class Customer {
  String id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String? imageUrl;

  Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    this.imageUrl,
  });

  toJson() => {
        CUSTOMER_ID_CN: id,
        CUSTOMER_FIRST_NAME_CN: firstName,
        CUSTOMER_LAST_NAME_CN: lastName,
        CUSTOMER_EMAIL_CN: email,
        CUSTOMER_PHONE_CN: phone,
        CUSTOMER_IMAGE_URL_CN: imageUrl,
      };

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json[CUSTOMER_ID_CN],
        firstName: json[CUSTOMER_FIRST_NAME_CN],
        lastName: json[CUSTOMER_LAST_NAME_CN],
        email: json[CUSTOMER_EMAIL_CN],
        phone: json[CUSTOMER_PHONE_CN],
        imageUrl: json[CUSTOMER_IMAGE_URL_CN],
      );

  factory Customer.empty() => Customer(
    id: '',
    firstName: '',
    lastName: '',
    email: '',
    phone: '',
  );
}

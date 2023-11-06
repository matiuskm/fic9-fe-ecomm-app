// ignore_for_file: public_member_api_docs, sort_constructors_first
class CourierModel {
  final String value;
  final String label;

  CourierModel({
    required this.value,
    required this.label,
  });

  @override
  String toString() => label;
}

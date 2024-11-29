import 'package:uuid/uuid.dart';

String generateRandomId() {
  return const Uuid().v4();
}
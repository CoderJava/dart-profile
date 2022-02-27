import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

import 'profile_controller.dart';

void main(List<String> arguments) async {
  final handler = const Pipeline().addMiddleware(logRequests()).addHandler(ProfileController().handler);
  await serve(handler, 'localhost', 8080);
  print('Server is running');
}

import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'routes/onboard/hello.dart';

// Configure routes.
final _router = Router();

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Mount http://ip:port/onboard/
  _router.mount('/onboard/', Hello().handler);

  // Catch all non-implemented routes - returns as 404
  _router.all('/<ignored|.*>', (Request request) => Response.notFound('Page not found'));

  // Configure a pipeline that logs requests.
  final _handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  // Starts the server
  final server = await serve(_handler, ip, port);
  print('Server listening on port ${server.port}');
}

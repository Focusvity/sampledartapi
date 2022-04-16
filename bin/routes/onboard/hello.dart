import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class Hello {
  Handler get handler {
    final router = Router();

    router.get('/hello', (Request request) => Response.ok(jsonEncode({'onboarding': null})));

    router.all('/<ignored|.*>', (Request request) => Response.notFound('Page not found'));

    return router;
  }
}
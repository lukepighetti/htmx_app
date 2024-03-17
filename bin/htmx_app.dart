import 'package:htmx_app/htmx_app.dart' as htmx_app;
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_static/shelf_static.dart';

Future<void> main(List<String> arguments) async {
  var app = Router();

  var handler = createStaticHandler(
    'static',
    defaultDocument: 'index.html',
  );

  app.get('/', handler);

  app.get('/hello', (Request request) {
    return Response.ok('hello-world');
  });

  app.get('/user/<user>', (Request request, String user) {
    return Response.ok('hello $user');
  });

  var server = await io.serve(app.call, 'localhost', 8080);

  print('Listening on http://${server.address.host}:${server.port}');
}

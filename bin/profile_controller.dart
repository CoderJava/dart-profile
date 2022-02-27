import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'supabase_helper.dart';

class ProfileController {
  Handler get handler {
    final router = Router();
    final supabaseHelper = SupabaseHelper();

    router.get('/profile', (Request request) async {
      return supabaseHelper.getAllProfiles();
    });

    router.get('/profile/<id>', (Request request, String id) async {
      return supabaseHelper.getProfileById(id);
    });

    router.post('/profile', (Request request) async {
      final strBodyRequest = await request.readAsString();
      return supabaseHelper.createProfile(strBodyRequest);
    });

    router.put('/profile/<id>', (Request request, String id) async {
      final strBodyRequest = await request.readAsString();
      return supabaseHelper.updateProfile(id, strBodyRequest);
    });

    router.delete('/profile/<id>', (Request request, String id) async {
      return supabaseHelper.deleteProfile(id);
    });

    router.all('/<ignored|.*>', (Request request) async {
      return Response.notFound('Page not found');
    });

    return router;
  }
}

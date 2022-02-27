import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import 'profile.dart';

class SupabaseHelper {
  final supabaseUrl = '<anon_public>';
  final supabaseKey =
      '<url>';
  final profileTableName = 'profile';
  late SupabaseClient supabaseClient;

  SupabaseHelper() {
    supabaseClient = SupabaseClient(supabaseUrl, supabaseKey);
  }

  Map<String, dynamic> getTemplateErrorMessage({
    String title = 'Info',
    String message = 'Data not found',
  }) {
    return {
      'title': title,
      'message': message,
    };
  }

  Future<Response> getAllProfiles() async {
    try {
      final response = await supabaseClient.from(profileTableName).select().execute();
      late Map<String, dynamic> responseJson;
      if (response.data == null) {
        responseJson = getTemplateErrorMessage();
        return Response.notFound(jsonEncode(responseJson));
      }
      final listProfiles = List.from(response.data).map((e) => Profile.fromJson(e)).toList();
      responseJson = {
        'data': listProfiles,
      };
      return Response.ok(jsonEncode(responseJson));
    } catch (error) {
      return Response.internalServerError(
        body: getTemplateErrorMessage(
          title: 'Error',
          message: error.toString(),
        ),
      );
    }
  }

  Future<Response> getProfileById(String id) async {
    try {
      final response = await supabaseClient.from(profileTableName).select().eq('id', id).execute();
      final listProfiles = List.from(response.data).map((e) => Profile.fromJson(e)).toList();
      late Map<String, dynamic> responseJson;
      if (listProfiles.isEmpty) {
        responseJson = getTemplateErrorMessage();
        return Response.notFound(jsonEncode(responseJson));
      }
      responseJson = listProfiles.first.toJson();
      return Response.ok(jsonEncode(responseJson));
    } catch (error) {
      return Response.internalServerError(
        body: getTemplateErrorMessage(
          title: 'Error',
          message: error.toString(),
        ),
      );
    }
  }

  Future<Response> createProfile(String bodyRequest) async {
    try {
      final profile = Profile.fromJson(jsonDecode(bodyRequest)).toJson()
        ..remove('id')
        ..remove('created_at');
      final response = await supabaseClient.from(profileTableName).insert(profile).execute();
      late Map<String, dynamic> responseJson;
      if (response.data == null) {
        responseJson = getTemplateErrorMessage(message: 'Create profile failed');
        return Response.internalServerError(body: jsonEncode(responseJson));
      }
      final listData = List.from(response.data).map((e) => Profile.fromJson(e)).toList();
      if (listData.isEmpty) {
        responseJson = getTemplateErrorMessage();
        return Response.notFound(jsonEncode(responseJson));
      }
      responseJson = listData.first.toJson();
      return Response(201, body: jsonEncode(responseJson));
    } catch (error) {
      return Response.internalServerError(
        body: getTemplateErrorMessage(
          title: 'Error',
          message: error.toString(),
        ),
      );
    }
  }

  Future<Response> updateProfile(String id, String bodyRequest) async {
    try {
      final profile = Profile.fromJson(jsonDecode(bodyRequest)).toJson()
        ..remove('id')
        ..remove('created_at');
      final response = await supabaseClient.from(profileTableName).update(profile).eq('id', id).execute();
      late Map<String, dynamic> responseJson;
      if (response.data == null) {
        responseJson = getTemplateErrorMessage(message: 'Update profile failed');
        return Response.internalServerError(body: jsonEncode(responseJson));
      }
      final listData = List.from(response.data).map((e) => Profile.fromJson(e)).toList();
      if (listData.isEmpty) {
        responseJson = getTemplateErrorMessage();
        return Response.notFound(jsonEncode(responseJson));
      }
      responseJson = listData.first.toJson();
      return Response.ok(jsonEncode(responseJson));
    } catch (error) {
      return Response.internalServerError(
        body: getTemplateErrorMessage(
          title: 'Error',
          message: error.toString(),
        ),
      );
    }
  }

  Future<Response> deleteProfile(String id) async {
    try {
      final response = await supabaseClient.from(profileTableName).delete().eq('id', id).execute();
      late Map<String, dynamic> responseJson;
      if (response.data == null) {
        responseJson = getTemplateErrorMessage(message: 'Delete profile failed');
        return Response.internalServerError(body: jsonEncode(responseJson));
      }
      final listData = List.from(response.data).map((e) => Profile.fromJson(e)).toList();
      if (listData.isEmpty) {
        responseJson = getTemplateErrorMessage();
        return Response.notFound(jsonEncode(responseJson));
      }
      responseJson = listData.first.toJson();
      return Response.ok(jsonEncode(responseJson));
    } catch (error) {
      return Response.internalServerError(
        body: getTemplateErrorMessage(
          title: 'Error',
          message: error.toString(),
        ),
      );
    }
  }
}
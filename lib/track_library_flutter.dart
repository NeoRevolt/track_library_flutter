library track_library_flutter;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:track_library_flutter/models/action_validate_model.dart';
import 'package:track_library_flutter/models/add_log_track_model.dart';
import 'package:http/http.dart' as http;

class RemoteService {

  final String _baseUrl = 'https://dev.byonchat2.com/api/';
  final _client = http.Client();
  ActionValidationModel? _listAction;
  AddLogTrackModel? _addLogTrackModel;

  Future <dynamic> isActionValid (String token, String nameAction, String action) async{
    const getActionUrl = 'validation-log-action';
    var url = Uri.parse(_baseUrl + getActionUrl);
    var actionValidStatus = false;

    try{
      final response = await _client.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        _listAction = actionValidationModelFromJson(response.body);
        if (_listAction != null){
          if (kDebugMode) {
            print('[TrackApi] : Actions validation ready!');
          }
          var listLength = _listAction?.data.validations.length;
          var listValidations = _listAction?.data.validations;

          // Validating data by comparing each actions
          for (int i=0; i<listLength!; i++){
            if (nameAction == listValidations![i].nameAction
                && action == listValidations[i].action){
              _addLogTrack(nameAction, action, token);
              actionValidStatus = true;
              break;
            }
          }
        }
      } else {
        if (kDebugMode) {
          print('[TrackApi] Request failed! message : ${_listAction?.status}');
        }
        actionValidStatus = false;
      }
      if (actionValidStatus == false){
        if (kDebugMode) {
          print('[TrackApi] : Invalid actions! failed to report to server');
        }
      }
    } on SocketException catch(e) {
      if (kDebugMode) {
        print('[TrackApi] Connection failed');
      }
      if (kDebugMode) {
        print('[TrackApi] Found exception : $e');
      }
    }
    return actionValidStatus;
  }


  Future<dynamic> _addLogTrack(
      String actionName, String action, String token) async {
    const addLogTrackUrl = 'log-tracker';
    var url = Uri.parse(_baseUrl + addLogTrackUrl);
    var message = '';

    try{
      final response = await _client.post(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
        body: {'nameAction': actionName, 'action': action},
      );
      if (response.statusCode == 200) {
        _addLogTrackModel = addLogTrackModelFromJson(response.body);
        if (kDebugMode) {
          print('[TrackApi] : (action name : $actionName) & (action : $action) are valid! & successfully reported');
        }
        if (kDebugMode) {
          print('[TrackApi] Status : ${_addLogTrackModel?.message}');
        }
        message = response.body;
      } else {
        if (kDebugMode) {
          print('[TrackApi] Request failed! message  : ${response.body}');
        }
        message = response.body;
      }
    }on SocketException catch(e) {
      if (kDebugMode) {
        print('[TrackApi] Connection failed');
      }
      if (kDebugMode) {
        print('[TrackApi] Found exception : $e');
      }
      message = e.toString();
    }
    return message;
  }
}
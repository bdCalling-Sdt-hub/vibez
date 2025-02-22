import 'dart:async';
import 'package:seth/services/api_constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../core/utils/app_constants.dart';
import '../helpers/prefs_helper.dart';

class SocketServices {
  static late IO.Socket socket;
  static String token = '';

  static final SocketServices _socketApi = SocketServices._internal();

  factory SocketServices() {
    return _socketApi;
  }

  SocketServices._internal();

  static Future<void> init() async {
    token = await PrefsHelper.getString(AppConstants.bearerToken) ?? "No Token";

    print("-------------------------------------------------------------Socket call");
    print("Token = $token");

    socket = IO.io(ApiConstants.imageBaseUrl,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .setExtraHeaders({'token': '$token'})
            .build());

    try {
      socket.connect();

      socket.onConnect((_) {
        print('✅ Socket Connected: ${socket.connected}');
      });

      socket.onConnectError((err) {
        print('❌ Socket Connect Error: $err');
      });

      socket.onDisconnect((_) {
        print('⚠️ Socket Disconnected');
      });
    } catch (e, s) {
      print("⚠️ Socket Error: $e");
      print("🔍 Stack Trace: $s");
    }
  }

  static Future<dynamic> emitWithAck(String event, dynamic body) async {
    Completer<dynamic> completer = Completer<dynamic>();
    if (socket.connected) {
      socket.emitWithAck(event, body, ack: (data) {
        if (data != null) {
          completer.complete(data);
        } else {
          completer.complete(1);
        }
      });
    } else {
      print("⚠️ Cannot emit, socket not connected");
      completer.completeError("Socket Not Connected");
    }
    return completer.future;
  }

  static void emit(String event, dynamic body) {
    if (socket.connected) {
      socket.emit(event, body);
      print('📤 Emit event: $event \n Body: $body');
    } else {
      print("⚠️ Cannot emit, socket not connected");
    }
  }
}

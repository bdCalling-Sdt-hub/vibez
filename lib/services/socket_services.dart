// import 'dart:async';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:socket_io_client/socket_io_client.dart';
// import 'package:swim_spa_app/helpers/prefs_helper.dart';
// import 'package:swim_spa_app/services/api_constants.dart';
// import 'package:swim_spa_app/utils/app_constant.dart';
//
// class SocketServices {
//
//   static var token = '';
//
//   factory SocketServices() {
//     return _socketApi;
//   }
//
//
//
//   SocketServices._internal();
//
//
//
//   static final SocketServices _socketApi = SocketServices._internal();
//   static IO.Socket socket = IO.io('https://api.valentinesproservice.com?token=$token',
//       IO.OptionBuilder().setTransports(['websocket']).build());
//
//   static void init() async{
//     token = await PrefsHelper.getString(AppConstants.bearerToken) ?? "Do Not Have token";
//
//
//     print("-------------------------------------------------------------Socket call \n token = $token");
//
//     if (!socket.connected) {
//       socket.onConnect((_) {
//         print('========> socket connected: ${socket.connected}');
//       });
//
//       socket.onConnectError((err) {
//         print('========> socket connect error: $err');
//       });
//
//       socket.onDisconnect((_) {
//         print('========> socket disconnected');
//       });
//     } else {
//       print("=======> socket already connected");
//     }
//   }
//
//   static Future<dynamic> emitWithAck(String event, dynamic body) async {
//     Completer<dynamic> completer = Completer<dynamic>();
//     socket.emitWithAck(event, body, ack: (data) {
//       if (data != null) {
//         completer.complete(data);
//       } else {
//         completer.complete(1);
//       }
//     });
//     return completer.future;
//   }
//
//
//   static emit(String event, dynamic body) {
//     if (body != null) {
//       socket.emit(event, body);
//       print('===========> Emit $event and \n $body');
//     }
//   }
// }
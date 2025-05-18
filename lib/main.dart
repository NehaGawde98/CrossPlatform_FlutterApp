import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const keyApplicationId = 'Tb69fqimtAVNTrllPtPUPxoGNIS1jcVAvTA1ctGa';
  const keyClientKey = '55fJXUt6KW17X9ZdUOXJv48fP90Cw18j4JhS2Nlf';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);

  runApp(BookstoreApp());
}

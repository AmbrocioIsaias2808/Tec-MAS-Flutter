import 'package:shared_preferences/shared_preferences.dart';

 class sharedPreferenceManager{

   String Key_CIDN="CDIN"; //Configuración inicial de notificaciones: memoriza si el usuario ya configuró o no si debe abrir las notirifcaciones en la app o su navegador preferido.

   dynamic readBool(String keyName) async {
     final prefs = await SharedPreferences.getInstance();
     final key = keyName;
     final value = prefs.getBool(key) ?? false;
     print('read: $value on key: $key');
     return value;
   }

   saveBool(String keyName, bool Keyvalue) async {
     final prefs = await SharedPreferences.getInstance();
     final key = keyName;
     final value = Keyvalue;
     prefs.setBool(key, value);
     print('\n\nsaved $value on key: $key');
   }

 }

import 'package:flutter/widgets.dart';
import 'package:tecmas/main.dart';

class ServerSettings{
  static const String _Pagina_URL="https://wordpresspruebas210919.000webhostapp.com";
  //static const String _Pagina_URL="http://192.168.1.106:80/wordpress";
  static const String _Api_Interface="/wp-json/wp/v2";
  static const String _BaseRequestURL= _Pagina_URL+_Api_Interface;
  static const String _FilterPostByCategories = "/posts?categories=";

  /*Server*/ static const String _ApiKey="wFx01QuHh9ybSx82rzZvypurEs1HQpWy";
  /*Local Server*/ //static const String _ApiKey="lnRwqoS3YoMyrocnuqktRnniLgVN9ElD";

  ServerSettings();

  String PaginarPorCategoria({@required String cantidadAMostrar, @required String NumDePagina, @required String categoriaAFiltrar}){
    String a =_BaseRequestURL+_FilterPostByCategories+categoriaAFiltrar+"&per_page="+cantidadAMostrar+"&page="+NumDePagina;
    print(a);
    return a;
  }

  String getFilterToSearchArticleByID(String ID){
    return _BaseRequestURL+"/posts/"+ID;
  }

  String getApiKey(){
    return _ApiKey;
  }

  String getPagina_URL(){
    return _Pagina_URL;
  }

  String getApi_InterfaceString(){
    return _Api_Interface;
  }

  String getBaseRequestURL(){
    return _BaseRequestURL;
  }

  String getFilterPostByCategoriesString(){
    return _FilterPostByCategories;
  }

}
import "dart:async";
import 'dart:io' as io;
import "package:path/path.dart";
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tecmas/Secciones/Estructures/Articles.dart';



class DBHelper{
  static Database _db;
  static const String DB_NAME="database.db";

  //Definiciones de la tabla articulos
  /*Se LLama */ static const String T_Articulos="Articulos";
  //Y tiene estos campos:
  static const String ID="id";
  static const String NUM="num";
  static const String TITLE="title";
  static const String CONTENT="content";
  static const String IMAGE="image";
  static const String CATEGORY="category";
  //Definimos la tabla de articulos guardados
  /*Se llama*/ static const String T_SavedArticulos="SavedArticulos";
  //Para los campos, por ahora reciclaremos los mismos que la tabla T_Articulos



  Future<Database> get db async{
    if(_db!=null){
      return _db;
    }else{
      _db= await initDb();
      return _db;
    }

  }

  initDb() async{
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path,version:1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async{
    await db.execute("CREATE TABLE $T_Articulos ($ID INTEGER PRIMARY KEY, $NUM INTEGER,$TITLE TEXT, $CONTENT TEXT, $IMAGE TEXT, $CATEGORY INTEGER)");
    await db.execute("CREATE TABLE $T_SavedArticulos ($ID INTEGER PRIMARY KEY, $NUM INTEGER,$TITLE TEXT, $CONTENT TEXT, $IMAGE TEXT, $CATEGORY INTEGER)");


  }

  Future<Articles> insert (Articles articulos) async{
    var dbClient = await db;
    // empleados.id =  await dbClient.insert(TABLE, empleados.toMap());
    //return empleados;

    await dbClient.transaction((txn) async{
      var query = "INSERT INTO $T_Articulos ($ID, $NUM, $TITLE, $CONTENT, $IMAGE, $CATEGORY) VALUES ("+articulos.ID.toString()+","+articulos.num.toString()+",'"+articulos.title+"','"+articulos.content+"','"+articulos.image+"',"+articulos.category.toString()+")";
      return await txn.rawInsert(query);
    });
  }

  /*Future deleteALL () async{
    var dbClient = await db;
    // empleados.id =  await dbClient.insert(TABLE, empleados.toMap());
    //return empleados;

    await dbClient.transaction((txn) async{
      var query = "DELETE FROM $T_Articulos";
      return await txn.rawInsert(query);
    });
  }*/

  Future<List<Articles>> getArticulos(int category) async{
    var dbClient=await db;
    String Category=category.toString();
    //List<Map> maps = await dbClient.query(TABLE,columns:[ID,NAME]);
    List<Map> maps= await dbClient.rawQuery("SELECT * FROM $T_Articulos WHERE $CATEGORY=$Category ORDER BY $NUM DESC");
    List<Articles> articulos=[];
    if(maps.length>0){
      for (int i=0; i<maps.length;i++){
        articulos.add(Articles.fromMap(maps[i]));
      }

    }
    return articulos;

  }

  Future<int> deleteAllByCategory(int category) async{

    var dbClient = await db;
    return await dbClient.delete(T_Articulos, where : "$CATEGORY=?", whereArgs: [category]);
  }


/*
  Future<int> uptade(Empleados empleados) async{
    var dbClient = await db;
    return await dbClient.update(TABLE,empleados.toMap(), where: "$ID=?", whereArgs: [empleados.id]);
  }

 */

  Future close() async{
    var dbClient=await db;
    dbClient.close();
  }

  /*--------------------------------------------------------------------------------------------------------*/
  //Begin: Funciones para administrar los articulos guardados desde la base de datos en el apartado de "SavedArticles")


  Future<List<Articles>> getSavedArticulos() async{
    var dbClient=await db;
    List<Map> maps= await dbClient.rawQuery("SELECT * FROM $T_SavedArticulos ORDER BY $NUM DESC");
    List<Articles> articulos=[];
    if(maps.length>0){
      for (int i=0; i<maps.length;i++){
        articulos.add(Articles.fromMap(maps[i]));
      }

    }
    return articulos;

  }


  Future<bool> isThisArticleSaved(int id) async{

    var dbClient=await db;
    int key=id;
    //List<Map> maps = await dbClient.query(TABLE,columns:[ID,NAME]);
    List<Map> maps= await dbClient.rawQuery("SELECT * FROM $T_SavedArticulos WHERE $NUM=$key ORDER BY $NUM DESC");
    if(maps.length>0){
      print("Articulo guardado en favoritos");
      return true;
    }else{
      print("Articulo no guardado en favoritos");
      return false;
    }

  }

  Future<Articles> saveArticle (Articles articulos) async{
    var dbClient = await db;
    // empleados.id =  await dbClient.insert(TABLE, empleados.toMap());
    //return empleados;
    if(await isThisArticleSaved(articulos.num)){
        print("Repetido");
        return null;
    }else{
      print("Guardando");
      await dbClient.transaction((txn) async{
        var query = "INSERT INTO $T_SavedArticulos ($ID, $NUM, $TITLE, $CONTENT, $IMAGE, $CATEGORY) VALUES ("+articulos.ID.toString()+","+articulos.num.toString()+",'"+articulos.title+"','"+articulos.content+"','"+articulos.image+"',"+articulos.category.toString()+")";
        return await txn.rawInsert(query);
      });
    }

  }


  Future<int> deleteSavedArticle(int id) async{

    var dbClient = await db;
    print("Borrando");
    return await dbClient.delete(T_SavedArticulos, where : "$NUM=?", whereArgs: [id]);
  }



}
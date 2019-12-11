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
    await db.execute("CREATE TABLE $T_Articulos ($ID INTEGER PRIMARY KEY, $NUM TEXT,$TITLE TEXT, $CONTENT TEXT, $IMAGE TEXT, $CATEGORY INTEGER)");
  }

  Future<Articles> insert (Articles articulos) async{
    var dbClient = await db;
    // empleados.id =  await dbClient.insert(TABLE, empleados.toMap());
    //return empleados;

    await dbClient.transaction((txn) async{
      var query = "INSERT INTO $T_Articulos ($ID, $NUM, $TITLE, $CONTENT, $IMAGE, $CATEGORY) VALUES ("+articulos.ID.toString()+","+articulos.num.toString()+",'Desde la BD','"+articulos.content+"','"+articulos.image+"',"+articulos.category.toString()+")";
      return await txn.rawInsert(query);
    });
  }

  Future deleteALL () async{
    var dbClient = await db;
    // empleados.id =  await dbClient.insert(TABLE, empleados.toMap());
    //return empleados;

    await dbClient.transaction((txn) async{
      var query = "DELETE FROM $T_Articulos";
      return await txn.rawInsert(query);
    });
  }

  Future<List<Articles>> getArticulos() async{
    var dbClient=await db;
    //List<Map> maps = await dbClient.query(TABLE,columns:[ID,NAME]);
    List<Map> maps= await dbClient.rawQuery("SELECT * FROM $T_Articulos ORDER BY $NUM DESC");
    List<Articles> articulos=[];
    if(maps.length>0){
      for (int i=0; i<maps.length;i++){
        articulos.add(Articles.fromMap(maps[i]));
      }

    }
    return articulos;

  }

  Future<int> delete(int id) async{

    var dbClient = await db;
    return await dbClient.delete(T_Articulos, where : "$ID=?", whereArgs: [id]);
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

}
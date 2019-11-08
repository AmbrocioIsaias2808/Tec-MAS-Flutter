import "package:flutter/material.dart";
import 'package:tecmas/Secciones/Estructures/Articles.dart';

import 'cards.dart';


class Widget_Articles extends StatelessWidget {

  List<Articles> entries = <Articles>[]; //Lista de Articulos

  Widget_Articles(){

    entries.add(Articles(id: 1, image: "https://i.blogs.es/a19bfc/testing/450_1000.jpg", title: "PASOS PARA SOLICITAR FICHA DE NUEVO INGRESO PARA INICIAR TU CARRERA  EN ENERO DEL 2020:"));
    entries.add(Articles(id: 2, image: "https://i.blogs.es/a19bfc/testing/450_1000.jpg", title: "Entrega de Reconocimientos y Constancias a Personal del Instituto Tecnológico de Matamoros"));
    entries.add(Articles(id: 3, image: "https://i.blogs.es/a19bfc/testing/450_1000.jpg", title: "Más de 1,200 Padres de Familia Asisten a Pláticas de Inducción Acompañados de sus Hijos"));
    entries.add(Articles(id: 4, image: "https://i.blogs.es/a19bfc/testing/450_1000.jpg", title: "Titulo de pruebas: lorem ipsum lorem ipsum"));
    entries.add(Articles(id: 5, image: "https://i.blogs.es/a19bfc/testing/450_1000.jpg", title: "Titulo de pruebas: lorem ipsum lorem ipsum"));
    entries.add(Articles(id: 6, image: "https://i.blogs.es/a19bfc/testing/450_1000.jpg", title: "Titulo de pruebas: lorem ipsum lorem ipsum"));
    entries.add(Articles(id: 7, image: "https://i.blogs.es/a19bfc/testing/450_1000.jpg", title: "Titulo de pruebas: lorem ipsum lorem ipsum"));
    entries.add(Articles(id: 8, image: "https://i.blogs.es/a19bfc/testing/450_1000.jpg", title: "Titulo de pruebas: lorem ipsum lorem ipsum"));
    entries.add(Articles(id: 9, image: "https://i.blogs.es/a19bfc/testing/450_1000.jpg", title: "Titulo de pruebas: lorem ipsum lorem ipsum"));
    entries.add(Articles(id: 10, image: "https://i.blogs.es/a19bfc/testing/450_1000.jpg", title: "Titulo de pruebas: lorem ipsum lorem ipsum"));
    print(entries.toList()[0].title);
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      child: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return cards(articulo: entries[index]);
          }
      ),
    );
  }
}

import 'dart:ffi';

class sensor{
  final int id, valu;
  final String title, image, unit;

  sensor(
      {required this.id,
      required this.image,
      required this.title,
      required this.unit,
      required this.valu,

      });
}

// list of products
List<sensor> sensors = [
  sensor(
    id: 1,
    valu: 35,
    title:"Temp valu",
    image:"images/temp.png",
    unit:"C"
  ),
  sensor(
    id: 2,
    valu: 2,
    title:"PH",
    image:"images/phh.png",
    unit:"ph",
  ),
  sensor(
    id: 3,
    valu: 600,
    title:"Turbidity",
    image:"images/trub.png",
    unit: "T"
  ),
];

class Sensor {
  final int id, valu;
  final String title, image, unit;

  Sensor({
    required this.id,
    required this.image,
    required this.title,
    required this.unit,
    required this.valu,
  });
}

// list of products
List<Sensor> sensors = [
  Sensor(
      id: 1, valu: 35, title: "Temp valu", image: "images/temp.png", unit: "C"),
  Sensor(
    id: 2,
    valu: 2,
    title: "PH",
    image: "images/phh.png",
    unit: "ph",
  ),
  Sensor(
      id: 3,
      valu: 600,
      title: "Turbidity",
      image: "images/trub.png",
      unit: "T"),
];

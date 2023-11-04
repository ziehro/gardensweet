class GardenBed {
  final String id;
  final String name;
  final List<Plant> plants;

  GardenBed(this.id, this.name, this.plants);
}

class Plant {
  final String id;
  final String name;
  final DateTime plantingDate;
  final DateTime harvestDate;

  Plant(this.id, this.name, this.plantingDate, this.harvestDate);
}

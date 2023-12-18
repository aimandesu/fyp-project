class HazardPercentageModel {
  final String hazard;
  final int numberCases;
  final int hazardCases;

  HazardPercentageModel({
    required this.hazard,
    required this.numberCases,
    required this.hazardCases,
});

  double percentage(){
   final val = hazardCases / numberCases * 100;
   return num.parse(val.toStringAsFixed(2)) as double;
  }

}
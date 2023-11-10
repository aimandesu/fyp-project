class RacePercentageModel {
  final String race;
  final int numberCases;
  final int raceCases;

  RacePercentageModel({
    required this.race,
    required this.numberCases,
    required this.raceCases,
});

  double percentage(){
   final val = raceCases / numberCases * 100;
   return num.parse(val.toStringAsFixed(2)) as double;
  }

}
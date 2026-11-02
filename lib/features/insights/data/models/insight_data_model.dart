import '../../domain/entities/insight_data.dart';

class InsightDataModel extends InsightData {
  const InsightDataModel({
    required super.userName,
    required super.userBirthDate,
    required super.sunSign,
    required super.moonSign,
    required super.focusArea,
    required super.horoscopeText,
    required super.favourableDirection,
    required super.luckyColour,
    required super.funFactText,
    required super.luckyNumber,
    required super.guidanceText,
    required super.destinyNumber,
    required super.destinyTitle,
  });

  factory InsightDataModel.fromJson(Map<String, dynamic> json) {
    return InsightDataModel(
      userName: json['userName'] as String,
      userBirthDate: json['userBirthDate'] as String,
      sunSign: json['sunSign'] as String,
      moonSign: json['moonSign'] as String,
      focusArea: json['focusArea'] as String,
      horoscopeText: json['horoscopeText'] as String,
      favourableDirection: json['favourableDirection'] as String,
      luckyColour: json['luckyColour'] as String,
      funFactText: json['funFactText'] as String,
      luckyNumber: json['luckyNumber'] as int,
      guidanceText: json['guidanceText'] as String,
      destinyNumber: json['destinyNumber'] as int,
      destinyTitle: json['destinyTitle'] as String,
    );
  }
}

import 'package:equatable/equatable.dart';

enum InsightPeriod { yesterday, today, tomorrow, week, month }

class InsightData extends Equatable {
  const InsightData({
    required this.userName,
    required this.userBirthDate,
    required this.sunSign,
    required this.moonSign,
    required this.focusArea,
    required this.horoscopeText,
    required this.favourableDirection,
    required this.luckyColour,
    required this.funFactText,
    required this.luckyNumber,
    required this.guidanceText,
    required this.destinyNumber,
    required this.destinyTitle,
  });

  final String userName;
  final String userBirthDate;
  final String sunSign;
  final String moonSign;
  final String focusArea;
  final String horoscopeText;
  final String favourableDirection;
  final String luckyColour;
  final String funFactText;
  final int luckyNumber;
  final String guidanceText;
  final int destinyNumber;
  final String destinyTitle;

  @override
  List<Object?> get props => [
        userName,
        userBirthDate,
        sunSign,
        moonSign,
        focusArea,
        horoscopeText,
        favourableDirection,
        luckyColour,
        funFactText,
        luckyNumber,
        guidanceText,
        destinyNumber,
        destinyTitle,
      ];
}

class AthleteProfile {
  const AthleteProfile({
    required this.fullName,
    required this.dateOfBirth,
    required this.gender,
    required this.height,
    required this.weight,
    required this.location,
    required this.preferredSport,
    required this.experienceLevel,
    required this.position,
    required this.dominantSide,
  });

  final String fullName;
  final DateTime dateOfBirth;
  final String gender;
  final String height;
  final String weight;
  final String location;
  final String preferredSport;
  final String experienceLevel;
  final String position;
  final String dominantSide;
}
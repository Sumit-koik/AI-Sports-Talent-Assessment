import '../models/athlete_profile.dart';

class AthleteProfileData {
  static final mockProfile = AthleteProfile(
    fullName: 'Alex Morgan',
    dateOfBirth: DateTime(2004, 7, 18),
    gender: 'Prefer not to say',
    height: '178 cm',
    weight: '72 kg',
    location: 'Pune, India',
    preferredSport: 'Football',
    experienceLevel: 'Intermediate',
    position: 'Midfielder',
    dominantSide: 'Right foot',
  );
}
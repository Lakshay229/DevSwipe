class UserModel {
  final String id;
  final String username;
  final String email;
  final String password;
  final String college;
  final String about;
  final int rating;
  final String profilePicture;
  final DateTime dob;
  final String phoneNum;
  final Coins coins;
  final UserSocials socials;
  final UserSkills skills;
  final ProjectActivity projects;
  final HackathonActivity hackathons;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    this.college = '',
    this.about = '',
    this.rating = 0,
    this.profilePicture = '',
    required this.dob,
    this.phoneNum = '',
    required this.coins,
    required this.socials,
    required this.skills,
    required this.projects,
    required this.hackathons,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      username: json['username'] ?? '', 
      email: json['email'] ?? '', // Provide default empty string if null
      password: json['password'] ?? '', // Provide default empty string if null
      college: json['college'] ?? '', // Default to empty string if null
      about: json['about'] ?? '', // Default to empty string if null
      rating: json['rating'] ?? 0, // Default to 0 if null
      profilePicture:
          json['profilePicture'] ?? '', // Default to empty string if null
      dob: json['DOB'] != null
          ? DateTime.parse(json['DOB'])
          : DateTime.now(), // Default to current date if null
      phoneNum: json['phoneNum'] ?? '', // Default to empty string if null
      coins:
          Coins.fromJson(json['coins'] ?? {}), // Default to empty Coins if null
      socials: UserSocials.fromJson(
          json['socials'] ?? {}), // Default to empty UserSocials if null
      skills: UserSkills.fromJson(
          json['skills'] ?? {}), // Default to empty UserSkills if null
      projects: ProjectActivity.fromJson(
          json['projects'] ?? {}), // Default to empty ProjectActivity if null
      hackathons: HackathonActivity.fromJson(json['hackathons'] ??
          {}), // Default to empty HackathonActivity if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'email': email,
      'password': password,
      'college': college,
      'about': about,
      'rating': rating,
      'profilePicture': profilePicture,
      'DOB': dob.toIso8601String(),
      'phoneNum': phoneNum,
      'coins': coins.toJson(),
      'socials': socials.toJson(),
      'skills': skills.toJson(),
      'projects': projects.toJson(),
      'hackathons': hackathons.toJson(),
    };
  }
}

class Coins {
  final int powerCoins;
  final int achievementCoins;

  Coins({
    required this.powerCoins,
    required this.achievementCoins,
  });

  factory Coins.fromJson(Map<String, dynamic> json) {
    return Coins(
      powerCoins: json['powerCoins'] ?? 0, // Default to 0 if null
      achievementCoins: json['achievementCoins'] ?? 0, // Default to 0 if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'powerCoins': powerCoins,
      'achievementCoins': achievementCoins,
    };
  }
}

class UserSocials {
  final String githubUsername;
  final String linkedin;
  final String website;

  UserSocials({
    this.githubUsername = '', // Default to empty string if null
    this.linkedin = '', // Default to empty string if null
    this.website = '', // Default to empty string if null
  });

  factory UserSocials.fromJson(Map<String, dynamic> json) {
    return UserSocials(
      githubUsername:
          json['githubUsername'] ?? '', // Default to empty string if null
      linkedin: json['linkedin'] ?? '', // Default to empty string if null
      website: json['website'] ?? '', // Default to empty string if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'githubUsername': githubUsername,
      'linkedin': linkedin,
      'website': website,
    };
  }
}

class UserSkills {
  final List<String> languages;
  final List<String> frameworks;
  final List<String> softwares;

  UserSkills({
    this.languages = const [], // Default to empty list if null
    this.frameworks = const [], // Default to empty list if null
    this.softwares = const [], // Default to empty list if null
  });

  factory UserSkills.fromJson(Map<String, dynamic> json) {
    return UserSkills(
      languages: List<String>.from(
          json['languages'] ?? []), // Default to empty list if null
      frameworks: List<String>.from(
          json['frameworks'] ?? []), // Default to empty list if null
      softwares: List<String>.from(
          json['softwares'] ?? []), // Default to empty list if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'languages': languages,
      'frameworks': frameworks,
      'softwares': softwares,
    };
  }
}

class ProjectActivity {
  final List<String> ownProjects;
  final List<String> activeProjects;
  final List<String> finishedProjects;
  final List<String> likedProjects;
  final List<String> appliedProjects;

  ProjectActivity({
    this.ownProjects = const [], // Default to empty list if null
    this.activeProjects = const [], // Default to empty list if null
    this.finishedProjects = const [], // Default to empty list if null
    this.likedProjects = const [], // Default to empty list if null
    this.appliedProjects = const [], // Default to empty list if null
  });

  factory ProjectActivity.fromJson(Map<String, dynamic> json) {
    return ProjectActivity(
      ownProjects: List<String>.from(
          json['ownProjects'] ?? []), // Default to empty list if null
      activeProjects: List<String>.from(
          json['activeProjects'] ?? []), // Default to empty list if null
      finishedProjects: List<String>.from(
          json['finishedProjects'] ?? []), // Default to empty list if null
      likedProjects: List<String>.from(
          json['likedProjects'] ?? []), // Default to empty list if null
      appliedProjects: List<String>.from(
          json['appliedProjects'] ?? []), // Default to empty list if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ownProjects': ownProjects,
      'activeProjects': activeProjects,
      'finishedProjects': finishedProjects,
      'likedProjects': likedProjects,
      'appliedProjects': appliedProjects,
    };
  }
}

class HackathonActivity {
  final List<String> ownHackathon;
  final List<String> likedHackathon;
  final List<String> appliedHackathon;

  HackathonActivity({
    this.ownHackathon = const [], // Default to empty list if null
    this.likedHackathon = const [], // Default to empty list if null
    this.appliedHackathon = const [], // Default to empty list if null
  });

  factory HackathonActivity.fromJson(Map<String, dynamic> json) {
    return HackathonActivity(
      ownHackathon: List<String>.from(
          json['ownHackathon'] ?? []), // Default to empty list if null
      likedHackathon: List<String>.from(
          json['likedHackathon'] ?? []), // Default to empty list if null
      appliedHackathon: List<String>.from(
          json['appliedHackathon'] ?? []), // Default to empty list if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ownHackathon': ownHackathon,
      'likedHackathon': likedHackathon,
      'appliedHackathon': appliedHackathon,
    };
  }
}

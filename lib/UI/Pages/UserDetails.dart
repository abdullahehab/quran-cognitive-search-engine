class UserDetails {
  String birth,
      education,
      email,
      jobTitle,
      name,
      numberOfParts,
      numberOfReading,
      type,
      photoUrl;

  UserDetails(
      {this.birth,
      this.education,
      this.email,
      this.jobTitle,
      this.name,
      this.numberOfParts,
      this.numberOfReading,
      this.type,
      this.photoUrl});

  factory UserDetails.fromMap(Map<String, dynamic> json) {
    return new UserDetails(
        birth: json['birth'],
        education: json['education'],
        email: json['email'],
        jobTitle: json['jobTitle'],
        name: json['name'],
        numberOfParts: json['numberOfParts'],
        numberOfReading: json['numberOfReading'],
        type: json['type'],
        photoUrl: json['photoUrl']);
  }
}

//model class
class StudentModel {
  // Declare based on Column names in your database
  final String? id;
  final String? name;
  final String? number;
  final String? email;
  final String? location;
  final String? imagePath;


  // Create constructor to initialize the model class variables
  StudentModel({
    this.id,
    this.name,
    this.number,
    this.email,
    this.location,
    this.imagePath,
  });

  //for saving data to db
  //name must be same as table name in db
  // Method - 1
  // modelClass to map to db
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'email': email,
      'location': location,
      'imagePath': imagePath,
    };
  }

  // Method - 2
  // map to model class from db
  //for retrieving data from db
  static StudentModel fromMap(Map<String, dynamic> map) {
    return StudentModel(
      id: map['id'].toString(),
      name: map['name'],
      number: map['number'].toString(),
      email: map['email'],
      location: map['location'],
      imagePath: map['imagePath'],
    );
  }
}

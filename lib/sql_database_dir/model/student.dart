//model class
class Student {
  int? id;
  String? title;
  String? description;

  //constructor
  Student({
    this.id,
    this.title,
    this.description
  });


  //for saving data to db
  //name must be same as table name in db
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }

  //for retrieving data from db
  static Student fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }
}
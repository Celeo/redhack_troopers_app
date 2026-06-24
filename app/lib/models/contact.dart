class Contact {
  final String name;
  final String occupation;
  final String notes;

  const Contact({this.name = '', this.occupation = '', this.notes = ''});

  Contact copyWith({String? name, String? occupation, String? notes}) => Contact(
        name: name ?? this.name,
        occupation: occupation ?? this.occupation,
        notes: notes ?? this.notes,
      );

  Map<String, dynamic> toJson() => {'name': name, 'occupation': occupation, 'notes': notes};

  factory Contact.fromJson(Map<String, dynamic> j) => Contact(
        name: j['name'] as String? ?? '',
        occupation: j['occupation'] as String? ?? '',
        notes: j['notes'] as String? ?? '',
      );
}

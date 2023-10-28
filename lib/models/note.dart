import 'dart:convert';

class Note {
  Note({
    required this.text,
    required this.id,
  });

  final String text;
  final String id;

  Note copyWith({
    String? text,
    String? id,
  }) {
    return Note(
      text: text ?? this.text,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'id': id,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      text: map['text'] ?? '',
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source));

  @override
  String toString() => 'Note(text: $text, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Note && other.text == text && other.id == id;
  }

  @override
  int get hashCode => text.hashCode ^ id.hashCode;
}

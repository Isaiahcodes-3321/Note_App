

class ModelReadTrash {
  bool? success;
  String? message;
  List<NoteTrash>? notes;

  ModelReadTrash({
    this.success,
    this.message,
    this.notes,
  });

  ModelReadTrash.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['notes'] != null) {
      notes = <NoteTrash>[];
      json['notes'].forEach((e) {
        notes!.add(NoteTrash.fromJson(e));
      });
    }
  }

  get noteItems => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (notes != null) {
      data['notes'] = notes!.map((e) => e.toJson()).toList();
    }
    return data;
  }
}





class NoteTrash{
  String? noteId;
  // int? userId;
  String? title;
  String? note;
  String? date;
  // XFile? image;

  NoteTrash({
    this.noteId,
    // this.userId,
    this.title,
    this.note,
    this.date,
    // this.image
  });

  NoteTrash.fromJson(Map<String, dynamic> json) {
    noteId = json['note_id'];
    // userId = json['user_id'];
    title = json['title'];
    note = json['note'];
    date = json['created_at'];
    // image = json['image'];
    // print('From dataBase.. $note');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['note_id'] = noteId;
    // data['user_id'] = this.userId;
    data['title'] = title;
    data['note'] = note;
    data['created_at'] = date;
    // data['image'] = image;
    return data;
  }
}

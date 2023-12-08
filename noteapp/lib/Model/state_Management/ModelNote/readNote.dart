


class ModelR {
  bool? success;
  String? message;
  List<NoteR>? notes;

  ModelR({
    this.success,
    this.message,
    this.notes,
  });

  ModelR.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['note'] != null) {
      notes = <NoteR>[];
      json['note'].forEach((e) {
        notes!.add(NoteR.fromJson(e));
      });
    }
  }

  get noteItems => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (notes != null) {
      data['note'] = notes!.map((e) => e.toJson()).toList();
    }
    return data;
  }
}





class NoteR {
  String? noteId;
  // int? userId;
  String? title;
  String? note;
  String? date;
  String? image;

  NoteR({
    this.noteId,
    // this.userId,
    this.title,
    this.note,
    this.date,
    this.image,
  });

  NoteR.fromJson(Map<String, dynamic> json) {
    noteId = json['note_id'];
    // userId = json['user_id'];
    title = json['title'];
    note = json['note'];
    date = json['created_at'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['note_id'] = noteId;
    // data['user_id'] = this.userId;
    data['title'] = title;
    data['note'] = note;
    data['created_at'] = date;
    data['image'] = image;
    return data;
  }
}

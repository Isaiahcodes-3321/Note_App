

class ModelS {
  bool? success;
  String? message;
  List<NoteS>? notes;

  ModelS({
    this.success,
    this.message,
    this.notes,
  });

  ModelS.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['note'] != null) {
      notes = <NoteS>[];
      json['note'].forEach((e) {
        notes!.add(NoteS.fromJson(e));
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





class NoteS {
  String? noteId;
  // int? userId;
  String? title;
  String? note;
  String? date;
  // XFile? image;

  NoteS({
    this.noteId,
    // this.userId,
    this.title,
    this.note,
    this.date,
    // this.image,
  });

  NoteS.fromJson(Map<String, dynamic> json) {
    noteId = json['note_id'];
    // userId = json['user_id'];
    title = json['title'];
    note = json['note'];
    date = json['created_at'];
    // image = json['image'];
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

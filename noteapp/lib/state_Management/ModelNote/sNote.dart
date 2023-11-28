

class Model2 {
  bool? success;
  String? message;
  List<NoteS>? notes;

  Model2({
    this.success,
    this.message,
    this.notes,
  });

  Model2.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['notes'] != null) {
      notes = <NoteS>[];
      json['notes'].forEach((e) {
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
      data['notes'] = notes!.map((e) => e.toJson()).toList();
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

  NoteS({
    this.noteId,
    // this.userId,
    this.title,
    this.note,
    this.date,
  });

  NoteS.fromJson(Map<String, dynamic> json) {
    noteId = json['note_id'];
    // userId = json['user_id'];
    title = json['title'];
    note = json['note'];
    date = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['note_id'] = noteId;
    // data['user_id'] = this.userId;
    data['title'] = title;
    data['note'] = note;
    data['created_at'] = date;
    return data;
  }
}

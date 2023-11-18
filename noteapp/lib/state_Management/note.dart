import 'package:flutter/material.dart';


class Model {
  bool? success;
  String? message;
  List<Note>? notes;

  Model({
    this.success,
    this.message,
    this.notes,
  });

  Model.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['notes'] != null) {
      notes = <Note>[];
      json['notes'].forEach((e) {
        notes!.add(new Note.fromJson(e));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.notes != null) {
      data['notes'] = this.notes!.map((e) => e.toJson()).toList();
    }
    return data;
  }
}





class Note {
  // int? noteId;
  // int? userId;
  String? title;
  String? note;
  String? date;

  Note({
    // this.noteId,
    // this.userId,
    this.title,
    this.note,
    this.date,
  });

  Note.fromJson(Map<String, dynamic> json) {
    // noteId = json['noteid'];
    // userId = json['user_id'];
    title = json['title'];
    note = json['note'];
    date = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['note_id'] = this.noteId;
    // data['user_id'] = this.userId;
    data['title'] = this.title;
    data['note'] = this.note;
    data['created_at'] = this.date;
    return data;
  }
}

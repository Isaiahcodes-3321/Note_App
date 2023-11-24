class ApiServiceState {
  final String registrationEndpoint =
      "https://note-api-amz2.onrender.com/api/v1/auth/signup";
  final String loginEndpoint =
      "https://note-api-amz2.onrender.com/api/v1/auth/login";
  final String refreshToken =
      "https://note-api-amz2.onrender.com/api/v1/auth/refreshToken";
  final String logOutEndpoint =
      "https://note-api-amz2.onrender.com/api/v1/auth/logout";
  final String createNoteEndpoint =
      "https://note-api-amz2.onrender.com/users/notes/create-note";
  final String getListNoteEndpoint =
      "https://note-api-amz2.onrender.com/users/notes/list-notes";
  final String redUserNOTE =
      "https://note-api-amz2.onrender.com/users/notes/readnote/5";
  final String updateNoteEndpoint =
      "https://note-api-amz2.onrender.com/users/notes/updatenotes/5";
  final String deleteNoteEndpoint =
      "https://note-api-amz2.onrender.com/users/notes/deletenotes/5";
  final String searchNoteEndpoint =
      "https://note-api-amz2.onrender.com/users/notes/search?searchQuery=My ";
  final String viewTrash =
      "https://note-api-amz2.onrender.com/users/notes/trash";
  final String restoreTrash =
      "https://note-api-amz2.onrender.com/users/notes/trash/restore/:noteId";
  final String deleteTrash =
      "https://note-api-amz2.onrender.com/users/notes/trash/delete/:noteId";
  final String emptyTrash =
      "https://note-api-amz2.onrender.com/users/notes/trash/empty-trash";
}

class Status {
  final String userName;
  final String imageUrl;
  final String date;
  String? message;
  bool? isSeen;

  Status({
    required this.userName,
    required this.imageUrl,
    required this.date,
  });
}

final statuses = [
    Status(
      userName: 'Foto Sushi',
      imageUrl: 'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
      date: 'Today, 4:29 AM',
    ),
    Status(
      userName: 'Yasin Mohammadi',
      imageUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
      date: 'Today, 5:10 AM',
    ),
  ];
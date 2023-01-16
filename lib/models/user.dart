class User {
  final int id;
  final String name;
  final String imageUrl;
  final bool isOnline;

  User(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.isOnline});
}

final User currentUser = User(
  id: 0,
  name: 'Teacher',
  imageUrl: 'https://picsum.photos/250?image=9',
  isOnline: true,
);

final User Zhuma = User(
  id: 1,
  name: 'Zhuma',
  imageUrl: 'https://picsum.photos/250?image=9',
  isOnline: true,
);

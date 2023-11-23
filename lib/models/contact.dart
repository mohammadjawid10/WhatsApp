class Contact {
  final String name;
  final String bio;
  final String imageUrl;

  Contact({
    required this.name,
    required this.bio,
    required this.imageUrl,
  });
}

final dummyContacts = [
  Contact(
    name: 'Albert Dera',
    imageUrl: 'photo1.jpg',
    bio: 'Not available',
  ),
  Contact(
    name: 'Sekandar Hayat',
    imageUrl: 'photo8.jpg',
    bio: 'Work hard today, Let tomorrow be yours.',
  ),
  Contact(
    name: 'Harps Joseph',
    imageUrl: 'photo4.jpg',
    bio: 'Success is my cup of tea',
  ),
  Contact(
    name: 'Joseph Gonzales',
    imageUrl: 'photo6.jpg',
    bio: '',
  ),
  Contact(
    name: 'Ian Dooley',
    imageUrl: 'photo5.jpg',
    bio: 'Programmer and Manga reader',
  ),
  Contact(
    name: 'Seth Doyle',
    imageUrl: 'photo7.jpg',
    bio: "You can't reply to this conversation anymore",
  ),
  Contact(
    name: 'Ayo Ogunseinde',
    imageUrl: 'photo2.jpg',
    bio: 'Available',
  ),
  Contact(
    name: 'Foto Sushi',
    imageUrl: 'photo3.jpg',
    bio: 'This is a business account...',
  ),
  Contact(name: 'Warren Wong', imageUrl: 'photo9.jpg', bio: ''),
];

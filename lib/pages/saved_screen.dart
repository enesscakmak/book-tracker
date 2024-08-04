import 'package:flutter/material.dart';
import 'package:reader_tracker/db/database_helper.dart';
import 'package:reader_tracker/models/book.dart';
import 'package:reader_tracker/utils/book_details_arguments.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({
    super.key,
  });

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: FutureBuilder(
          future: DatabaseHelper.instance.readAllBooks(),
          builder: (context, snapshot) => snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Book book = snapshot.data![index];
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/details',
                            arguments: BookDetailsArguments(
                                itemBook: book, isFromSavedScreen: true));
                      },
                      child: Card(
                        color: const Color.fromARGB(255, 227, 227, 227),
                        child: ListTile(
                          textColor: Colors.black,
                          titleTextStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                          title: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 5.0, top: 3.0),
                            child: Center(child: Text(book.title)),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              print("Deleted ${book.id}");
                              DatabaseHelper.instance.deleteBook(book.id);
                              setState(() {});
                            },
                          ),
                          leading: Image.network(
                            book.imageLinks['thumbnail'] ?? '',
                            fit: BoxFit.cover,
                          ),
                          subtitle: Center(
                            child: Column(
                              children: [
                                Text(
                                  book.authors.join(
                                    ", ",
                                  ),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                ElevatedButton.icon(
                                    onPressed: () async {
                                      book.isFavorite = !book.isFavorite;
                                      await DatabaseHelper.instance
                                          .toggleFavoriteStatus(
                                              book.id, book.isFavorite);

                                      //refresh
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      book.isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_outline,
                                      color:
                                          book.isFavorite ? Colors.red : null,
                                    ),
                                    label: Text(
                                      book.isFavorite
                                          ? 'Favorite'
                                          : 'Add to Favorites',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                          color: Colors.black54),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
              : const Center(child: CircularProgressIndicator())),
    ));
  }
}

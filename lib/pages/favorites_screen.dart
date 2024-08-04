import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:reader_tracker/db/database_helper.dart';
import 'package:reader_tracker/models/book.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: DatabaseHelper.instance.getFavorites(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              List<Book> favBooks = snapshot.data!;

              return Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: ListView.builder(
                    itemCount: favBooks.length,
                    itemBuilder: (context, index) {
                      Book book = favBooks[index];
                      return Card(
                        child: ListTile(
                          leading: Image.network(
                              book.imageLinks['thumbnail'] ?? '',
                              fit: BoxFit.cover),
                          title: Text(
                            book.authors.join(", "),
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 17),
                          ),
                          trailing: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                        ),
                      );
                    }),
              );
            } else {
              return const Center(
                child: Text(
                  "No favorite books found.",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              );
            }
          }),
    );
  }
}

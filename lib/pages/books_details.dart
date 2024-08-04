import 'package:flutter/material.dart';
import 'package:reader_tracker/db/database_helper.dart';
import 'package:reader_tracker/models/book.dart';
import 'package:reader_tracker/utils/book_details_arguments.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({super.key});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as BookDetailsArguments;
    final Book book = args.itemBook;
    final bool isFromSavedScreen = args.isFromSavedScreen;
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              if (book.imageLinks.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Image.network(
                    book.imageLinks['thumbnail'] ?? "",
                    fit: BoxFit.cover,
                  ),
                ),
              Column(
                children: [
                  Text(
                    book.title,
                    style: theme.titleLarge,
                  ),
                  Text(
                    book.authors.join(', '),
                    style: theme.titleMedium,
                  ),
                  Text(
                    'Published: ${book.publishedDate}',
                    style: theme.bodyMedium,
                  ),
                  Text(
                    'Page count: ${book.pageCount}',
                    style: theme.bodyMedium,
                  ),
                  Text(
                    'Langauge: ${book.language}',
                    style: theme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    child: !isFromSavedScreen
                        ? ElevatedButton(
                            onPressed: () async {
                              try {
                                int savedInt =
                                    await DatabaseHelper.instance.insert(book);
                                SnackBar snackBar = SnackBar(
                                    content: Text("Book Saved $savedInt"));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } catch (e) {
                                print("Error: $e");
                              }
                            },
                            child: Text(
                              "Save",
                              style: theme.titleMedium,
                            ))
                        : ElevatedButton.icon(
                            onPressed: () async {},
                            icon: const Icon(Icons.favorite),
                            label: const Text("Favorite"),
                          ),
                  ),
                  // Row(
                  //   mainAxisAlignment: !isFromSavedScreen
                  //       ? MainAxisAlignment.spaceEvenly
                  //       : MainAxisAlignment.center,
                  //   children: [
                  //     !isFromSavedScreen
                  //         ? ElevatedButton(
                  //             onPressed: () async {
                  //               try {
                  //                 int savedInt = await DatabaseHelper.instance
                  //                     .insert(book);
                  //                 SnackBar snackBar = SnackBar(
                  //                     content: Text("Book Saved $savedInt"));
                  //                 ScaffoldMessenger.of(context)
                  //                     .showSnackBar(snackBar);
                  //               } catch (e) {
                  //                 print("Error: $e");
                  //               }
                  //             },
                  //             child: Text("Save"))
                  //         : const SizedBox(),
                  //     const SizedBox(
                  //       height: 10,
                  //     ),
                  //     ElevatedButton.icon(
                  //       onPressed: () async {},
                  //       icon: Icon(Icons.favorite),
                  //       label: Text("Favorite"),
                  //     )
                  //   ],
                  // ),

                  const SizedBox(height: 10),
                  Text(
                    "Description",
                    style: theme.titleMedium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(80, 218, 205, 255),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Theme.of(context).colorScheme.secondary)),
                    child: Text(
                      book.description,
                      style: theme.titleSmall,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

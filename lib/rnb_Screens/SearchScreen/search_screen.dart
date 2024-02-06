import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rides_n_bikes/rnb_Screens/ProfileScreen/Profile/ProfilePic/default_profile_image.dart';
import 'package:rides_n_bikes/rnb_Widgets/my_pictures.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Search', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            color: Colors.black,
            onPressed: () {
              // Öffnet die Suchansicht mit einem benutzerdefinierten Such-Delegaten
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection('posts').get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var post = snapshot.data!.docs[index].data();
                return GestureDetector(
                  onTap: () {
                    // Hier kannst du die Logik für die Behandlung eines Klicks auf ein Bild hinzufügen.
                  },
                  child: CachedNetworkImage(
                    imageUrl: post['postUrl'],
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  // Funktion zum Aufbau der Suchergebnisse

  Widget _buildSearchResults(String query) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('Users').get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Fehler beim Laden der Daten'),
          );
        } else {
          final List<DocumentSnapshot> allUsers = snapshot.data!.docs;
          final List<DocumentSnapshot> matchingUsers = allUsers.where((user) {
            final String username = user['username'].toString().toLowerCase();
            return username.contains(query.toLowerCase());
          }).toList();

          if (matchingUsers.isEmpty) {
            return const Center(
              child: Text('Keine Ergebnisse gefunden'),
            );
          }

          return ListView.builder(
            itemCount: matchingUsers.length,
            itemBuilder: (context, index) {
              var userData = matchingUsers[index].data() as Map<String, dynamic>;
              var result = userData['username'];
              // Profilbild-URL oder Standardbild-URL, falls kein Profilbild vorhanden ist
              var profileImageUrl = userData['profileImageUrl'] ?? defaultProfileImageUrl;

              return GestureDetector(
                onTap: () {
                  // Hier kannst du die Aktion implementieren, wenn auf ein Suchergebnis getippt wird
                  print('Tapped on $result');
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(profileImageUrl),
                  ),
                  title: Text(result),
                ),
              );
            },
          );
        }
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Aktion zum Löschen der Suchanfrage
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context, null); // Schließt die Suchansicht und gibt `null` zurück
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) {
      return _buildSearchResults(query); // Zeigt Suchergebnisse basierend auf der aktuellen Anfrage an
    } else {
      return Container(); // Leerer Container, wenn die Suchanfrage leer ist
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return _buildSearchResults(query); // Zeigt Suchergebnisse basierend auf der aktuellen Anfrage an
    } else {
      return Container(); // Leerer Container, wenn die Suchanfrage leer ist
    }
  }
}

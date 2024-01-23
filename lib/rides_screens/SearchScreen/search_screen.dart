import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rides_n_bikes/rides_screens/ProfileScreen/Profile/ProfilePic/default_profile_image.dart';
import 'package:rides_n_bikes/rides_widgets/my_pictures.dart';

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
      body: ListView(
        children: const [
          MyPictures(),
          MyPictures(),
          MyPictures(),
        ],
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
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
        close(context, null); // Schließt die Suchansicht und gibt `null` zurück
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

  // Funktion zum Aufbau der Suchergebnisse
  Widget _buildSearchResults(String query) {
    return FutureBuilder(
      // Firebase-Abfrage, um Benutzerdaten abzurufen
      future: FirebaseFirestore.instance.collection('Users').where('username', isGreaterThanOrEqualTo: query).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Fehler beim Laden der Daten'),
          );
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('Keine Ergebnisse gefunden'),
          );
        } else {
          // Ergebnisse als Listenelemente anzeigen
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var userData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
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
}

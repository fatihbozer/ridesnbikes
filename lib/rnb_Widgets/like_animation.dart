import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LikeAnimation extends StatefulWidget {
  final Widget child;
  final bool isAnimating;
  final Duration duration;
  final VoidCallback? onEnd;
  final bool smallLike;

  const LikeAnimation({
    super.key,
    required this.child,
    required this.isAnimating,
    this.duration = const Duration(milliseconds: 150),
    this.onEnd,
    this.smallLike = false,
  });

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: widget.duration.inMilliseconds ~/ 2,
      ),
    );
    scale = Tween<double>(begin: 1, end: 1.2).animate(controller);
  }

  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isAnimating != oldWidget.isAnimating) {
      startAnimation();
    }
  }

  startAnimation() async {
    if (widget.isAnimating || widget.smallLike) {
      await controller.forward();
      await controller.reverse();
      await Future.delayed(
        const Duration(
          milliseconds: 200,
        ),
      );

      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }
}

Future<void> addLikeToPost(String postId) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final currentUserID = user.uid;

      final postReference = FirebaseFirestore.instance.collection('Users').doc(user.email).collection('posts').doc(postId);

      // Lese die aktuelle Liste der Likes aus der Firestore-Datenbank
      final DocumentSnapshot postSnapshot = await postReference.get();
      final List<String> likes = List<String>.from(postSnapshot['likes']);

      // Überprüfe, ob der aktuelle Benutzer die Seite bereits geliked hat
      if (!likes.contains(currentUserID)) {
        // Füge die Benutzer-ID des aktuellen Benutzers zur Liste der Likes hinzu
        likes.add(currentUserID);

        // Aktualisiere die Liste der Likes in der Firestore-Datenbank
        await postReference.update({
          'likes': likes
        });

        print('Like erfolgreich hinzugefügt!');
      } else {
        print('Der Benutzer hat bereits geliked.');
      }
    }
  } catch (error) {
    print('Fehler beim Hinzufügen des Likes: $error');
    // Hier könntest du eine Fehlermeldung anzeigen oder andere Maßnahmen ergreifen
  }
}

Future<void> removeLikeFromPost(String postId) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final currentUserID = user.uid;

      final postReference = FirebaseFirestore.instance.collection('Users').doc(user.email).collection('posts').doc(postId);

      // Lese die aktuelle Liste der Likes aus der Firestore-Datenbank
      final DocumentSnapshot postSnapshot = await postReference.get();
      final List<String> likes = List<String>.from(postSnapshot['likes']);

      // Überprüfe, ob der aktuelle Benutzer die Seite bereits geliked hat
      if (likes.contains(currentUserID)) {
        // Entferne die Benutzer-ID des aktuellen Benutzers aus der Liste der Likes
        likes.remove(currentUserID);

        // Aktualisiere die Liste der Likes in der Firestore-Datenbank
        await postReference.update({
          'likes': likes
        });

        print('Like erfolgreich entfernt!');
      } else {
        print('Der Benutzer hat diesen Beitrag noch nicht geliked.');
      }
    }
  } catch (error) {
    print('Fehler beim Entfernen des Likes: $error');
    // Hier könntest du eine Fehlermeldung anzeigen oder andere Maßnahmen ergreifen
  }
}

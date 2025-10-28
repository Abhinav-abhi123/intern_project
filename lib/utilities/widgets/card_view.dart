import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ordinary/utilities/widgets/player_popup.dart';
import '../../service/state_management/AddPlayer/player_store.dart';
import '../../model/player_model.dart';
import '../app_color.dart';

class CardView extends StatelessWidget {
  const CardView({
    super.key,
    required this.playerStore,
    this.showEdit = true,
    this.showDelete = true,
    this.showTime = true,
    this.showOnlySaved = false,
  });

  final PlayerStore playerStore;
  final bool showEdit;
  final bool showDelete;
  final bool showTime;
  final bool showOnlySaved;

  /// Format date and time for display
  String _formatDateTime(String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) return '';
    try {
      final dt = DateTime.parse(dateTime);
      return DateFormat('dd MMM yyyy • hh:mm a').format(dt);
    } catch (e) {
      return dateTime;
    }
  }

  /// Show edit form popup


  /// Delete confirmation popup
  void _showDeleteConfirmation(BuildContext context, PlayerStore store, Player player) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: AppColors.purewhite,
        title: const Text('Delete Player', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Are you sure you want to delete this player?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: AppColors.fadedcolor)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            onPressed: () async {
              await store.deletePlayer(player);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Player deleted successfully'),
                  backgroundColor: Colors.redAccent,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: Text('Delete', style: TextStyle(color: AppColors.purewhite)),
          ),
        ],
      ),
    );
  }

  /// Reusable text input
  Widget _buildInputField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) => value == null || value.isEmpty ? 'Required' : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final players = showOnlySaved
        ? playerStore.players.where((player) => player.isSaved).toList()
        : playerStore.players;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: players.isEmpty
          ? const Center(
        child: Text(
          'No players found.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 320,
          crossAxisSpacing: 10,
          mainAxisSpacing: 30,
        ),
        itemCount: players.length,
        itemBuilder: (context, index) {
          final player = players[index];

          return Container(
            decoration: BoxDecoration(
              color: AppColors.purewhite,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: Image.asset(
                        'assets/images/card.jpg',
                        height: 140,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    // show created time
                    if (showTime &&
                        player.createdAt != null &&
                        player.createdAt!.isNotEmpty)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            _formatDateTime(player.createdAt),
                            style: TextStyle(
                                color: AppColors.purewhite, fontSize: 11),
                          ),
                        ),
                      ),

                    // show edit icon
                    if (showEdit)
                      Positioned(
                        right: 6,
                        top: 5,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.20),
                            borderRadius: BorderRadius.circular(26),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.edit,
                                color: AppColors.purewhite),
                            onPressed: () {
                              showPlayerPopup(
                                context: context,
                                store: playerStore,
                                existingPlayer: player,
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                ),


                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        Text(
                          player.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(player.email,
                            style: const TextStyle(
                                color: Colors.black54, fontSize: 14)),
                        Text(player.state,
                            style: const TextStyle(
                                color: Colors.black54, fontSize: 14)),
                        const Spacer(),

                        // show updated time only if available
                        if (showTime &&
                            player.updatedAt != null &&
                            player.updatedAt!.isNotEmpty &&
                            player.updatedAt != player.createdAt)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _formatDateTime(player.updatedAt),
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xff7A7A11)),
                            ),
                          ),

                        const SizedBox(height: 5),

                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            if (showDelete)
                              IconButton(
                                icon: Icon(Icons.delete,
                                    color: AppColors.fadedcolor),
                                onPressed: () {
                                  _showDeleteConfirmation(
                                      context, playerStore, player);
                                },
                              ),
                            IconButton(
                              icon: Icon(
                                player.isSaved
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                color: player.isSaved
                                    ? Colors.amber
                                    : Colors.grey,
                              ),
                              onPressed: () async {
                                await playerStore.toggleSaved(player);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

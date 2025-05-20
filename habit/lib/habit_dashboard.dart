import 'package:flutter/material.dart';

class HabitDashboardPage extends StatefulWidget {
  @override
  _HabitDashboardPageState createState() => _HabitDashboardPageState();
}

class _HabitDashboardPageState extends State<HabitDashboardPage> {
  List<Map<String, dynamic>> habits = [
    {'emoji': '💧', 'color': Colors.blue, 'title': 'Drink Water', 'done': false},
    {'emoji': '📖', 'color': Colors.orange, 'title': 'Read Book', 'done': false},
    {'emoji': '🧘‍♂️', 'color': Colors.purple, 'title': 'Meditation', 'done': false},
  ];

  final TextEditingController _habitNameController = TextEditingController();
  String _selectedEmoji = '💧';
  final List<String> _emojiOptions = ['💧', '📖', '🧘‍♂️', '🚶‍♂️', '📝', '🍎', '😴', '💪'];

  void toggleHabitDone(int index) {
    setState(() {
      habits[index]['done'] = !habits[index]['done'];
    });
  }

  void goToSettings() {
    Navigator.pushNamed(context, '/settings');
  }

  void showAddHabitDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text("Add New Habit")),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _habitNameController,
                  decoration: InputDecoration(
                    labelText: 'Habit Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedEmoji.isEmpty ? null : _selectedEmoji,
                  items: _emojiOptions
                      .map((emoji) => DropdownMenuItem(
                            value: emoji,
                            child: Text(emoji, style: TextStyle(fontSize: 22)),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedEmoji = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Choose Emoji',
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                    border: OutlineInputBorder(),
                  ),
                  hint: Text('Select an emoji'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Please select an emoji' : null,
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: Icon(Icons.add,color: Colors.white,),
                  label: Text(
                    'Add Habit',
                    style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: () {
                    String name = _habitNameController.text.trim();
                    if (name.isNotEmpty) {
                      setState(() {
                        habits.add({
                          'emoji': _selectedEmoji,
                          'color': Colors.teal,
                          'title': name,
                          'done': false,
                        });
                        _habitNameController.clear();
                        _selectedEmoji = _emojiOptions[0];
                      });
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _habitNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MindStreak'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: goToSettings,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: habits.isEmpty
            ? Center(
                child: Text(
                  'No habits yet. Tap + to add!',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
            : ListView.builder(
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  final habit = habits[index];
                  return Card(
                    color: habit['done'] ? Colors.green[100] : Colors.white,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: habit['color'],
                        child: Text(habit['emoji'], style: TextStyle(fontSize: 18)),
                      ),
                      title: Text(
                        habit['title'],
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          decoration: habit['done']
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          habit['done']
                              ? Icons.check_circle
                              : Icons.check_circle_outline,
                          color: habit['done'] ? Colors.green : Colors.grey,
                        ),
                        onPressed: () => toggleHabitDone(index),
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddHabitDialog,
        child: Icon(Icons.add),
        tooltip: 'Add Habit',
      ),
    );
  }
}

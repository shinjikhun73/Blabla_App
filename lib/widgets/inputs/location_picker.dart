import 'package:blabla/theme/theme.dart';
import 'package:flutter/material.dart';
import '../../model/ride/locations.dart';
import '../../dummy_data/dummy_data.dart';
// import '../display/bla_divider.dart';

class LocationPicker extends StatefulWidget {
  const LocationPicker({super.key});

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  final TextEditingController _controller = TextEditingController();
  List<Location> suggestions = [];

  void _onQueryChanged(String query) {
    setState(() {
      if (query.length >= 2) {
        suggestions = fakeLocations
            .where(
              (loc) => loc.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      } else {
        suggestions = [];
      }
    });
  }

  void _onSelect(Location loc) {
    Navigator.pop(context, loc);
  }

  void _onClear() {
    _controller.clear();
    _onQueryChanged("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BlaColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Search city",

                  prefixIcon: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () => Navigator.pop(context),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),

                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: _onClear,
                  ),
                ),
                onChanged: _onQueryChanged,
              ),
            ),
            Expanded(
              child: suggestions.isEmpty
                  ? const Center(child: Text("No results"))
                  : ListView.separated(
                      itemCount: suggestions.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final loc = suggestions[index];
                        return ListTile(
                          title: Text(loc.name),
                          subtitle: Text(loc.country.name),
                          onTap: () => _onSelect(loc),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

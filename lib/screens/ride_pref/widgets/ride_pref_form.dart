import 'package:flutter/material.dart';

import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../theme/theme.dart';
import '../../../widgets/display/bla_divider.dart';
import 'package:intl/intl.dart';
import '../../../widgets/inputs/location_input_tile.dart';
import '../../../widgets/inputs/location_picker.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;
  final bool showHistory;

  const RidePrefForm({super.key, this.initRidePref, this.showHistory = true});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  DateTime departureDate = DateTime.now();
  Location? arrival;
  int requestedSeats = 1;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    departure = widget.initRidePref?.departure;
    arrival = widget.initRidePref?.arrival;
    departureDate = widget.initRidePref?.departureDate ?? DateTime.now();
    requestedSeats = widget.initRidePref?.requestedSeats ?? 1;
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
  void _onSelectDeparture() async {
    final selected = await Navigator.push<Location>(
      context,
      MaterialPageRoute(builder: (_) => const LocationPicker()),
    );
    if (selected != null) {
      setState(() => departure = selected);
    }
  }

  void _onSelectArrival() async {
    final selected = await Navigator.push<Location>(
      context,
      MaterialPageRoute(builder: (_) => const LocationPicker()),
    );
    if (selected != null) {
      setState(() => arrival = selected);
    }
  }

  void _onSelectDate() {
    //todo
  }

  void _onSelectTravelers() {
    //todo
  }

  void _onSwapLocations() {
    setState(() {
      final swap = departure;
      departure = arrival;
      arrival = swap;
    });
  }

  void _onSearch() {
    // if (departure != null && arrival != null) {
    //   debugPrint("Search tapped with valid form");
    //   // TODO: return RidePref
    // } else {
    //   debugPrint("Form incomplete");
    // }
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  Widget _buildDepartureTile() {
    return LocationInputTile(
      placeholder: "Departure",
      value: departure,
      onTap: _onSelectDeparture,
      trailing: IconButton(
        icon: const Icon(Icons.swap_vert, color: Colors.blueGrey),
        onPressed: _onSwapLocations,
      ),
    );
  }

  Widget _buildArrivalTile() {
    return LocationInputTile(
      placeholder: "Destination",
      value: arrival,
      onTap: _onSelectArrival,
    );
  }

  Widget _buildDateTile() {
    final dateFormat = DateFormat('EEE d MMM').format(departureDate);

    return ListTile(
      tileColor: BlaColors.textLight,
      title: Text(
        dateFormat,
        style: BlaTextStyles.body.copyWith(color: BlaColors.textNormal),
      ),
      leading: const Icon(Icons.calendar_today, color: Colors.blueGrey),
      onTap: _onSelectDate,
    );
  }

  Widget _buildTravelersTile() {
    return ListTile(
      tileColor: BlaColors.textLight,
      title: Text(
        "$requestedSeats",
        style: BlaTextStyles.body.copyWith(color: BlaColors.textNormal),
      ),
      leading: const Icon(Icons.person, color: Colors.blueGrey),
      onTap: _onSelectTravelers,
    );
  }

  Widget _buildSearchTile() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF00aff5),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: ListTile(
        title: Text(
          "Search",
          style: BlaTextStyles.body.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        onTap: _onSearch,
      ),
    );
  }

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildDepartureTile(),
        const BlaDivider(),
        _buildArrivalTile(),
        const BlaDivider(),
        _buildDateTile(),
        const BlaDivider(),
        _buildTravelersTile(),
        const BlaDivider(),
        _buildSearchTile(),
      ],
    );
  }
}

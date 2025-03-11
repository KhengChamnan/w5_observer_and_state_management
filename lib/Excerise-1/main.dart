import 'package:w5_observer_pattern_and_state_management/Excerise-1/model/ride/locations.dart';
import 'package:w5_observer_pattern_and_state_management/Excerise-1/model/ride_pref/ride_pref.dart';

////
///   This service handles:
///   - The past ride preferences
///   - The currennt ride preferences
///
///
abstract class RidePreferenceListener {
  void setRidePreferenceChanged(RidePreference selectedPreference);
}

class RidePrefService {
  //Current pref
  RidePreference? _currentPreference;
  //list of observers
  final List<RidePreferenceListener> _listeners = [];

  // Add a getter to access the current preference
  RidePreference? get currentPreference => _currentPreference;

  //add observer
  void addListener(RidePreferenceListener listener){
    _listeners.add(listener);
  }

  //notify observers when the preference change
  void _notifyListeners(){
    for(var listener in _listeners){
      listener.setRidePreferenceChanged(_currentPreference!);
    }
  }
  //set preference and notify all obervers
  void setRidePreferenceChanged(RidePreference preference){
    _currentPreference = preference;
    _notifyListeners();
  }

}

class ConsoleLogger implements RidePreferenceListener {
  @override
  void setRidePreferenceChanged(RidePreference preference) {
    print('📝 ConsoleLogger: Ride preference changed:');
    print('   From: ${preference.departure.name}');
    print('   To: ${preference.arrival.name}');
    print('   Date: ${preference.departureDate}');
    print('   Seats: ${preference.requestedSeats}');
  }
}

void main() {
  // Instantiate the Subject
  RidePrefService ridePrefService = RidePrefService();
  
  // Intantiate the Observer
  ConsoleLogger consoleLogger = ConsoleLogger();

  // add observer to listner list
  ridePrefService.addListener(consoleLogger);  
  
  //Sample Ride Preferences Dummy Data
  RidePreference preference1 = RidePreference(
    departure: Location(name: 'Paris', country: Country.france),
    arrival: Location(name: 'London', country: Country.uk),
    departureDate: DateTime.now(),
    requestedSeats: 2,
  );
  
  RidePreference preference2=RidePreference(
    departure: Location(name: 'Siem Reap', country: Country.cambodia),
    arrival: Location(name: 'BattamBong', country: Country.cambodia),
    departureDate: DateTime.now(),
    requestedSeats: 2,
  );

  //Set preference and notify listner
  print('Setting current preference....');
  ridePrefService.setRidePreferenceChanged(preference1);
  print('Setting new preference....');
  ridePrefService.setRidePreferenceChanged(preference2);


  // Check the current preference again after change
  print('\nUpdated current preference check:');
  print('From: ${ridePrefService.currentPreference?.departure.name}');
  print('To: ${ridePrefService.currentPreference?.arrival.name}');
  

}



import 'package:shared_preferences/shared_preferences.dart';

class IdRepository {


  Future save(int id) async {
    final prefs = await SharedPreferences.getInstance();

// set value
    prefs.setInt('customer_id', id);
  }



  Future invalidate() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove('customer_id');
  }
}
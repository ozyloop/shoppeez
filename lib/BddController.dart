




import 'package:mysql1/mysql1.dart';

class BddController {
  getData() async {
    print("getdata method 1");
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: "localhost",
      port: 3306,
      user: 'id18695514_ozylo',
      password: 'KKbe6=vwlKS7gQ0)',
      db: 'id18695514_flutter',

    ));

  print('yoooo');
    await conn.query(
      "UPDATE customer SET first_name = 'Thomas' WHERE first_name = 'Fabien'"
    );



  }

}
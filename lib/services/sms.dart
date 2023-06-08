import 'package:flutter_sms/flutter_sms.dart';
import 'package:track/screens/home_screen.dart';
import 'package:track/screens/side_bar.dart';

void sending_SMS(String msg, List<String> list_receipents) async {
  String send_result =
      await sendSMS(message: msg, recipients: list_receipents, sendDirect: true)
          .catchError((err) {
    print(err);
  });
  print(send_result);
}

void sendsms() {
  sending_SMS(
      'Accident Reporting \n\n\n Name: $name \n\n Blood Group: $bloodg \n\n Location: https://www.google.com/maps/dir//$latitude,$longitude  \n\n\n Other Medical info : \n\n Blood Pressure: $bloodpre \n Allegies: $allg \n Diabetes: $diab \n Past Surgeries: $surger \n Genetic Disorders: $gen',
      [emerg1]);
}

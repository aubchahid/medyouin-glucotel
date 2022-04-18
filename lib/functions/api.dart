import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:glucotel/model/Aliment.dart';
import 'package:glucotel/model/Blog.dart';
import 'package:glucotel/model/Glucose.dart';
import 'package:glucotel/model/Jour.dart';
import 'package:glucotel/model/MedicalFolder.dart';
import 'package:glucotel/model/Reminder.dart';
import 'package:glucotel/model/RendezVous.dart';
import 'package:glucotel/model/user.dart';
import 'package:http/http.dart' as http;

class Api {
  final tokenName = "app-glucotel-v2022";
  final tokenID = "dT629wNYIrIeZpt3V12RahiTVWkQs";
  final api = "https://glucosql.medyouin.com/api-v2/";

  Future<String> insertUser(uid, fullname, email, phoneNo) async {
    var url = Uri.parse(api + "users");
    final response = await http.post(url, body: {
      "uid": uid,
      "fullname": fullname,
      "email": email.toString().toLowerCase(),
      "phoneNo": phoneNo ?? '-',
      "tokenName": tokenName,
      "tokenID": tokenID,
      "action": "insert"
    });
    return json.decode(response.body);
  }

  Future<String> completUser(user) async {
    var url = Uri.parse(api + "users");
    final response = await http.post(url, body: {
      "uid": user.id,
      "sexe": user.sexe,
      "birthdate": user.birthdate,
      "city": user.city,
      "size": user.size,
      "weight": user.weight,
      "glucoPostMealT1": user.glycPostMealT1,
      "glucoPostMealT2": user.glycPostMealT2,
      "glucoPostMealT3": user.glycPostMealT3,
      "glucoPreMealT1": user.glycPreMealT1,
      "glucoPreMealT2": user.glycPreMealT2,
      "glucoPreMealT3": user.glycPreMealT3,
      "hba1c": user.hba1c,
      "stepsPerDay": user.stepsPerDay,
      "typeDiabet": user.typeDiabet,
      "tokenName": tokenName,
      "tokenID": tokenID,
      "action": "complete",
    });
    debugPrint(json.decode(response.body));
    return json.decode(response.body);
  }

  Future<String> checkUser(uid) async {
    var url = Uri.parse(api + "users");
    final response = await http.post(url, body: {
      "uid": uid,
      "tokenName": tokenName,
      "tokenID": tokenID,
      "action": "checkUser",
    });
    return json.decode(response.body);
  }

  Future<dynamic> getUserByEmail(uid) async {
    var url = Uri.parse(api + "users");
    final response = await http.post(url, body: {
      "uid": uid,
      "tokenName": tokenName,
      "tokenID": tokenID,
      "action": "selectName&Phone",
    });
    if (response.statusCode == 200) {
      var user = json.decode(response.body);
      return user;
    }
  }

  Future<String> getLastValue(uid, date) async {
    var url = Uri.parse(api + "glucose");
    final response = await http.post(url, body: {
      "uid": uid,
      "date": date,
      "tokenName": tokenName,
      "tokenID": tokenID,
      "action": "getLastValue",
    });
    return json.decode(response.body);
  }

  Future<List<Blog>> getBlogs() async {
    List<Blog> blogs = [];
    int i;
    var url = Uri.parse(api + "blogs");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> list = jsonDecode(response.body);
      for (i = 0; i < list.length; i++) {
        Blog blog = Blog.fromJson(list[i]);
        blogs.add(blog);
      }
    } else {
      throw Exception('Error');
    }
    return blogs;
  }

  Future<String> updateUser(user) async {
    var url = Uri.parse(api + "users");
    final response = await http.post(url, body: {
      "uid": user.id,
      "glucoPostMealT1": user.glycPostMealT1,
      "glucoPostMealT2": user.glycPostMealT2,
      "glucoPostMealT3": user.glycPostMealT3,
      "glucoPreMealT1": user.glycPreMealT1,
      "glucoPreMealT2": user.glycPreMealT2,
      "glucoPreMealT3": user.glycPreMealT3,
      "hba1c": user.hba1c,
      "stepsPerDay": user.stepsPerDay,
      "tokenName": tokenName,
      "tokenID": tokenID,
      "action": "updateUser",
    });
    return json.decode(response.body);
  }

  Future<List<Glucose>> selectStats(uid) async {
    List<Glucose> stats = [];
    int i;
    var url = Uri.parse(api + "glucose");
    final response =
        await http.post(url, body: {"uid": uid, "action": "selectStats"});
    if (response.statusCode == 200) {
      try {
        List<dynamic> list = jsonDecode(response.body);
        for (i = 0; i < list.length; i++) {
          Glucose glucose = Glucose.fromJson(list[i]);
          stats.add(glucose);
        }
        return stats;
      } catch (e) {
        return stats;
      }
    } else {
      throw Exception('Error');
    }
  }

  Future<List<Glucose>> weeklyStats(uid) async {
    List<Glucose> stats = [];
    int i;
    var url = Uri.parse(api + "glucose");
    final response =
        await http.post(url, body: {"uid": uid, "action": "weeklyStats"});
    if (response.statusCode == 200) {
      try {
        List<dynamic> list = jsonDecode(response.body);
        for (i = 0; i < list.length; i++) {
          Glucose glucose = Glucose.fromJson(list[i]);
          stats.add(glucose);
        }
        return stats;
      } catch (e) {
        return stats;
      }
    } else {
      throw Exception('Error');
    }
  }

  Future<List<Glucose>> monthlyStats(uid) async {
    List<Glucose> stats = [];
    int i;
    var url = Uri.parse(api + "glucose");
    final response =
        await http.post(url, body: {"uid": uid, "action": "monthlyStats"});
    if (response.statusCode == 200) {
      try {
        List<dynamic> list = jsonDecode(response.body);
        for (i = 0; i < list.length; i++) {
          Glucose glucose = Glucose.fromJson(list[i]);
          stats.add(glucose);
        }
        return stats;
      } catch (e) {
        return stats;
      }
    } else {
      throw Exception('Error');
    }
  }

  Future<String> updaterProfile(User user) async {
    var url = Uri.parse(api + "users");
    final response = await http.post(url, body: {
      'uid': user.id,
      'fullname': user.fullname,
      'phoneNo': user.phoneNo,
      'city': user.city,
      'sexe': user.sexe,
      'birthdate': user.birthdate,
      'photo': user.photoUrl,
      "tokenName": tokenName,
      "tokenID": tokenID,
      'action': 'updaterProfile',
    });
    return json.decode(response.body);
  }

  Future<String> uploadImage(fileName, base64Image, User user) async {
    var url = Uri.parse(api + "users");
    final response = await http.post(url, body: {
      'uid': user.id,
      "image": base64Image,
      "name": fileName,
      "tokenName": tokenName,
      "tokenID": tokenID,
      'action': 'updateImage',
    });
    return json.decode(response.body);
  }

  Future<List<Aliment>> getAliments() async {
    List<Aliment> aliments = [];
    int i;
    var url = Uri.parse(api + "aliment");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> list = jsonDecode(response.body);
      for (i = 0; i < list.length; i++) {
        Aliment aliment = Aliment.fromJson(list[i]);
        aliments.add(aliment);
      }
    } else {
      throw Exception('Error');
    }
    return aliments;
  }

  Future<String> deleteReminder(uid, id) async {
    var url = Uri.parse(api + "reminder");
    final response = await http.post(url, body: {
      "uid": uid,
      "id": id,
      "action": "delete",
      "tokenName": tokenName,
      "tokenID": tokenID,
    });
    return response.body.toString();
  }

  Future<String> insertRdv(uid, hour, date, text, sousType) async {
    var url = Uri.parse(api + "reminder");
    final response = await http.post(url, body: {
      "uid": uid,
      "hour": hour,
      "date": date,
      "text": text,
      "sousType": sousType,
      "tokenName": tokenName,
      "tokenID": tokenID,
      "action": "rdv"
    });
    return response.body.toString();
  }

  Future<String> insertReminder(uid, hour, date, text, qte, sousType) async {
    var url = Uri.parse(api + "reminder");
    final response = await http.post(url, body: {
      "uid": uid,
      "hour": hour,
      "date": date,
      "text": text,
      "sousType": sousType,
      "qte": qte,
      "tokenName": tokenName,
      "tokenID": tokenID,
      "action": "reminder"
    });
    return response.body.toString();
  }

  Future<List<Reminder>> selectReminder(uid) async {
    List<Reminder> reminders = [];
    int i;
    var url = Uri.parse(api + "reminder");
    final response = await http.post(url, body: {
      "uid": uid,
      'type': 'md',
      'action': 'selectReminder',
      "tokenName": tokenName,
      "tokenID": tokenID,
    });
    if (response.statusCode == 200) {
      try {
        List<dynamic> list = jsonDecode(response.body);
        for (i = 0; i < list.length; i++) {
          Reminder reminder = Reminder.fromJson(list[i]);
          reminders.add(reminder);
        }
        return reminders;
      } catch (e) {
        return reminders;
      }
    } else {
      throw Exception('Error');
    }
  }

  Future<List<RendezVous>> selectRdv(uid) async {
    List<RendezVous> rdvs = [];
    int i;
    var url = Uri.parse(api + "reminder");
    final response = await http.post(url, body: {
      "uid": uid,
      'type': 'rdv',
      'action': 'selectRdv',
      "tokenName": tokenName,
      "tokenID": tokenID,
    });
    if (response.statusCode == 200) {
      try {
        List<dynamic> list = jsonDecode(response.body);
        for (i = 0; i < list.length; i++) {
          RendezVous rdv = RendezVous.fromJson(list[i]);
          rdvs.add(rdv);
        }
        return rdvs;
      } catch (e) {
        return rdvs;
      }
    } else {
      throw Exception('Error');
    }
  }

  Future<String> folderMedical(
      MedicalFolder folderMedical, User currentUser) async {
    var url = Uri.parse(api + "medicalFolder");
    final response = await http.post(url, body: {
      "uid": currentUser.id,
      "typeDiabet": folderMedical.typeDiabete,
      "mutuele": folderMedical.mutuele,
      "size": currentUser.size,
      "weight": currentUser.weight,
      "modeDecouverte": folderMedical.decouverte,
      "reegime": folderMedical.regime,
      "insuline": folderMedical.insuline,
      "insulineDepuis": folderMedical.insulineDepuis,
      "vitiligo": folderMedical.vitiligo,
      "thyroidienne": folderMedical.thyroidienne,
      "coeliaque": folderMedical.coeliaque,
      "addison": folderMedical.addison,
      "hta": folderMedical.hta,
      "htadepuis": folderMedical.htaDepuis,
      "cholesterol": folderMedical.cholesterol,
      "cholesterolDepuis": folderMedical.cholesterolDepuis,
      "alcool": folderMedical.alcool,
      "tabagisme": folderMedical.tabagisme,
      "tabagismeDepuis": folderMedical.tabagismeDepuis,
      "renale": folderMedical.renale,
      "renaleDepuis": folderMedical.depuis,
      "visuel": folderMedical.visual,
      "sensibilite": folderMedical.sensibilite,
      "plaie": folderMedical.plaie,
      "mycose": folderMedical.mycose,
      "durillion": folderMedical.durillion,
      "action": "folderMedical",
    });
    return json.decode(response.body);
  }

  Future<String> updatefolderMedical(
      MedicalFolder folderMedical, User currentUser) async {
    var url = Uri.parse(api + "medicalFolder");
    final response = await http.post(url, body: {
      "uid": currentUser.id,
      "typeDiabet": folderMedical.typeDiabete,
      "mutuele": folderMedical.mutuele,
      "size": currentUser.size,
      "weight": currentUser.weight,
      "modeDecouverte": folderMedical.decouverte,
      "reegime": folderMedical.regime,
      "insuline": folderMedical.insuline,
      "insulineDepuis": folderMedical.insulineDepuis,
      "vitiligo": folderMedical.vitiligo,
      "thyroidienne": folderMedical.thyroidienne,
      "coeliaque": folderMedical.coeliaque,
      "addison": folderMedical.addison,
      "hta": folderMedical.hta,
      "htadepuis": folderMedical.htaDepuis,
      "cholesterol": folderMedical.cholesterol,
      "cholesterolDepuis": folderMedical.cholesterolDepuis,
      "alcool": folderMedical.alcool,
      "tabagisme": folderMedical.tabagisme,
      "tabagismeDepuis": folderMedical.tabagismeDepuis,
      "renale": folderMedical.renale,
      "renaleDepuis": folderMedical.depuis,
      "visuel": folderMedical.visual,
      "sensibilite": folderMedical.sensibilite,
      "plaie": folderMedical.plaie,
      "mycose": folderMedical.mycose,
      "durillion": folderMedical.durillion,
      "action": "updatefolderMedical",
    });
    return json.decode(response.body);
  }

  Future<String> insertStats(
      uid, value, date, period, hour, minute, day, month, year) async {
    var url = Uri.parse(api + "glucose");
    final response = await http.post(url, body: {
      "uid": uid,
      "value": value,
      "date": date,
      "period": period,
      "hour": hour,
      "minute": minute,
      "day": day,
      "month": month,
      "year": year,
      "action": "insertStats"
    });
    return json.decode(response.body);
  }

  Future<String> insertLog(uid, startAt, endAt) async {
    var url = Uri.parse(api + "glucose");
    final response = await http.post(url, body: {
      "uid": uid.toString(),
      "start": startAt,
      "end": endAt,
      "action": "insertLog"
    });
    return json.decode(response.body).toString();
  }

  Future<List<Jour>> getDetails(id) async {
    int i;
    List<Jour> entries = [];
    var url = Uri.parse(api + "glucose");
    final response = await http.post(url, body: {
      "idcarnet": id.toString(),
      "action": "getDetails",
    });
    if (response.statusCode == 200) {
      List<dynamic> list = jsonDecode(response.body);
      for (i = 0; i < list.length; i++) {
        Jour entry = Jour.fromJson(list[i]);
        entries.add(entry);
      }
      return entries;
    } else {
      throw Exception('Error');
    }
  }

  Future<String> insertDetails(
      idcarnet, value, date, period, text, note) async {
    var url = Uri.parse(api + "glucose");
    final response = await http.post(url, body: {
      "idcarnet": idcarnet.toString(),
      "date": date,
      "value": value,
      "period": period,
      "text": text,
      "note": note,
      "action": "insertDetails"
    });
    print(response.body);
    return json.decode(response.body);
  }
}

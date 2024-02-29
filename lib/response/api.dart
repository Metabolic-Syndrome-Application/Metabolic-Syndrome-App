import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

String hostIP = dotenv.get("HOST_IP", fallback: "");

Future<Map<String, dynamic>> postLogin(String username, String password) async {
  final url = Uri.parse("http://$hostIP:8000/api/auth/login");
  final response = await http.post(url,
      body: json.encode({'username': username, 'password': password}));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to login');
  }
}

Future<Map<String, dynamic>> postRegister(
  String username,
  String password,
  String passwordConfirm,
) async {
  final response =
      await http.post(Uri.parse('http://$hostIP:8000/api/auth/register'),
          body: json.encode({
            "username": username,
            "password": password,
            "passwordConfirm": passwordConfirm,
            "role": "patient"
          }));

  return json.decode(response.body);
}

Future<Map<String, dynamic>> getProfile(String accessToken) async {
  final url = Uri.parse("http://$hostIP:8000/api/user/profile");

  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $accessToken'},
  );

  if (response.statusCode == 200) {
    // print(response.body);
    return json.decode(response.body);
  } else {
    throw Exception('Failed to get profile');
  }
}

Future<Map<String, dynamic>> getMyRank(String accessToken) async {
  final url = Uri.parse("http://$hostIP:8000/api/rank/me");

  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $accessToken'},
  );

  if (response.statusCode == 200) {
    // print(response.body);
    return json.decode(response.body);
  } else {
    throw Exception('Failed to get my rank');
  }
}

Future<Map<String, dynamic>> getTopFive(String accessToken) async {
  final url = Uri.parse("http://$hostIP:8000/api/rank/top5");

  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $accessToken'},
  );

  if (response.statusCode == 200) {
    // print(response.body);
    return json.decode(response.body);
  } else {
    throw Exception('Failed to get top 5');
  }
}

Future<Map<String, dynamic>> updateProfile(
    String? accesstoken,
    String? alias,
    String? firstname,
    String? lastname,
    int? yearOfBirth,
    String? gender,
    String? photo) async {
  final url = Uri.parse("http://$hostIP:8000/api/user/profile");
  final response = await http.put(url,
      headers: {'Authorization': 'Bearer $accesstoken'},
      body: json.encode({
        "alias": alias,
        "firstName": firstname,
        "lastName": lastname,
        "yearOfBirth": yearOfBirth,
        "gender": gender,
        "photo": photo
      }));
  print("$alias $firstname $lastname");

  if (response.statusCode == 200) {
    print("here ${response.body}");
    return json.decode(response.body);
  } else {
    throw Exception('Failed to Update Profile');
  }
}

Future<Map<String, dynamic>> getLogout(String accessToken) async {
  final url = Uri.parse("http://$hostIP:8000/api/auth/logout");

  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $accessToken'},
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to logout');
  }
}

Future<Map<String, dynamic>> postDisease(
    String accesstoken, List<String> disease, List<String> family) async {
  final url = Uri.parse("http://$hostIP:8000/api/screening/disease");
  final response = await http.post(url,
      headers: {'Authorization': 'Bearer $accesstoken'},
      body: json.encode({
        "disease": disease,
        "familyDisease": family,
      }));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to post disease');
  }
}

Future<Map<String, dynamic>> postMetabolic(
    String accesstoken,
    String occupation,
    double height,
    double weight,
    double bmi,
    double waistline,
    int systolicBloodPressure,
    int diastolicBloodPressure,
    int pulseRate,
    double bloodGlucose,
    double triglyceride,
    double hdl) async {
  final url = Uri.parse("http://$hostIP:8000/api/screening/metabolic");
  final response = await http.post(url,
      headers: {'Authorization': 'Bearer $accesstoken'},
      body: json.encode({
        "occupation": occupation,
        "height": height,
        "weight": weight,
        "bmi": bmi,
        "waistline": waistline,
        "systolicBloodPressure": systolicBloodPressure,
        "diastolicBloodPressure": diastolicBloodPressure,
        "pulseRate": pulseRate,
        "bloodGlucose": bloodGlucose,
        "triglyceride": triglyceride,
        "hdl": hdl
      }));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to post metabolic');
  }
}

Future<Map<String, dynamic>> getDisease(String accesstoken) async {
  final url = Uri.parse("http://$hostIP:8000/api/screening/disease");
  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $accesstoken'},
  );
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to get disease');
  }
}

Future<Map<String, dynamic>> getBloodPressure(String accesstoken) async {
  final url = Uri.parse(
      "http://$hostIP:8000/api/record/health/patient/me/bloodPressure");
  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $accesstoken'},
  );
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to get blood pressure');
  }
}

Future<Map<String, dynamic>> getBloodLipid(String accesstoken) async {
  final url =
      Uri.parse("http://$hostIP:8000/api/record/health/patient/me/bloodLipids");
  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $accesstoken'},
  );
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to get blood lipid');
  }
}

Future<Map<String, dynamic>> getBloodGlucose(String accesstoken) async {
  final url = Uri.parse(
      "http://$hostIP:8000/api/record/health/patient/me/bloodGlucose");
  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $accesstoken'},
  );
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to get glucose');
  }
}

Future<Map<String, dynamic>> getBmi(String accesstoken) async {
  final url = Uri.parse("http://$hostIP:8000/api/record/health/patient/me/bmi");
  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $accesstoken'},
  );
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to get bmi');
  }
}

Future<Map<String, dynamic>> getWaistline(String accesstoken) async {
  final url =
      Uri.parse("http://$hostIP:8000/api/record/health/patient/me/waistline");
  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $accesstoken'},
  );
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to get waistline');
  }
}

Future<Map<String, dynamic>> getLatestRecord(String accesstoken) async {
  final url = Uri.parse("http://$hostIP:8000/api/record/health/patient/latest");
  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $accesstoken'},
  );
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to get latest record');
  }
}

Future<Map<String, dynamic>> postHealthRecord(
  String accesstoken,
  int systolicBloodPressure,
  int diastolicBloodPressure,
  int pulseRate,
  int height,
  int weight,
  int waistline,
  int bloodGlucose,
  int cholesterol,
  int hdl,
  int ldl,
  int triglyceride,
) async {
  final url = Uri.parse("http://$hostIP:8000/api/record/health");
  final response = await http.post(url,
      headers: {'Authorization': 'Bearer $accesstoken'},
      body: json.encode({
        "height": height,
        "weight": weight,
        "waistline": waistline,
        "systolicBloodPressure": systolicBloodPressure,
        "diastolicBloodPressure": diastolicBloodPressure,
        "pulseRate": pulseRate,
        "bloodGlucose": bloodGlucose,
        "cholesterol": cholesterol,
        "hdl": hdl,
        "ldl": ldl,
        "triglyceride": triglyceride,
      }));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to post record health');
  }
}

Future<Map<String, dynamic>> getLatestMood(String accesstoken) async {
  final url = Uri.parse("http://$hostIP:8000/api/record/plan/mood");
  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $accesstoken'},
  );
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to get latest mood');
  }
}

Future<Map<String, dynamic>> getAllMood(String accesstoken) async {
  final url = Uri.parse("http://$hostIP:8000/api/record/plan/mood/all");
  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $accesstoken'},
  );
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to get latest mood');
  }
}

Future<Map<String, dynamic>> postMood(String accesstoken, String mood) async {
  final url = Uri.parse("http://$hostIP:8000/api/record/plan/mood");
  final response = await http.put(url,
      headers: {'Authorization': 'Bearer $accesstoken'},
      body: json.encode({
        "mood": mood,
      }));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to post mood');
  }
}

Future<Map<String, dynamic>> getPlan(String accesstoken, String date) async {
  final url = Uri.parse("http://$hostIP:8000/api/record/plan/list/$date");
  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $accesstoken'},
  );
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to get plan');
  }
}

Future<Map<String, dynamic>> getAllPlan(String accesstoken) async {
  final url = Uri.parse("http://$hostIP:8000/api/plan/all");
  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $accesstoken'},
  );
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to get all plan');
  }
}

Future<Map<String, dynamic>> getPlanById(
    String accesstoken, String planId) async {
  final url = Uri.parse("http://$hostIP:8000/api/plan/${planId}");
  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $accesstoken'},
  );
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to get plan');
  }
}

Future<Map<String, dynamic>> postUpdatePlan(
    String accesstoken, String date, dynamic listUpdate) async {
  final url = Uri.parse("http://$hostIP:8000/api/record/plan/list/$date");
  final response = await http.put(url,
      headers: {'Authorization': 'Bearer $accesstoken'},
      body: json.encode({
        "list": listUpdate,
      }));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to Update plan');
  }
}

Future<Map<String, dynamic>> getRandomQuiz(String accesstoken) async {
  final url = Uri.parse("http://$hostIP:8000/api/challenge/quiz/random");
  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $accesstoken'},
  );
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to get plan');
  }
}

Future<Map<String, dynamic>> getCheckQuiz(String accesstoken) async {
  final url = Uri.parse("http://$hostIP:8000/api/challenge/quiz/check-today");
  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $accesstoken'},
  );
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to get plan');
  }
}

Future<Map<String, dynamic>> postAnswerQuiz(
    String accesstoken, bool isCorrect) async {
  final url = Uri.parse("http://$hostIP:8000/api/challenge/quiz/answer");
  final response = await http.post(url,
      headers: {'Authorization': 'Bearer $accesstoken'},
      body: json.encode({
        "isCorrect": isCorrect,
      }));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to get plan');
  }
}

Future<Map<String, dynamic>> getDailyChallengeAll(String accesstoken) async {
  final url = Uri.parse("http://$hostIP:8000/api/challenge/daily/all/active");
  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $accesstoken'},
  );
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to get plan');
  }
}

Future<Map<String, dynamic>> getMyDaily(String accesstoken) async {
  final url = Uri.parse("http://$hostIP:8000/api/challenge/daily/me");
  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $accesstoken'},
  );
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to get plan');
  }
}

Future<Map<String, dynamic>> getDailyList(String accesstoken) async {
  final url = Uri.parse("http://$hostIP:8000/api/record/daily/list");
  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $accesstoken'},
  );
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to get plan');
  }
}

Future<Map<String, dynamic>> getChallengeById(
    String accesstoken, String id) async {
  final url = Uri.parse("http://$hostIP:8000/api/challenge/daily/$id");
  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $accesstoken'},
  );
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to get plan');
  }
}

Future<Map<String, dynamic>> postJoinChallenge(
  String? accesstoken,
  String? challenge,
) async {
  final url = Uri.parse("http://$hostIP:8000/api/user/profile");
  final response = await http.put(url,
      headers: {'Authorization': 'Bearer $accesstoken'},
      body: json.encode({
        "challengeID": challenge,
      }));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to Update Profile');
  }
}

Future<Map<String, dynamic>> postUpdateChallenge(
    String accesstoken, dynamic listUpdate) async {
  final url = Uri.parse("http://$hostIP:8000/api/record/daily/list");
  final response = await http.put(url,
      headers: {'Authorization': 'Bearer $accesstoken'},
      body: json.encode({
        "list": listUpdate,
      }));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to Update plan');
  }
}

Future<Map<String, dynamic>> getKnowledge(
    String accessToken, String disease) async {
  final url = Uri.parse("http://$hostIP:8000/api/knowledge/$disease");

  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $accessToken'},
  );

  if (response.statusCode == 200) {
    // print(response.body);
    return json.decode(response.body);
  } else {
    throw Exception('Failed to get top 5');
  }
}



// Future<Map<String, dynamic>> getAllKnowledge(String accessToken) async {
//   final url = Uri.parse("http://$hostIP:8000/api/rank/top5");

//   final response = await http.get(
//     url,
//     headers: {'Authorization': 'Bearer $accessToken'},
//   );

//   if (response.statusCode == 200) {
//     // print(response.body);
//     return json.decode(response.body);
//   } else {
//     throw Exception('Failed to get top 5');
//   }
// }

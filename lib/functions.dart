import 'dart:convert';

void errorThrower(String response){
  Map<String,dynamic> parsed = jsonDecode(response);
  if(parsed["error"] != null){
    throw response;
  }
}
String enumToString(Enum enumerator){
  return enumerator.toString().substring(enumerator.toString().lastIndexOf(".") + 1);
}
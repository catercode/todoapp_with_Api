import 'package:http/http.dart';
class TodoService{
   Future<Response> getAllRequest(bool completed) async{
     return await get(Uri.parse('https://secondbasetodo.herokuapp.com/todo/$completed'));

   } 
}
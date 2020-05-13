import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user.dart';

class Requests {
  final url = "http://www.vvd-rks.ru/proj/";
  //const url2 = "http://109.172.68.223/";

  ///Возвращает true, если пользователь успешно зарегистрирован.
  Future<bool> registry(
      {String name,
      String surname,
      String patronymic,
      String company,
      String position,
      String mail,
      String phone,
      String login,
      String password,
      int avatar = 1}) async {
    String request = url +
        "?action=register&name=$name&surname=$surname&patronymic=$patronymic&company=$company&position=$position&mail=$mail&phone=$phone&login=$login&password=$password&avatar=$avatar";
    http.Response response = await http.get(request);
    return (json.decode(response.body)['response']['status'] == 1);
  }

  ///Проверка существования такого пользователя в БД.
  ///Возвращает true, если логин и пароль корректны.
  Future<bool> userExist({String login, String password}) async {
    String request =
        "$url?action=login&login=" + login + "&password=" + password;
    http.Response response = await http.get(request);
    return (json.decode(response.body)['response']['status'] == 1);
  }

  ///Получает ID пользователя для дальнейшей выгрузки профиля.
  ///Использовать только после аутентификации или регистрации.
  Future<String> getID({String login, String password}) async {
    String request =
        "$url?action=login&login=" + login + "&password=" + password;
    http.Response response = await http.get(request);
    return json.decode(response.body)['response']['id_user'];
  }

  ///Возвращает true, если такой логин свободен
  Future<bool> loginIsFree({String login}) async {
    String request = "$url?action=check-login&login=$login";
    http.Response response = await http.get(request);
    return (json.decode(response.body)["response"]["status"] == 0);
  }

  ///Делает запрос по ID и возвращает объект класса User.
  Future<User> getProfileFromID({String userID}) async {
    String request = "$url?action=get-profile&id_user=$userID";
    http.Response response = await http.get(request);
    var answer = json.decode(response.body)['response'];
    User user = new User(
      id: answer['id'],
      name: answer['name'],
      phone: answer['phone'],
      surname: answer['surname'],
      patronymic: answer['patronymic'],
      company: answer['company'],
      position: answer['position'],
      mail: answer['mail'],
      login: answer['login'],
      cardID: answer['own_card'],
      avatar: answer['avatar'],
    );
    request = "$url?action=get-list-card&id_user=" + user.id;
    response = await http.get(request);
    answer = json.decode(response.body)['response'];
    if (answer['status'] == 1) {
      user.ownCards = answer['cards'].cast<String, String>();
    }
    return user;
  }

  Future<User> update(User user) async {
    return await getProfileFromID(userID: user.id);
  }

  ///Создаёт карточку для нового пользователя при регистрации
  Future<void> createCard(
      {String userID,
      String surname,
      String name,
      String company,
      String position}) async {
    String nameField = surname + " " + name;
    String captionField =
        "Компания - " + company + ".\nДолжность - " + position;
    String _request =
        "$url?action=card-create&id_user=$userID&card_name=$nameField&card_caption=$captionField";
    await http.get(_request);
  }

  ///Получает карточку и возвращает словарь, содержащий поля этой карточки.
  ///Если карточка не корректна - значению cardResult присваивается error.
  Future<Map<String, String>> getCard(String cardID) async {
    Map<String, String> cardInfo = {
      'cardResult': '',
      'ownerID': '',
      'cardID': ''
    };
    String request = url + "?action=get-card&id_card=" + cardID;
    http.Response response = await http.get(request);
    var answer = json.decode(response.body)["response"];
    if (answer.containsKey("error")) {
      cardInfo['cardResult'] = "error"; //card_result
    } else {
      cardInfo['cardResult'] = answer["name"] + "\n" + answer["caption"];
      cardInfo['ownerID'] = answer["owner_id"];
      cardInfo['cardID'] = answer["id"];
    }
    return cardInfo;
  }

  //Даёт карточку пользователю
  Future<bool> getCardToUser(
      {String ownerID, String cardID, String geo, User user}) async {
    String request = "$url?action=give-card&id_owner=$ownerID&id_recipient=" +
        user.id +
        "&id_card=$cardID&gps=$geo";
    http.Response response = await http.get(request);
    var answer = json.decode(response.body);
    if (answer['response']['status'] == 0) {
      return false;
    }
    return true;
  }

  //Даёт объект класса User через ID его карточки
  Future<User> getUserFromCard(String cardID) async {
    String ownerID = "";
    String request = "$url?action=get-card&id_card=$cardID";
    http.Response response = await http.get(request);
    ownerID = json.decode(response.body)["response"]["owner_id"];
    User user = await getProfileFromID(userID: ownerID);
    return user;
  }

  Future<bool> deleteCard(String userID, String cardID) async {
    String request = "$url?action=delete-card&id_user=$userID&id_card=$cardID";
    http.Response response = await http.get(request);
    if (response != null)
      return true;
    else
      return false;
  }
}

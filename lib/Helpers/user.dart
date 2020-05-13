//Специальная ошибка на случай, если что-то пошло не так при получении карты.
//Например - сканировали не валидный QR
class CardException implements Exception {
  String message;
  CardException(this.message) {
    print("Raised exception with body $message");
  }
}

class User {
  String id;
  String name;
  String phone;
  String surname;
  String patronymic;
  String company;
  String position;
  String mail;
  String login;
  String cardID;
  Map<String, String> ownCards;
  int avatar;

  //Конструктор класса. Все поля пусты изначально.
  User({
    this.id = " ",
    this.name = " ",
    this.phone = " ",
    this.surname = " ",
    this.patronymic = " ",
    this.company = " ",
    this.position = " ",
    this.mail = " ",
    this.login = " ",
    this.cardID = " ",
    this.ownCards = const {},
    this.avatar = 0,
  });

  //Вывод всех полей пользователя. Нужен для дебага, вывод идёт в консоль.
  void printUser() {
    print("$login id is $id");
    print("$login name is $name");
    print("$login phone is $phone");
    print("$login surname is $surname");
    print("$login patronymic is $patronymic");
    print("$login company is $company");
    print("$login position is $position");
    print("$login mail is $mail");
    print("$login login is $login");
    print("$login cardID is $cardID");
    print("$login own cards are " + ownCards.toString());
    print("owncards size is " + ownCards.isEmpty.toString());
    print("$login avatar is $avatar");
  }
}

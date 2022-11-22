import 'dart:math';

class data_user {
  var Username = "";
  var id = "";
  var Password = "";
  var Firstname = "";
  var Lastname = "";
  var ID_card = "";
  var Phonenumber = "";
  var Address_image = "";
  data_user() {}
  setdatauer_from_db(var user_db) {
    this.id = user_db['id'];
    this.Username = user_db['Username'];
    this.Password = user_db['Password'];
    this.Firstname = user_db['Firstname'];
    this.Lastname = user_db['Lastname'];
    this.ID_card = user_db['ID_card'];
    this.Phonenumber = user_db['Phonenumber'];
    this.Address_image = user_db['Address_image'];
  }

  random_id() {
    Random r = new Random();

    var id = String.fromCharCode(r.nextInt(26) + 65) +
        String.fromCharCode(r.nextInt(26) + 65);

    for (int i = 0; i < 10; ++i) {
      var num = r.nextInt(10);

      id += num.toStringAsFixed(0);
    }
    return id;
  }

  setdatauser(Username, Password, Firstname, Lastname, ID_card, Phonenumber,
      Address_image) {
    this.id = random_id();
    this.Username = Username;
    this.Password = Password;
    this.Firstname = Firstname;
    this.Lastname = Lastname;
    this.ID_card = ID_card;
    this.Phonenumber = Phonenumber;
    this.Address_image = Address_image;
  }

  Map<String, dynamic> get_Mapdata_user() {
    var usermap = <String, dynamic>{
      'id': id,
      'Username': Username,
      'Password': Password,
      'Firstname': Firstname,
      'Lastname': Lastname,
      'ID_card': ID_card,
      'Phonenumber': Phonenumber,
      'Address_image': Address_image,
    };
    return usermap;
  }

  getdatauser() {
    return "Username : " +
        Username +
        "\n" +
        "Password : " +
        Password +
        "\n" +
        "ชื่อ : " +
        Firstname +
        "\n" +
        "นามสกุล : " +
        Lastname +
        "\n" +
        "เลขบัตรประชาชน : " +
        ID_card +
        "\n" +
        "เบอร์โทรศัพท์ : " +
        Phonenumber;
  }
}

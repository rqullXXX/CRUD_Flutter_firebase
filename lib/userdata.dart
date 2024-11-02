class UserData {
  String nama;
  int umur;
  String email;
  String semester;
  String gender;

  UserData(this.nama, this.umur, this.email, this.semester, this.gender);

  Map<String, dynamic> toJson() {
    return {
      "nama": this.nama,
      "umur": this.umur,
      "email": this.email,
      "semester": this.semester,
      "gender": this.gender,
    };
  }
}

class Business {
  final int id;
  final String name;
  final String registrationNumber;
  final String owner;
  final String creationTime;
  final String accountBalance;

  Business(
      {this.id,
        this.name,
        this.registrationNumber,
        this.owner,
        this.creationTime,
        this.accountBalance});

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
        id: json['id'],
        name: json['name'],
        registrationNumber: json['registrationNumber'],
        owner: json['owner'],
        creationTime: json['creationTime'],
        accountBalance: json['accountBalance']);
  }
}
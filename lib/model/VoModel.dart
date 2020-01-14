class VoModel {
  List<Vo> vo;

  VoModel({this.vo});

  VoModel.fromJson(Map<String, dynamic> json) {
    if (json['vo'] != null) {
      vo = new List<Vo>();
      json['vo'].forEach((v) {
        vo.add(new Vo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vo != null) {
      data['vo'] = this.vo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vo {
  int arriveOrgid;
  int companyId;
  int orgId;
  String receiverMobile;
  String repertoryId;
  String senderMobile;
  int shipFromOrgid;
  String shipId;
  int signTypeId;

  Vo(
      {this.arriveOrgid,
      this.companyId,
      this.orgId,
      this.receiverMobile,
      this.repertoryId,
      this.senderMobile,
      this.shipFromOrgid,
      this.shipId,
      this.signTypeId});

  Vo.fromJson(Map<String, dynamic> json) {
    arriveOrgid = json['arriveOrgid'];
    companyId = json['companyId'];
    orgId = json['orgId'];
    receiverMobile = json['receiverMobile'];
    repertoryId = json['repertoryId'];
    senderMobile = json['senderMobile'];
    shipFromOrgid = json['shipFromOrgid'];
    shipId = json['shipId'];
    signTypeId = json['signTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['arriveOrgid'] = this.arriveOrgid;
    data['companyId'] = this.companyId;
    data['orgId'] = this.orgId;
    data['receiverMobile'] = this.receiverMobile;
    data['repertoryId'] = this.repertoryId;
    data['senderMobile'] = this.senderMobile;
    data['shipFromOrgid'] = this.shipFromOrgid;
    data['shipId'] = this.shipId;
    data['signTypeId'] = this.signTypeId;
    return data;
  }
}
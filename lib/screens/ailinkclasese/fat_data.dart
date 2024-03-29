class BodyFatData {
  ///bmi
  double? bmi;
  ///体脂率 bodyfatRate
  double? bfr;
  ///皮下脂肪率 subcutaneousFat rate
  double? sfr;
  ///内脏脂肪指数 visceralFat rate
  int? uvi;
  ///肌肉率 muscle rate
  double? rom;
  ///基础代谢率 BMR
  int? bmr;
  ///骨骼质量 boneMass
  double? bm;
  ///水含量vwc: moisture
  double? vwc;
  ///身体年龄 physicalAge
  int? physicalAge;
  ///蛋白率 proteinRate
  double? pp;

  BodyFatData.fromJson(dynamic json) {
    print(json);
    if (json == null) {
      return;
    }
    bmi = json['bmi'];
    bfr = json['bfr']??0.0;
    sfr = json['sfr'];
    uvi = json['uvi'];
    rom = json['rom'];
    bmr = json['bmr'];
    bm = json['bm'];
    vwc = json['vwc'];
    physicalAge = json['physicalAge'];
    pp = json['pp'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['bmi'] = bmi;
    data['bfr'] = bfr??0.0;
    data['sfr'] = sfr;
    data['uvi'] = uvi;
    data['rom'] = rom;
    data['bmr'] = bmr;
    data['bm'] = bm;
    data['vwc'] = vwc;
    data['physicalAge'] = physicalAge;
    data['pp'] = pp;
    return data;
  }

}
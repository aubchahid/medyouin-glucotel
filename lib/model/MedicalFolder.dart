// ignore_for_file: file_names

class MedicalFolder {
  String typeDiabete;
  String mutuele;
  String regime;
  String decouverte;
  String insuline;
  String insulineDepuis;
  String hta;
  String htaDepuis;
  String cholesterol;
  String cholesterolDepuis;
  String alcool;
  String tabagisme;
  String tabagismeDepuis;
  String vitiligo;
  String thyroidienne;
  String coeliaque;
  String addison;
  String renale;
  String depuis;
  String visual;
  String sensibilite;
  String plaie;
  String mycose;
  String durillion;
  bool status;

  MedicalFolder({
    this.typeDiabete = '',
    this.mutuele = '',
    this.regime = '',
    this.decouverte = '',
    this.insuline = '',
    this.insulineDepuis = '-',
    this.hta = '',
    this.htaDepuis = '-',
    this.cholesterol = '',
    this.cholesterolDepuis = '-',
    this.alcool = '',
    this.tabagisme = '',
    this.tabagismeDepuis = '-',
    this.vitiligo = '',
    this.thyroidienne = '',
    this.coeliaque = '',
    this.addison = '',
    this.renale = '',
    this.depuis = '',
    this.visual = '',
    this.sensibilite = '',
    this.plaie = '',
    this.mycose = '',
    this.durillion = '',
    this.status = false,
  });

  factory MedicalFolder.fromJson(Map<String, dynamic> json) {
    return MedicalFolder(
      typeDiabete: json['typeDiabete'],
      mutuele: json['mutuele'],
      regime: json['regime'],
      decouverte: json['decouverte'],
      insuline: json['insuline'],
      insulineDepuis: json['insulineDepuis'],
      hta: json['hta'],
      htaDepuis: json['htaDepuis'],
      cholesterol: json['cholesterol'],
      cholesterolDepuis: json['cholesterolDepuis'],
      alcool: json['alcool'],
      tabagisme: json['tabagisme'],
      tabagismeDepuis: json['tabagismeDepuis'],
      vitiligo: json['vitiligo'],
      thyroidienne: json['thyroidienne'],
      coeliaque: json['coeliaque'],
      addison: json['addison'],
      renale: json['renale'],
      depuis: json['depuis'],
      visual: json['visual'],
      sensibilite: json['sensibilite'],
      plaie: json['plaie'],
      mycose: json['mycose'],
      durillion: json['durillion'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
        'typeDiabete': typeDiabete,
        'mutuele': mutuele,
        'regime': regime,
        'decouverte': decouverte,
        'insuline': insuline,
        'insulineDepuis': insulineDepuis,
        'hta': hta,
        'htaDepuis': htaDepuis,
        'cholesterol': cholesterol,
        'cholesterolDepuis': cholesterolDepuis,
        'alcool': alcool,
        'tabagisme': tabagisme,
        'tabagismeDepuis': tabagismeDepuis,
        'vitiligo': vitiligo,
        'thyroidienne': thyroidienne,
        'coeliaque': coeliaque,
        'addison': addison,
        'renale': renale,
        'depuis': depuis,
        'visual': visual,
        'sensibilite': sensibilite,
        'plaie': plaie,
        'mycose': mycose,
        'durillion': durillion,
        'status': status,
      };
}

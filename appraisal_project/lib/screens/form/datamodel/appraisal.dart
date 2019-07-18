class Appraisal {
  String _id;
  String _address;
  String _city;
  String _state;
  String _zip;
  String _borrower;
  String _owner;
  String _county;
  String _description;
  String _parcel;
  List<String> _mediaCaptured;

  Appraisal(
      this._id,
      this._address,
      this._city,
      this._state,
      this._zip,
      this._borrower,
      this._owner,
      this._county,
      this._description,
      this._parcel,
      this._mediaCaptured);

  Appraisal.map(dynamic obj) {
    this._id = obj['id'];
    this._address = obj['address'];
    this._city = obj['city'];
    this._state = obj['state'];
    this._zip = obj['zip'];
    this._borrower = obj['borrower'];
    this._owner = obj['owner'];
    this._county = obj['county'];
    this._description = obj['description'];
    this._parcel = obj['parcel'];
    this._mediaCaptured = obj['mediaCaptured'];
  }

  String get id => _id;
  String get address => _address;
  String get city => _city;
  String get state => _state;
  String get zip => _zip;
  String get borrower => _borrower;
  String get owner => _owner;
  String get county => _county;
  String get description => _description;
  String get parcel => _parcel;
  List<String> get mediaCaptured => _mediaCaptured;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['address'] = _address;
    map['city'] = _city;
    map['state'] = _state;
    map['zip'] = _zip;
    map['borrower'] = _borrower;
    map['owner'] = _owner;
    map['county'] = _county;
    map['description'] = _description;
    map['parcel'] = _parcel;
    map['mediaCaptured'] = _mediaCaptured;


    return map;
  }

  Appraisal.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._address = map['address'];
    this._city = map['city'];
    this._state = map['state'];
    this._zip = map['zip'];
    this._borrower = map['borrower'];
    this._owner = map['owner'];
    this._county = map['county'];
    this._description = map['description'];
    this._parcel = map['parcel'];
    this._mediaCaptured = map['mediaCaptured'];
  }
}

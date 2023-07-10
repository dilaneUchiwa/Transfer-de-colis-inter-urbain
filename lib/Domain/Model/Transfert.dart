import '../../Domain/Model/Packages.dart';
import '../../Domain/Model/Payment.dart';
import '../../Domain/Model/Travel.dart';
import '../../Domain/Model/UserApp.dart';

class Transfert {
  String? _transfertId;
  Travel _travel;
  Payment? _payment;
  Packages _pack;
  UserApp? _receiver;
  int _code=0;
  bool _finish = false;
  bool _read = false;
  bool _accept = false;
  bool _reject = false;
  DateTime? _createdAt;
  DateTime? _receiptAt;

  Transfert(
      this._transfertId,
      this._travel,
      this._payment,
      this._pack,
      this._receiver,
      this._code,
      this._finish,
      this._read,
      this._accept,
      this._reject,
      this._createdAt,
      this._receiptAt);

  Transfert.withoutIdAndDateTime(
      this._travel, this._payment, this._pack, this._receiver);

  Packages get package => _pack;

  set package(Packages value) {
    _pack = value;
  }

  UserApp get receiver => _receiver!;

  set receiver(UserApp value) {
    _receiver = value;
  }

  Payment get payment => _payment!;

  set payment(Payment value) {
    _payment = value;
  }

  Travel get travel => _travel;

  set travel(Travel value) {
    _travel = value;
  }

  String get transfertId => _transfertId!;

  set transfertId(String value) {
    _transfertId = value;
  }

  bool get isfinish => _finish;

  set finish(bool value) {
    _finish = value;
  }

  bool get isRead => _read;

  set read(bool value) {
    _read = value;
  }

  bool get isAccept => _accept;

  set accept(bool value) {
    _accept = value;
  }

  bool get isReject => _reject;

  set reject(bool value) {
    _reject = value;
  }

  DateTime get createdAT => _createdAt!;

  set createdAt(DateTime value) {
    _createdAt = value;
  }

  DateTime get receiptAT => _receiptAt!;

  set receiptAT(DateTime value) {
    _receiptAt = value;
  }

int get code => _code;

  set code(int value) {
    _code = value;
  }


}

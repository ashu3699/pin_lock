import 'package:pin_lock/src/lock_machine/configuration/storage/attempt_storage_interface.dart';
import 'package:pin_lock/src/lock_machine/configuration/storage/pin_storage_interface.dart';

abstract interface class PinLockStorage implements PinStorageInterface, AttemptStorageInterface {}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pin_lock/src/entities/failure.dart';

part 'setup_stage.freezed.dart';

@freezed
class SetupStage with _$SetupStage {
  const factory SetupStage.base({
    @Default(false) bool isLoading,
    bool? isPinAuthEnabled,
    bool? isBiometricAuthAvailable,
    bool? isBiometricAuthEnabled,
  }) = Base;

  const factory SetupStage.enabling({
    String? pin,
    String? confirmationPin,
    LocalAuthFailure? error,
    @Default(false) bool canSave,
  }) = Enabling;

  const factory SetupStage.disabling() = Disabling;
  const factory SetupStage.changingPasscode() = ChangingPasscode;
}

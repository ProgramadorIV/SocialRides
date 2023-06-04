
class ChangePasswordRequest {
  
  late String oldPassword;
  late String newPassword;
  late String verifyNewPassword;

  ChangePasswordRequest(String oldPassword, newPassword, verifyNewPassword){
    this.newPassword = newPassword;
    this.oldPassword = oldPassword;
    this.verifyNewPassword = verifyNewPassword;
  }
}
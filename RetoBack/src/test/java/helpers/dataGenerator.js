function generarEmail() {
  var timestamp = new Date().getTime();
  return 'qa_user_' + timestamp + '@ejemplo.com';
}
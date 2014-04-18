$(function() {
  return ($('#searchButton')).on('click', function() {
    window.location.href = "/?user=" + (($('#usernameField')).val());
  });
});

$(function() {
  return ($('#searchButton')).on('click', function() {
    return $.get("/tweets", {
      user: ($('#usernameField')).val()
    }, function(data) {
      return console.log(data);
    });
  });
});

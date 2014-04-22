$(function() {
  return ($('#searchButton')).on('click', function() {
    return ($.get("/tweetCount", {
      user: ($('#usernameField')).val()
    })).done(function(data) {
      return console.log(data);
    });
  });
});

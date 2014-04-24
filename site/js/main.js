var chart;

chart = null;

$(function() {
  return ($('#searchButton')).on('click', function() {
    return ($.get("/tweetCount", {
      user: ($('#usernameField')).val()
    })).done(function(data) {
      chart = new Chart(($('#canvas'))[0], data);
      return chart.draw();
    });
  });
});

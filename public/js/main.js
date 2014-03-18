var routes = ['To Manly:Slow Ferry','To Manly:Manly Fast Ferry','To Manly:Sydney Fast Ferries','From Manly:Slow Ferry','From Manly:Manly Fast Ferry','From Manly:Sydney Fast Ferries'];

function updateTime(){
  var now = new Date();
  var d = _.template( '<%= ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"][getMonth()] %> <%= getDate() %> <%= ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"][getDay()] %> <%= (getHours() < 10) ? "0" : "" %><%= getHours() %>:<%= (getMinutes() < 10) ? "0" : "" %><%= getMinutes() %>:<%= (getSeconds() < 10) ? "0" : "" %><%= getSeconds() %>', now );
  $("#time_now").text(d);
  if (now.getSeconds() == 0){
    displayUpcomingAll();
  }
}

function get131500url(){
  var now = new Date();
  var d;
  if ($("#from").prop('checked')) {
    d  = _.template( 'http://tp.transportnsw.info/nsw/XSLT_TRIP_REQUEST2?language=en&type_origin=any&name_origin=10102027&type_destination=any&name_destination=10101103&inclMOT_9=on&routeType=LEASTTIME&inclMOT_0=1&inclMOT_2=1&inclMOT_3=1&inclMOT_6=1&inclMOT_7=1&inclMOT_8=1&inclMOT_10=1&inclMOT_13=1&inclMOT_14=1&inclMOT_15=1&inclMOT_16=1&inclMOT_17=1&sessionID=0&includedMeans=checkbox&commonMacro=true&itdTripDateTimeDepArr=dep&itdTime=<%= getHours() %><%= (getMinutes() < 10) ? "0" : "" %><%= getMinutes() %>&itdDate=<%= getFullYear() %><%= (getMonth() + 1 < 10) ? "0" : "" %><%= getMonth() + 1 %><%= (getDate() < 10) ? "0" : "" %><%= getDate() %>', now );
  } else {
    d  = _.template( 'http://tp.transportnsw.info/nsw/XSLT_TRIP_REQUEST2?language=en&type_origin=any&name_origin=10101103&type_destination=any&name_destination=10102027&inclMOT_9=on&routeType=LEASTTIME&inclMOT_0=1&inclMOT_2=1&inclMOT_3=1&inclMOT_6=1&inclMOT_7=1&inclMOT_8=1&inclMOT_10=1&inclMOT_13=1&inclMOT_14=1&inclMOT_15=1&inclMOT_16=1&inclMOT_17=1&sessionID=0&includedMeans=checkbox&commonMacro=true&itdTripDateTimeDepArr=dep&itdTime=<%= getHours() %><%= (getMinutes() < 10) ? "0" : "" %><%= getMinutes() %>&itdDate=<%= getFullYear() %><%= (getMonth() + 1 < 10) ? "0" : "" %><%= getMonth() + 1 %><%= (getDate() < 10) ? "0" : "" %><%= getDate() %>', now );
  }
  return d;
}

function departure_times(date){
  $.ajax({
      'async': false,
      'global': false,
      'url': "timetable/" + date + ".json",
      'dataType': "json",
      'success': function (data) {
          json = data;
      }
  });
  return json;
}

function displayUpcoming(route){
  var route_times = timetables[date][route];
  var time_now = _.template( '<%= (getHours() < 10) ? "0" : "" %><%= getHours() %>:<%= (getMinutes() < 10) ? "0" : "" %><%= getMinutes() %>', new Date() );
  var time_window = _.template( '<%= (getHours() + 3 < 10) ? "0" : "" %><%= getHours() + 3 %>:<%= (getMinutes() < 10) ? "0" : "" %><%= getMinutes() %>', new Date() );
  var upcoming = _.filter(route_times, function(x){ return x > time_now && x < time_window; });

  var route_provider = route.replace(/.*:/,'');

  $("#timetable").append('<img src="img/' + route_provider.replace(/\s/g, '_') + '.png" class="pull-left"><h6>&nbsp;' + route_provider + '</h6>');
  if (_.isEmpty(upcoming)){
    var x = 'Nothing'
    var remaining = _.filter(route_times, function(x){ return x > time_now });

    if (_.isEmpty(remaining)){
      if (!_.isEmpty(route_times)){
        x = x + ' remaining'
      }
      x = x + ' today'
    } else {
      x = x + ' until ' + remaining[0];
    }

    $("#timetable").append('<ul><li>' + x + ' </li></ul>');
  } else {
    var list = "<ul><% _.each(times, function(time) { time = time.replace(/24:/, '00:'); %> <li><%= time %></li> <% }); %></ul>";
    var timet = _.template(list, {times : upcoming, route_name : route});
    $("#timetable").append(timet);
  }

}

function displayUpcomingAll(){
  date = moment().tz("Australia/Sydney").format("YYYY-MM-DD");
  if (!(date in timetables)) {
    timetables[date] = departure_times(date);
  }

  $("#timetable").html('');
  var routes_filtered = routes;

  if (!$('#from').prop('checked')){
    routes_filtered = _.filter(routes_filtered, function(x){ return (!/^From Manly/.test(x)); });
  }
  if (!$('#to').prop('checked')){
    routes_filtered = _.filter(routes_filtered, function(x){ return (!/^To Manly/.test(x)); });
  }
  _.each(routes_filtered, displayUpcoming);

  var timetableLink = _.template("<li><a href='/timetable/<%= date %>'>See Today's Full Timetable</a></li>");
  var a131500Link = _.template("<li><a href='<%= url %>'><i class='icon-hand-right'></i> Check on Transport NSW</a></li>");
  var aboutLink = "<li><a href= '/about.html'><i class='icon-question-sign'></i> About</a></li>";

  var list = "<ul class='nav nav-pills nav-stacked'><% _.each(links, function(link) { %> <li><%= link %></li> <% }); %></ul>";
  var links = _.template(list, {links: [timetableLink({ date : date }), a131500Link({ url : get131500url() }), aboutLink]});

  $("#timetable").append(links);
}

$("#from").change(function() {
  displayUpcomingAll();
});
$("#to").change(function() {
  displayUpcomingAll();
});
$("#route_selection_button").click(function() {
  if ($("#from").prop('checked')) {
    $("#to").prop('checked', true);
    $("#route_selection_button").html('From Circular Quay <i class="icon-arrow-right icon-white"></i> To Manly');
  } else {
    $("#from").prop('checked', true);
    $("#route_selection_button").html('From Manly <i class="icon-arrow-right icon-white"></i> To Circular Quay');
  }
  displayUpcomingAll();
});

var date;
var timetables = {};

moment.tz.add({
    "zones": {
        "Australia/Sydney": [
            "10:4:52 - LMT 1895_1 10:4:52",
            "10 Aus EST 1971 10",
            "10 AN EST"
        ]
    },
    "rules": {
        "Aus": [
            "1917 1917 0 1 7 0:1 0 1",
            "1917 1917 2 25 7 2 0 0",
            "1942 1942 0 1 7 2 0 1",
            "1942 1942 2 29 7 2 0 0",
            "1942 1942 8 27 7 2 0 1",
            "1943 1944 2 0 8 2 0 0",
            "1943 1943 9 3 7 2 0 1"
        ],
        "AN": [
            "1971 1985 9 0 8 2 2 1",
            "1972 1972 1 27 7 2 2 0",
            "1973 1981 2 1 0 2 2 0",
            "1982 1982 3 1 0 2 2 0",
            "1983 1985 2 1 0 2 2 0",
            "1986 1989 2 15 0 2 2 0",
            "1986 1986 9 19 7 2 2 1",
            "1987 1999 9 0 8 2 2 1",
            "1990 1995 2 1 0 2 2 0",
            "1996 2005 2 0 8 2 2 0",
            "2000 2000 7 0 8 2 2 1",
            "2001 2007 9 0 8 2 2 1",
            "2006 2006 3 1 0 2 2 0",
            "2007 2007 2 0 8 2 2 0",
            "2008 9999 3 1 0 2 2 0",
            "2008 9999 9 1 0 2 2 1"
        ]
    },
    "links": {}
});

updateTime();
displayUpcomingAll();

window.setInterval(updateTime, 1000);
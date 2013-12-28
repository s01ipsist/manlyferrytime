var routes = ['To Manly:Slow Ferry','To Manly:Manly Fast Ferry','To Manly:Sydney Fast Ferries','From Manly:Slow Ferry','From Manly:Manly Fast Ferry','From Manly:Sydney Fast Ferries'];
var departure_times = {"mon":{"To Manly:Slow Ferry":["05:30","06:20","06:50","07:15","07:40","08:10","09:00","09:30","10:00","10:20","10:40","11:00","11:20","11:40","12:00","12:20","12:40","13:00","13:20","13:40","14:00","14:20","14:40","15:00","15:20","15:40","16:00","16:20","16:40","17:00","17:20","17:40","18:00","18:30","19:00","19:30","19:55","20:45","21:30","22:15","23:00","23:45"],"To Manly:Manly Fast Ferry":["07:15","08:09","09:00","10:10","11:10","12:10","13:10","14:10","15:10","16:45","17:40","18:30","19:30"],"To Manly:Sydney Fast Ferries":[],"From Manly:Slow Ferry":["06:10","06:35","07:00","07:30","08:00","08:20","08:50","09:40","10:10","10:40","11:00","11:20","11:40","12:00","12:20","12:40","13:00","13:20","13:40","14:00","14:20","14:40","15:00","15:20","15:40","16:00","16:20","16:40","17:00","17:20","17:40","18:00","18:20","18:40","19:10","19:40","20:10","20:45","21:30","22:15","23:00","23:40"],"From Manly:Manly Fast Ferry":["06:55","07:45","08:35","09:20","10:40","11:40","12:40","13:40","14:40","15:45","17:10","18:05","19:00","19:50"],"From Manly:Sydney Fast Ferries":["06:30","07:20","08:15","09:10","17:25","18:15","19:15","20:05"]},"tue":{"To Manly:Slow Ferry":["05:30","06:20","06:50","07:15","07:40","08:10","08:40","09:00","09:30","10:00","10:30","11:00","11:30","12:00","12:30","13:00","13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00","17:30","18:00","18:30"],"To Manly:Manly Fast Ferry":["07:15","08:09","09:00","10:10","11:10","12:10","13:10","14:10"],"To Manly:Sydney Fast Ferries":[],"From Manly:Slow Ferry":["00:20","06:10","06:35","07:00","07:30","08:00","08:20","08:50","09:20","09:45","10:15","10:45","11:15","11:45","12:15","12:45","13:15","13:45","14:15","14:45","15:15","15:45","16:15","16:45","17:15","17:45","18:15","18:45"],"From Manly:Manly Fast Ferry":["06:55","07:45","08:35","09:20","10:40","11:40","12:40","13:40","14:40"],"From Manly:Sydney Fast Ferries":["06:30","07:20","08:15","09:10","16:30","18:15"]},"wed":{"To Manly:Slow Ferry":["00:40","01:00","01:30","02:10","02:50","03:30","05:00","06:20","06:50","07:15","07:40","08:10","09:00","09:30","10:00","10:20","10:40","11:00","11:20","11:40","12:00","12:20","12:40","13:00","13:20","13:40","14:00","14:20","14:40","15:00","15:20","15:40","16:00","16:20","16:40","17:00","17:20","17:40","18:00","18:30","19:00","19:30","19:55","20:45","21:30","22:15","23:00","23:45"],"To Manly:Manly Fast Ferry":["10:10","11:10","12:10","13:10","14:10","15:10","16:10","17:10","18:10"],"To Manly:Sydney Fast Ferries":[],"From Manly:Slow Ferry":["00:30","01:30","01:50","02:20","02:50","03:30","04:15","05:45","06:35","07:00","07:30","08:00","08:20","08:50","09:40","10:10","10:40","11:00","11:20","11:40","12:00","12:20","12:40","13:00","13:20","13:40","14:00","14:20","14:40","15:00","15:20","15:40","16:00","16:20","16:40","17:00","17:20","17:40","18:00","18:20","18:40","19:10","19:40","20:10","20:45","21:30","22:15","23:00","23:40"],"From Manly:Manly Fast Ferry":["10:40","11:40","12:40","13:40","14:40","15:40","16:40","17:40","18:40"],"From Manly:Sydney Fast Ferries":[]},"thu":{"To Manly:Slow Ferry":["00:20","05:30","06:20","06:50","07:15","07:40","08:10","09:00","09:30","10:00","10:20","10:40","11:00","11:20","11:40","12:00","12:20","12:40","13:00","13:20","13:40","14:00","14:20","14:40","15:00","15:20","15:40","16:00","16:20","16:40","17:00","17:20","17:40","18:00","18:30","19:00","19:30","19:55","20:45","21:30","22:15","23:00","23:45"],"To Manly:Manly Fast Ferry":["07:15","08:09","09:00","10:10","11:10","12:10","13:10","14:10","15:10","16:15","16:45","17:40","18:30","19:30"],"To Manly:Sydney Fast Ferries":[],"From Manly:Slow Ferry":["00:20","00:55","06:10","06:35","07:00","07:30","08:00","08:20","08:50","09:40","10:10","10:40","11:00","11:20","11:40","12:00","12:20","12:40","13:00","13:20","13:40","14:00","14:20","14:40","15:00","15:20","15:40","16:00","16:20","16:40","17:00","17:20","17:40","18:00","18:20","18:40","19:10","19:40","20:10","20:45","21:30","22:15","23:00","23:40"],"From Manly:Manly Fast Ferry":["06:55","07:45","08:35","09:20","10:40","11:40","12:40","13:40","14:40","15:45","17:10","18:05","19:00","19:50"],"From Manly:Sydney Fast Ferries":["06:30","07:20","08:15","09:10","17:25","18:15","19:15","20:05"]},"fri":{"To Manly:Slow Ferry":["05:30","06:20","06:50","07:15","07:40","08:10","09:00","09:30","10:00","10:20","10:40","11:00","11:20","11:40","12:00","12:20","12:40","13:00","13:20","13:40","14:00","14:20","14:40","15:00","15:20","15:40","16:00","16:20","16:40","17:00","17:20","17:40","18:00","18:30","19:00","19:30","19:55","20:45","21:30","22:15","23:00","23:45"],"To Manly:Manly Fast Ferry":["07:15","08:09","09:00","10:10","11:10","12:10","13:10","14:10","15:10","16:15","16:45","17:40","18:30","19:30"],"To Manly:Sydney Fast Ferries":[],"From Manly:Slow Ferry":["00:20","06:10","06:35","07:00","07:30","08:00","08:20","08:50","09:40","10:10","10:40","11:00","11:20","11:40","12:00","12:20","12:40","13:00","13:20","13:40","14:00","14:20","14:40","15:00","15:20","15:40","16:00","16:20","16:40","17:00","17:20","17:40","18:00","18:20","18:40","19:10","19:40","20:10","20:45","21:30","22:15","23:00","23:40"],"From Manly:Manly Fast Ferry":["06:55","07:45","08:35","09:20","10:40","11:40","12:40","13:40","14:40","15:45","17:10","18:05","19:00","19:50"],"From Manly:Sydney Fast Ferries":["06:30","07:20","08:15","09:10","17:25","18:15","19:15","20:05"]},"sat":{"To Manly:Slow Ferry":["00:20","06:20","06:50","07:15","07:40","08:10","09:00","09:30","10:00","10:20","10:40","11:00","11:20","11:40","12:00","12:20","12:40","13:00","13:20","13:40","14:00","14:20","14:40","15:00","15:20","15:40","16:00","16:20","16:40","17:00","17:20","17:40","18:00","18:30","19:00","19:30","19:55","20:45","21:30","22:15","23:00","23:45"],"To Manly:Manly Fast Ferry":["10:10","11:10","12:10","13:10","14:10","15:10","16:10","17:10","18:10","19:10"],"To Manly:Sydney Fast Ferries":[],"From Manly:Slow Ferry":["00:20","00:55","06:35","07:00","07:30","08:00","08:20","08:50","09:40","10:10","10:40","11:00","11:20","11:40","12:00","12:20","12:40","13:00","13:20","13:40","14:00","14:20","14:40","15:00","15:20","15:40","16:00","16:20","16:40","17:00","17:20","17:40","18:00","18:20","18:40","19:10","19:40","20:10","20:45","21:30","22:15","23:00","23:40"],"From Manly:Manly Fast Ferry":["10:40","11:40","12:40","13:40","14:40","15:40","16:40","17:40","18:40","19:40"],"From Manly:Sydney Fast Ferries":[]},"sun":{"To Manly:Slow Ferry":["00:20","06:50","07:15","07:40","08:10","09:00","09:30","10:00","10:20","10:40","11:00","11:20","11:40","12:00","12:20","12:40","13:00","13:20","13:40","14:00","14:20","14:40","15:00","15:20","15:40","16:00","16:20","16:40","17:00","17:20","17:40","18:00","18:30","19:00","19:30","19:55","20:45","21:30","22:15","23:00"],"To Manly:Manly Fast Ferry":["10:10","11:10","12:10","13:10","14:10","15:10","16:10","17:10","18:10"],"To Manly:Sydney Fast Ferries":[],"From Manly:Slow Ferry":["00:20","00:55","07:30","08:00","08:20","08:50","09:40","10:10","10:40","11:00","11:20","11:40","12:00","12:20","12:40","13:00","13:20","13:40","14:00","14:20","14:40","15:00","15:20","15:40","16:00","16:20","16:40","17:00","17:20","17:40","18:00","18:20","18:40","19:10","19:40","20:10","20:45","21:30","22:15","23:00","23:40"],"From Manly:Manly Fast Ferry":["10:40","11:40","12:40","13:40","14:40","15:40","16:40","17:40"],"From Manly:Sydney Fast Ferries":[]},"hol":{"To Manly:Slow Ferry":["00:40","01:00","01:30","02:10","02:50","03:30","05:00","06:20","06:50","07:15","07:40","08:10","09:00","09:30","10:00","10:20","10:40","11:00","11:20","11:40","12:00","12:20","12:40","13:00","13:20","13:40","14:00","14:20","14:40","15:00","15:20","15:40","16:00","16:20","16:40","17:00","17:20","17:40","18:00","18:30","19:00","19:30","19:55","20:45","21:30","22:15","23:00","23:45"],"To Manly:Manly Fast Ferry":["10:10","11:10","12:10","13:10","14:10","15:10","16:10","17:10","18:10"],"To Manly:Sydney Fast Ferries":[],"From Manly:Slow Ferry":["00:30","01:30","01:50","02:20","02:50","03:30","04:15","05:45","06:35","07:00","07:30","08:00","08:20","08:50","09:40","10:10","10:40","11:00","11:20","11:40","12:00","12:20","12:40","13:00","13:20","13:40","14:00","14:20","14:40","15:00","15:20","15:40","16:00","16:20","16:40","17:00","17:20","17:40","18:00","18:20","18:40","19:10","19:40","20:10","20:45","21:30","22:15","23:00","23:40"],"From Manly:Manly Fast Ferry":["10:40","11:40","12:40","13:40","14:40","15:40","16:40","17:40","18:40"],"From Manly:Sydney Fast Ferries":[]}};
var holidays = {"2013":{"1":{" 1":"New Years Day","28":"Australia Day "},"3":{"29":"Good Friday ","30":"Easter Saturday ","31":"Easter Sunday"},"4":{" 1":"Easter Monday ","25":"Anzac Day "},"6":{"10":"Queens Birthday "},"8":{" 5":"Bank Holiday "},"10":{" 7":"Labour Day "},"12":{"25":"Christmas Day","26":"Boxing Day"}},"2014":{"1":{" 1":"New Years Day","27":"Australia Day "},"4":{"18":"Good Friday ","19":"Easter Saturday ","20":"Easter Sunday","21":"Easter Monday ","25":"Anzac Day "},"6":{" 9":"Queens Birthday "},"8":{" 4":"Bank Holiday "},"10":{" 6":"Labour Day "},"12":{"25":"Christmas Day","26":"Boxing Day"}},"2015":{"1":{" 1":"New Years Day","26":"Australia Day "},"4":{" 3":"Good Friday "," 4":"Easter Saturday "," 5":"Easter Sunday"," 6":"Easter Monday ","25":"Anzac Day "},"6":{" 8":"Queens Birthday "},"8":{" 3":"Bank Holiday "},"10":{" 5":"Labour Day "},"12":{"25":"Christmas Day","26":"Boxing Day","28":"Additional Day"}}};

function setDayOfWeek(){
  var now = new Date();
  day_of_week = _.template( '<%= ["sun", "mon", "tue", "wed", "thu", "fri", "sat"][getDay()] %>', now );

  if ((now.getFullYear() in holidays) && ((now.getMonth() + 1) in holidays[now.getFullYear()])){
    var holiday = holidays[now.getFullYear()][now.getMonth() + 1][now.getDate()];
    if( typeof holiday !== 'undefined' ) {
      day_of_week = 'hol';
      $("#ph").text(holiday);
    }
  }
}

function updateTime(){
  var now = new Date();
  var d = _.template( '<%= ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"][getMonth()] %> <%= getDate() %> <%= ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"][getDay()] %> <%= (getHours() < 10) ? "0" : "" %><%= getHours() %>:<%= (getMinutes() < 10) ? "0" : "" %><%= getMinutes() %>:<%= (getSeconds() < 10) ? "0" : "" %><%= getSeconds() %>', now );
  $("#time_now").text(d);
  if (now.getSeconds() == 0){
    displayUpcomingAll();
  }
  if (now.getHours() == 0){
    setDayOfWeek();
  }
}

function get131500url(){
  var now = new Date();
  var d;
  if ($("#from").prop('checked')) {
    d  = _.template( 'http://tp.transportnsw.info/nsw/XSLT_TRIP_REQUEST2?language=en&type_origin=any&name_origin=10102027&type_destination=any&name_destination=10101103&inclMOT_9=on&routeType=LEASTTIME&inclMOT_0=1&inclMOT_2=1&inclMOT_3=1&inclMOT_6=1&inclMOT_7=1&inclMOT_8=1&inclMOT_10=1&inclMOT_13=1&inclMOT_14=1&inclMOT_15=1&inclMOT_16=1&inclMOT_17=1&sessionID=0&includedMeans=checkbox&commonMacro=true&itdTripDateTimeDepArr=dep&itdTime=<%= getHours() %><%= getMinutes() %>&itdDate=<%= getFullYear() %><%= (getMonth() + 1 < 10) ? "0" : "" %><%= getMonth() + 1 %><%= (getDate() < 10) ? "0" : "" %><%= getDate() %>', now );
  } else {
    d  = _.template( 'http://tp.transportnsw.info/nsw/XSLT_TRIP_REQUEST2?language=en&type_origin=any&name_origin=10101103&type_destination=any&name_destination=10102027&inclMOT_1=on&inclMOT_5=on&inclMOT_9=on&inclMOT_4=on&routeType=LEASTTIME&inclMOT_0=1&inclMOT_2=1&inclMOT_3=1&inclMOT_6=1&inclMOT_7=1&inclMOT_8=1&inclMOT_10=1&inclMOT_13=1&inclMOT_14=1&inclMOT_15=1&inclMOT_16=1&inclMOT_17=1&sessionID=0&includedMeans=checkbox&commonMacro=true&itdTripDateTimeDepArr=dep&itdTime=<%= getHours() %><%= getMinutes() %>&itdDate=<%= getFullYear() %><%= (getMonth() + 1 < 10) ? "0" : "" %><%= getMonth() + 1 %><%= (getDate() < 10) ? "0" : "" %><%= getDate() %>', now );
  }
  return d;
}

function displayUpcoming(route){
  var route_times = (departure_times[day_of_week][route]);
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
  $("#timetable").html('');
  var routes_filtered = routes;

  if (!$('#from').prop('checked')){
    routes_filtered = _.filter(routes_filtered, function(x){ return (!/^From Manly/.test(x)); });
  }
  if (!$('#to').prop('checked')){
    routes_filtered = _.filter(routes_filtered, function(x){ return (!/^To Manly/.test(x)); });
  }
  _.each(routes_filtered, displayUpcoming);

  var a131500 = _.template("<a href='<%= url %>'><i class='icon-hand-right'></i> Check on Transport NSW</a>");
  $("#timetable").append(a131500({url : get131500url()}));
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

var day_of_week;
setDayOfWeek();
updateTime();
displayUpcomingAll();

window.setInterval(updateTime, 1000);
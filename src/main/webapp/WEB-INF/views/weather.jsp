<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  			
<!--  <link href="http://openweathermap.org/combine/70a60c128cef9af892512b63a908cc49-1456039778" rel="stylesheet"> -->
    		<!-- <script src="http://openweathermap.org/combine/d101692439773a09e020146fe251340a-1400776594"></script> -->
  			<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js"></script>

			<script type="text/javascript"> 

				function errorHandler(e) {
    				console.log(e);
					ShowAlertMess(e.status + ' ' + e.statusText);
				}

				function set_lang(lang) {
					expires = new Date();
					expires.setTime(expires.getTime() + (1000 * 60 * 60 * 24));
					window.location.reload();
				}

			</script>			
			<script>
			
  				var map;
  				var requestWeather;
  				var geoJSON;
  				var gettingData = false;
  				var openWeatherMapKey = "bad3b5e1cf7bd177757d98780b845028";
  				var lat;
  				var lng;
  
  				function initialize() {
  					
  					if(navigator.geolocation) {
  						navigator.geolocation.getCurrentPosition(
  							function success(position) {
  								var lat = position.coords.latitude;
  								var lng = position.coords.longitude;
  								var mapOptions = {
      								zoom: 12,
      								center: new google.maps.LatLng(lat,lng)
    							};
    							map = new google.maps.Map(document.getElementById('map-canvas'),
        							mapOptions);
        							// Add interaction listeners to make weather requests
								google.maps.event.addListener(map, 'idle', checkIfDataRequested);
									// Sets up and populates the info window with details
								map.data.addListener('click', function(event) {
									infowindow.setContent(
    									"<img src=" + event.feature.getProperty("icon") + ">"
    									+ "<br /><strong>" + event.feature.getProperty("city") + "</strong>"
										+ "<br />" + event.feature.getProperty("temperature") + "&deg;C"
    									+ "<br />" + event.feature.getProperty("weather")
    								);
    								infowindow.setOptions({
    									position:{
        									lat: event.latLng.lat(),
        	    							lng: event.latLng.lng()
        								},
        								pixelOffset: {
            								width: 0,
            								height: -15
        								}
    								});
    								infowindow.open(map);
    								getForecast();
								});
  							},
  							function errorCallback(error) {
  								alert("Geocode was not successful for the following reason: " + error.message);
  							},
  							{
  								maximumAge: Infinity,
  								timeout: 5000
  							}
  						);
  					} else {
  						alert("Functionality not available");
  					};
				}//end initialize()
  
  				var checkIfDataRequested = function() {
   					// Stop extra requests being sent
    				while (gettingData === true) {
      					requestWeather.abort();
      					gettingData = false;
    					}
    				getCoords();
  				};

  				// Get the coordinates from the Map bounds
  				var getCoords = function() {
    				var bounds = map.getBounds();
    				var NE = bounds.getNorthEast();
    				var SW = bounds.getSouthWest();
    				getWeather(NE.lat(), NE.lng(), SW.lat(), SW.lng());
  				};

  				// Make the weather request
  				var getWeather = function(northLat, eastLng, southLat, westLng) {
    				gettingData = true;
    				var requestString = "http://api.openweathermap.org/data/2.5/box/city?bbox="
                        + westLng + "," + northLat + "," //left top
                        + eastLng + "," + southLat + "," //right bottom
                        + map.getZoom() + "&cluster=yes&format=json"
                        + "&APPID=" + openWeatherMapKey;
    				requestWeather = new XMLHttpRequest();
    				requestWeather.onload = proccessResults;
    				requestWeather.open("get", requestString, true);
    				requestWeather.send();
  				};

  				// Take the JSON results and proccess them
  				var proccessResults = function() {
    				console.log(this);
    				var results = JSON.parse(this.responseText);
    				if (results.list.length > 0) {
        				resetData();
        				for (var i = 0; i < results.list.length; i++) {
          					geoJSON.features.push(jsonToGeoJson(results.list[i]));
        				}
        			drawIcons(geoJSON);
    				}
  				};
  	
  				var infowindow = new google.maps.InfoWindow();

  				// For each result that comes back, convert the data to geoJSON
  				var jsonToGeoJson = function (weatherItem) {
    				var feature = {
      					type: "Feature",
      					properties: {
        					city: weatherItem.name,
        					weather: weatherItem.weather[0].main,
        					temperature: weatherItem.main.temp,
        					min: weatherItem.main.temp_min,
        					max: weatherItem.main.temp_max,
        					humidity: weatherItem.main.humidity,
        					pressure: weatherItem.main.pressure,
        					windSpeed: weatherItem.wind.speed,
        					windDegrees: weatherItem.wind.deg,
        					windGust: weatherItem.wind.gust,
        					icon: "http://openweathermap.org/img/w/"
              					+ weatherItem.weather[0].icon  + ".png",
        					coordinates: [weatherItem.coord.lon, weatherItem.coord.lat]
      					},
      					geometry: {
        					type: "Point",
        					coordinates: [weatherItem.coord.lon, weatherItem.coord.lat]
      					}
    				};
    				// Set the custom marker icon
    				map.data.setStyle(function(feature) {
      					return {
        					icon: {
          						url: feature.getProperty('icon'),
          						anchor: new google.maps.Point(25, 25)
        					}
      					};
    				});
    				// returns object
    				return feature;
  				};

  				// Add the markers to the map
  				var drawIcons = function (weather) {
     				map.data.addGeoJson(geoJSON);
     				// Set the flag to finished
     				gettingData = false;
  				};

  				// Clear data layer and geoJSON
  				var resetData = function () {
    				geoJSON = {
      					type: "FeatureCollection",
      					features: []
    				};
    				map.data.forEach(function(feature) {
      					map.data.remove(feature);
    				});
  				};
  
  				google.maps.event.addDomListener(window, 'load', initialize);
			
			</script> 			
<script src="http://openweathermap.org/combine/7397a120786f6cd2568f01d443b988e5-1455184460"></script>
		<script type="text/javascript">

		if(navigator.geolocation) {
  			navigator.geolocation.getCurrentPosition(
  				function success(position) {
  					
  					var lat = position.coords.latitude;
  					var lng = position.coords.longitude;
					var forecast = [];
					
					jQuery(document).ready(function() {
						expires = new Date();
						expires.setTime(expires.getTime() + (1000 * 3600 * 24 * 365));
						var string = "http://api.openweathermap.org/data/2.5/forecast?lat=" 
							+ lat + "&lon=" + lng + "&units=imperial&appid=bad3b5e1cf7bd177757d98780b845028";
						$.getJSON(string, showForecast).error(errorHandler);
								
					function showForecast(d) {
    					if( ! d.list) {
       	 					console.log(d);
    					}
						forecast = d.list;
						showForcastHourlyListLong();
					}

					function showForcastHourlyListLong() {
				
						var curdate = new Date( (new Date()).getTime()- 180 * 60 * 1000 );
						var html = '';
						var lastday = 0;
						var ar_tmin = new Array();
						var ar_tmax = new Array();
						min_cur = 500;
						max_cur = 0;
						lastday = 0;

						for(var i = 0; i <  forecast.length-2; i++){
							if(!forecast[i].main) continue;
							var dt = new Date(forecast[i].dt * 1000);
							if(curdate > dt) continue;
							var day =dt.getDate();
							var hr =dt.getHours();
							if(hr < 10) hr = '0'+hr;
							if(day != lastday) {
								html = html + "<tr class='well'><td colspan='2'><b>"
									+ dt.toDateString() + "</b> </td></tr>";
							lastday = day;
							}
							var temp = Math.round(forecast[i].main.temp);
							var tmin = Math.round(forecast[i].main.temp_min);
							var tmax = Math.round(forecast[i].main.temp_max);
							var text = forecast[i].weather[0].description;
							var img =  forecast[i].weather[0].icon;
							var gust = 0;
							if( forecast[i].wind ) {
		    					gust = forecast[i].wind.speed;
		    				}
							var pressure = forecast[i].main.pressure ;
							var cloud=forecast[i].clouds.all ;
							html = html + '<tr><td>' + hr + ':00 <img src="http://openweathermap.org/img/w/'
								+ img + '.png" > </td><td><span class="badge badge-info">' + temp 
								+ '°F </span> <i>' + text + '</i> ' + '<p>' + tmin + ' to ' + tmax 
								+ '°F. ' + gust + 'm/s. ' + cloud + '%, ' + pressure + ' hpa</p></td></tr>';
						}
						html = '<table class="table">'+html+'</table>';
						$("#hourly_long_list").html(html);
					};
					});
					},
  					function errorCallback(error) {
  						alert("Geocode was not successful for the following reason: " + error.message);
  					},
  					{
  						maximumAge: Infinity,
  						timeout: 5000
  					}
  				);
  			} else {
  				alert("Functionality not available");
  			};

		</script>	
		<div id="map-canvas"></div>
		<div id="search-fields" class="form-group">
			<input name="q" id="search-box" class="form-control form-control-solid placeholder-no-fix" placeholder="Search weather by city name or by zip code."/>
			<input id="go-button" type="submit" value="Go!"/>
		</div>
		<div id="forecast-canvas">
			<div class="col-sm-13">
				<div id="hourly_long_list"></div>
				<script src="http://openweathermap.org/combine/cd70f72c4911208557ac5aa4ffda7623-1393649958"></script>
				<script src="http://openweathermap.org/combine/1f267b7d68c9a2b5e545f6efaa3d1821-1391751372"></script>
			</div>
		</div>
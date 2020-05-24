import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitmartweather/constants/constants.dart';
import 'package:fitmartweather/controller/units.dart';
import 'package:fitmartweather/controller/weather_api_controller.dart';
import 'package:fitmartweather/model/cities.dart';
import 'package:fitmartweather/model/weather.dart';
import 'package:flutter/material.dart';

class SingleCityWeatherPreview extends StatefulWidget
{
  final Weather _weather;
  final Cities _city;

  SingleCityWeatherPreview( this._weather, this._city );

  @override
  State<StatefulWidget> createState() => SingleCityWeatherPreviewState( _weather,this._city );
}

class SingleCityWeatherPreviewState extends State<SingleCityWeatherPreview>
{
  final Weather _weather;
  final Cities _city;
  List<Current> historicWeather = new List();
  List<Daily> futureWeather = new List();

  SingleCityWeatherPreviewState( this._weather, this._city );

  @override
  void initState() {
    WeatherApiController().getPastWeatherDataForCity( _city.lat , _city.long).then((value){
      value.forEach((element) {
        historicWeather.add(element.current);
      });
    });
    
    _weather.daily.forEach((element) { 
      futureWeather.add(element);
    });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 120,left: 10,right: 10,bottom: 10),
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider( Const.WEATHER_TYPE_IMAGE_URL[ _weather.current.weather[0].main ] != null ?
                Const.WEATHER_TYPE_IMAGE_URL[ _weather.current.weather[0].main ]
                    : Const.WEATHER_TYPE_IMAGE_URL[ 'default' ]
                ),
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(Colors.blue.withOpacity(0.2), BlendMode.dstATop),
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text( _city.cityName, style: TextStyle( fontSize: 40,color: Colors.white ), ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CachedNetworkImage(
                          imageUrl: Const.ICON_URL+_weather.current.weather[0].icon + '@2x.png',
                        ),
                        SizedBox( width: 10, ),
                        Column(
                          children: <Widget>[
                            Text( UnitConverter().getCurrentDay(),style: TextStyle( fontWeight: FontWeight.bold ) ),
                            SizedBox(height: 4),
                            Text( 'Today', style: TextStyle( fontSize: 12,color: Colors.blue ) )
                          ],
                        )
                      ],
                    )
                  ],
                ),
                Text( UnitConverter().kelvinToCelsius(_weather.current.temp).toStringAsFixed(0) + '°',
                  style: TextStyle( fontSize: 60 ))
              ],
            ),
          ),
          FutureBuilder(
            future: WeatherApiController().getPastWeatherDataForCity(_city.lat, _city.long),
            builder: (context,AsyncSnapshot<List<Weather>> snapshot){
              if( !snapshot.hasData ){
                return Center( child: Text( 'Loading historic data ..',style: TextStyle( color: Colors.white70 ), ), );
              }
              else
                {
                  var data =  snapshot.data.reversed.toList();
                  return ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                      itemBuilder:(context,index)
                      {
                        return ListTile(
                          title: Text( UnitConverter().getCurrentDayFromTimestamp( data[ index ].current.dt ) ,style: TextStyle(color: Colors.white),),
                          subtitle: Text( UnitConverter().getHumanReadableDate( data[index].current.dt ), style: TextStyle( color: Colors.white70,fontSize: 10 ), ),
                          leading: CachedNetworkImage(imageUrl: Const.ICON_URL+ data[index].current.weather[0].icon+ '@2x.png'),
                          trailing: Text( UnitConverter().kelvinToCelsius(data[index].current.temp).toStringAsFixed(0) + '°',
                              style: TextStyle( fontSize: 20,color: Colors.white )),
                        );
                      } 
                  );
                }
            },
          ),
          ListView.builder(
            itemCount: futureWeather.length,
            shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context,index){
            var data = futureWeather[index];
            return ListTile(
              title: Text( UnitConverter().getCurrentDayFromTimestamp( data.dt ) ,style: TextStyle(color: Colors.white),),
              subtitle: Text( UnitConverter().getHumanReadableDate( data.dt ), style: TextStyle( color: Colors.white70,fontSize: 10 ), ),
              leading: CachedNetworkImage(imageUrl: Const.ICON_URL+ data.weather[0].icon+ '@2x.png'),
              trailing: Text( UnitConverter().kelvinToCelsius(data.temp.day).toStringAsFixed(0) + '°',
                  style: TextStyle( fontSize: 20,color: Colors.white )),
            );
          })
        ],
      ),
    );
  }
}
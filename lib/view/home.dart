import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitmartweather/constants/constants.dart';
import 'package:fitmartweather/controller/cities_controller.dart';
import 'package:fitmartweather/controller/units.dart';
import 'package:fitmartweather/controller/weather_api_controller.dart';
import 'package:fitmartweather/model/cities.dart';
import 'package:fitmartweather/model/weather.dart';
import 'package:fitmartweather/view/single_city_weather.dart';
import 'package:flutter/material.dart';
import 'package:pk_skeleton/pk_skeleton.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        flexibleSpace: Image(
          image: AssetImage('assets/stars.jpg'),
          fit: BoxFit.cover,
        ),
        elevation: 0,
        title: Text('Weather App'),
      ),
      body: Container(
        margin: EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: CitiesController().getCities(),
          builder: (context, AsyncSnapshot<List<Cities>> snapshot) {
            if( !snapshot.hasData )
              {
                return Center( child: CircularProgressIndicator(), );
              }
            else{
              return ListView.builder(
                  itemBuilder: (context,index){
                    return FutureBuilder(
                      future: WeatherApiController().getCurrentWeatherDataForCity(snapshot.data[index].lat, snapshot.data[index].long),
                      builder: (context,AsyncSnapshot<Weather> weatherData)
                      {
                        if( !weatherData.hasData )
                          {
                            return PKDarkCardListSkeleton(
                              isCircularImage: true,
                              isBottomLinesActive: false,
                              length: 1,
                            );
                          }
                        else if( snapshot.hasError || snapshot.data == null)
                          {
                            var snack =SnackBar(content: Text(snapshot.error.toString()) );
                            Scaffold.of(context).showSnackBar(snack);
                            return ListTile( title: Text(snapshot.data[index].cityName), );
                          }
                        else
                          {
                            return GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute( builder: (context)=>SingleCityWeatherPreview( weatherData.data, snapshot.data[index] ) ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider( Const.WEATHER_TYPE_IMAGE_URL[ weatherData.data.current.weather[0].main ] != null ?
                                      Const.WEATHER_TYPE_IMAGE_URL[ weatherData.data.current.weather[0].main ]
                                          : Const.WEATHER_TYPE_IMAGE_URL[ 'default' ]
                                         ),
                                      fit: BoxFit.cover,
                                    colorFilter: new ColorFilter.mode(Colors.blue.withOpacity(0.2), BlendMode.dstATop),
                                  )
                                ),
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text( TimeOfDay.fromDateTime( DateTime.now() ).format(context),style: TextStyle(fontSize: 10), ),
                                        SizedBox( height : 2, ),
                                        Text( snapshot.data[index].cityName,style: TextStyle( fontSize: 20,color: Colors.white ), )
                                      ],
                                    ),
                                    Text( UnitConverter().kelvinToCelsius(weatherData.data.current.temp).toStringAsFixed(0) + '°',
                                      style: TextStyle( fontSize: 40 ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                      },
                    );
                  },
                  itemCount: snapshot.data.length);
            }
          },
        ),
      ),
    );
  }
}

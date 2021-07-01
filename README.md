# YouTube Popular

A Flutter app that fetch popular Youtube videos and play them.

## Whom is this project meant for?

This project might be useful for those beginners who are learning how to call an API from Flutter app using popular libraries like Retrofit, JsonSerializable, and finding a pretty complex example for learning purpose (Because most of the example projects are very simple.). I developed this app while learning about using API in Flutter.

If you are a beginner, I recommend you that firstly you learn how to serialize JSON in both manual way and using code generation libraries way. [This cookbook](https://flutter.dev/docs/development/data-and-backend/json) has well explainations. After that, you should learn calling API from Flutter, from some simple example projects. After that, this project might become useful for you if you wanna find a more complex example.

## API I used
This project uses YouTube data API v3. Visit [here](https://developers.google.com/youtube/v3/docs) to get a free API key, read API documentation, and explore how API works. 

You need an API key if you plan to run the project.
- create `lib/models/sensitiveData.dart` and add the following line
```
String apiKey = "YOUR API KEY HERE";
```

## Important plugins I used

- provider 
- retrofit, retrofit_generator (For calling API)
- json_serializable, json_annotation (For serializing JSON response that we get from API)
- youtube_player_flutter (For playing Youtube videos inside Flutter app)

## Download apk
If you wanna see how the result of the codes look like, [here](jjjj) is the apk.
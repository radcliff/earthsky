# Unofficial EarthSky API

EarthSky.org has the best astronomy content on the web -- now it has a preview API!

# EarthSky Tonight

![EarthSky Tonight screenshot](http://i.imgur.com/Lt2q7zy.png)

EarthSky Tonight is an astronomy blog that features daily posts detailing what is happening in that night's sky and what interesting astronomical features will be visible. This unofficial API scrapes the `/tonight` page for the day's post and caches it as `json` data which is made available through an API endpoint.

## API

### request
`GET api/v1/tonight`

### response
```json
{
  "tonight": {
    "permalink": "http:\/\/earthsky.org\/tonight\/orion-the-hunter-ghost-of-the-summer-dawn",
    "title": "Orion the Hunter: Ghost of summer dawn",
    "img_url": "http:\/\/en.es-static.us\/upl\/2010\/07\/10jul31_430.jpg",
    "summary": "In the wee hours before daybreak, look for Orion the Hunter: Ghost of the summer dawn."
  }
}
```
### request
`GET api/v1/tonight/archive?count=3`

### response
```json
{
  "archive": [
    {
      "date": "2015-07-30",
      "title": "Blue Moon \u2013 second July full moon \u2013 on July 31",
      "summary": "The July 31, 2015 full moon won\u2019t appear blue in color.  But \u2013 as the second of two full moons to occur in a single calendar month \u2013 many will call it a Blue Moon.",
      "img_url": "http:\/\/en.es-static.us\/upl\/2015\/07\/moon-blue-La-Lune-The-Moon-7-27-2015-Patrick-Casaert-sq-e1438256991732.jpg",
      "permalink": "http:\/\/earthsky.org\/tonight\/blue-moon-second-july-full-moon-to-occur-on-july-31"
    },
    {
      "date": "2015-07-29",
      "title": "Blue Moon \u2013 second July full moon \u2013 on July 31",
      "summary": "The July 31, 2015 full moon won\u2019t appear blue in color.  But \u2013 as the second of two full moons to occur in a single calendar month \u2013 many will call it a Blue Moon.",
      "img_url": "http:\/\/en.es-static.us\/upl\/2015\/07\/moon-blue-La-Lune-The-Moon-7-27-2015-Patrick-Casaert-sq-e1438256991732.jpg",
      "permalink": "http:\/\/earthsky.org\/tonight\/blue-moon-second-july-full-moon-to-occur-on-july-31"
    },
    {
      "date": "2015-07-28",
      "title": "Blue Moon \u2013 second July full moon \u2013 on July 31",
      "summary": "The July 31, 2015 full moon won\u2019t appear blue in color.  But \u2013 as the second of two full moons to occur in a single calendar month \u2013 many will call it a Blue Moon.",
      "img_url": "http:\/\/en.es-static.us\/upl\/2015\/07\/moon-blue-La-Lune-The-Moon-7-27-2015-Patrick-Casaert-sq-e1438256991732.jpg",
      "permalink": "http:\/\/earthsky.org\/tonight\/blue-moon-second-july-full-moon-to-occur-on-july-31"
    }
  ]
}
```



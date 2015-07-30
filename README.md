# Unofficial EarthSky API

EarthSky.org has the best astronomy content on the web - Now it has a preview API!

# EarthSky Tonight

![EarthSky Tonight screenshot](http://i.imgur.com/Lt2q7zy.png)

EarthSky Tonight is an astronomy blog that features daily posts detailing what is happening in that night's sky and what interesting astronomical features will be visible. This unofficial API scrapes the `/tonight` page for the day's post and caches it as `json` data which is made available through an API endpoint.

## API

`GET api/v1/tonight`

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




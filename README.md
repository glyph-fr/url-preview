# URL Preview

This Rails engine allows you to retrieve data describing URLs target page.

It can be used when a user pastes (or writes) an URL in an input, to show him
a preview of the URL.

## How does it work ?

The engine fetches the pages from the URLs you give it and uses parsers to
detect the page type and gather as much data as posible from the pages, using
a few strategies :

* Parsing OpenGraph tags
* Parsing default HTML headers like page's title, meta descriptions, images contained in the page and so on.

It then aggregates what it found and renders a JSON visualisation of the
resource, which has a structure like this :

```javascript
{
    "title": "High Tone meets Martin Campbell - Urban Style + Dub",
    "description": " ",
    "images": [
        "https://i1.ytimg.com/vi/MctDZR5vGdQ/maxresdefault.jpg"
    ],
    "type": "video",
    "data": {
        "site_name": "YouTube",
        "url": "http://www.youtube.com/watch?v=MctDZR5vGdQ",
        "video": "http://www.youtube.com/v/MctDZR5vGdQ?autohide=1\u0026version=3",
        "video:type": "application/x-shockwave-flash",
        "video:width": "1920",
        "video:height": "1080"
    },
    "source_url": "https://www.youtube.com/watch?v=MctDZR5vGdQ\u0026feature=kp"
}
```

A javascript plugin (written in Coffeescript) is provided to easily interface
your app with the engine's embed service.

## Installation

Add the gem to your Gemfile and bundle :

```ruby
# Gemfile
gem 'url-preview', github: 'glyph-fr/url-preview'
```

Mount the engine to `/url-preview` in your routes.
For now, be sure to mount it at this URL, since the endpoint is hardcoded
in the javascript plugin.

```ruby
# config/routes.rb
mount UrlPreview::Engine => '/url-preview', :as => 'url_preview'
```

Require the javascript plugin :

```javascript
// app/assets/javascripts/application.js
//= require url-preview
```

## Usage

You can now use the service from Javascript :

```javascript
// Initialize the previewer
preview = new UrlPreview({
  beforeSend: function() { /* e.g. Tell user he's going to wait for the preview to load */ },
  callback: function(data) { /* Use retrieved JSON data here */ },
  error: function() { /* Called when the preview was not found */ }
});

// Process an URL
preview.process("https://www.youtube.com/watch?v=MctDZR5vGdQ&feature=kp")
```

## Licence

MIT-Licence
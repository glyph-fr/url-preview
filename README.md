# URL Preview

This Rails engine allows you to retrieve data describing URLs target page.

It can be used when a user pastes (or writes) an URL in an input, to show him
a preview of the URL.

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
# app/assets/javascripts/application.js

//= require url-preview
```

## Usage

You can now use the service from Javascript :

```javascript
preview = new UrlPreview({
  beforeSend: function() { /* e.g. Tell user he's going to wait for the preview to load */ },
  callback: function(data) { /* Use retrieved JSON data here */ },
  error: function() { /* Called when the preview was not found */ }
})
```

## How does it work ?

The engine uses `curb` to fetch pages and uses parsers to detect the page type
and to gather as much data as posible from the pages.

It relies on OpenGraph meta tags when available.
When not available, it uses the default HTML headers, like page's title,
meta descriptions, images contained in the page and so on.


## Licence

MIT-Licence
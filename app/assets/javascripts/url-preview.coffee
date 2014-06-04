class @UrlPreview
  URL_PATTERN = /\b(https?:\/\/[^\s]+)\b/i

  constructor: (options) ->
    @reset()
    @options = options
    @serviceUrl = '/url-preview'

  process: (str, callback) ->
    if !(url = @parseStr(str))
      @lastRequest.url = null
      @previewNotFound()
      return
    else if @lastRequest.url == url
      return

    @options.beforeSend?()
    # Keep last url for future preview requests
    @lastRequest.url = url
    @requestPreview(url, callback)

  # Parsing
  # Checking if str matches url regex
  parseStr: (str) ->
    urls = str.match(URL_PATTERN)
    return urls[1] if urls

  # Send request to remote service
  requestPreview: (url, callback) ->
    $.getJSON(@serviceUrl, url: url)
      .done((resp) => @processResponse(resp, callback))

  # Response handling
  processResponse: (resp) ->
    @lastRequest.data = resp
    @options.callback?(resp) if resp

  previewNotFound: ->
    @options.error?()

  reset: ->
    @lastRequest = { url: null, data: null }

$.fn.urlPreview = (options = {}) ->
  this.each ->
    # Get preview object or build a new if none exist
    return if (preview = $(this).data('url-preview'))
    preview = new UrlPreview(options)
    $(this).data('url-preview', preview)

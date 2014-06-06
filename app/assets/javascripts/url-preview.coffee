class @UrlPreview
  URL_PATTERN = /((https?:\/\/)|([-a-zA-Z0-9@:%._\+~#=]+\.))?[-a-zA-Z0-9@%._\+~#=]{2,256}\.[a-z]{2,10}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)/g
  
  constructor: (options) ->
    @reset()
    @options = options
    @serviceUrl = '/url-preview'

  process: (str) ->
    if !(url = @parseStr(str))
      @lastRequest.url = null
      @previewNotFound()
      return
    else if @lastRequest.url == url
      return

    @options.beforeSend?()
    # Keep last url for future preview requests
    @lastRequest.url = url
    @requestPreview(url)

  # Parsing
  # Checking if str matches url regex
  parseStr: (str) ->
    urls = str.match(URL_PATTERN)
    if urls
      "http://".concat(urls[0]) unless urls[0].match(/https?:\/\//)
      return urls[0] 

  # Send request to remote service
  requestPreview: (url, callback) ->
    $.getJSON(@serviceUrl, url: url)
      .done((resp) => @processResponse(resp))

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

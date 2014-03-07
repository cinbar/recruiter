class Authorizer
  constructor: (url, data) ->
    @url = url
    @data = data

  authenticate: ->
    $.ajax
        type: "POST",
        url: @url,
        crossDomain: true,
        data: @data,
        dataType: 'json',
        success: (data, textStatus, jqXHR) =>
          inspect(data)
        error: (jqXHR, textStatus, errorThrown) =>
          console.log("Auth Error. #{jqXHR.responseText}")
          
  inspect: (token) ->
    alert("got token, checking validity")
    $.ajax
        type: "POST",
        url: "/identify",
        data: 
          access_token: token,
        dataType: 'json',
        success: (data, textStatus, jqXHR) =>
          alert("Welcome")
        error: (jqXHR, textStatus, errorThrown) =>
          console.log("Auth Error. #{jqXHR.responseText}")

(exports ? this).Authorizer = Authorizer
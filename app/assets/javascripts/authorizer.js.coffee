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
          alert("success")
        error: (jqXHR, textStatus, errorThrown) =>
          console.log("Auth Error. #{jqXHR.responseText}")

(exports ? this).Authorizer = Authorizer
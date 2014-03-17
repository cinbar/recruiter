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
          @inspect(data)
        error: (jqXHR, textStatus, errorThrown) =>
          console.log("Auth Error. #{jqXHR.responseText}")
          
  inspect: (token) ->
    $.ajax
        type: "POST",
        url: "/identify",
        crossDomain: true,
        beforeSend: (xhr) => 
          xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
        data: token,
        dataType: 'json',
        success: (data, textStatus, jqXHR) =>
          if(data == "Error")
            console.log("Inspect Auth Error. #{jqXHR.responseText}")
          else
            window.location.href = "/"
          

(exports ? this).Authorizer = Authorizer
$(document).ready =>
  username = ''

  updateMessage = (data) ->
    $('.message-box').append """
      <div class="col-12">
        <div class="message bg-secondary d-inline-block text-left text-white mb-2">
          <div class="message-bubble">
            <small class="message-username">#{data.username}</small>
            <p class="m-0 message-message">#{data.message}</p>
          </div>
        </div>
      </div>
    """
    return
  
  $('.sidebar-form').keyup (event) ->
    if event.keyCode == 13 and !event.shiftKey
      username = event.target.value
      $('.username').append(username)
      $('#username').val(username)
      $('.username').removeClass('d-none')
      $('.sidebar-form').addClass('d-none')
      $('#message').removeAttr("disabled")
      $('#message').focus()
    return
  
  $('#message-form').on 'ajax:success', (data) ->
    $('#message-form')[0].reset()
    return
  
  pusher = new Pusher('<%= ENV["PUSHER_KEY"] %>',
    cluster: '<%= ENV["PUSHER_CLUSTER"] %>'
    encrypted: true)
  channel = pusher.subscribe('message')
  channel.bind 'new', (data) ->
    updateMessage data
    return
  return
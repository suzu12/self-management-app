import $ from 'jquery'
import consumer from "./consumer"

const autoScroll = () => {
  let element = document.documentElement;
  let bottom = element.scrollHeight - element.clientHeight;
  window.scroll(0, bottom);
}

$(function() {
  const chatChannel = consumer.subscriptions.create({ channel: 'ChatChannel', team: $('#chats').data('team_id') }, {
    connected() {
      autoScroll();
    },

    disconnected() {
    },

    received(data) {
      $('#chats').append(data['chat']);
      autoScroll();
    },

    speak(chat) {
      return this.perform('speak', {
        chat: chat
      });
    }

  });

  $(".form-submit").on('click', function(e){
    let chat = $('.form-chat').val();
    chatChannel.speak(chat);
    $(".form-chat").val('')
    e.preventDefault();
  });
});
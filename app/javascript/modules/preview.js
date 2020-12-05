import $ from 'jquery'
import axios from 'modules/axios'

const previewFormImage = () => {
  $('#team_image').on('change', (e) => {
    $('.image_list > img').remove();
    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);

    const blobImage = $('.image_list').append('<img>');
    $('.image_list > img').attr('src', blob);
  })
}

const previewChatImage = () => {
  $('#chat_photo').on('change', (e) => {
    $('.mychat_image > img').remove();
    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);

    const blobImage = $('.mychat_image').append('<img>');
    $('.mychat_image > img').attr('src', blob);
  })
}

export {
  previewFormImage,
  previewChatImage
}
import $ from 'jquery'
import axios from 'modules/axios'

const handleCommentForm = () => {
  $('.show-comment-form').on('click', () => {
    $('.show-comment-form').addClass('hidden')
    $('.comment-text-area').removeClass('hidden')
  })
}

const appendNewComment = (comment) => {
  $('.comments-container').append(
    `<div class="teams_comment"><li>${comment.content}</li></div>`
  )
}

const appendCommentCount = (commentCount) => {
  $('.comment-header > p').append(
    commentCount
  )
}

const commentDisplayVisibility = () => {
  const dataset = $('#js-team-data').data()
  if (dataset) {
    const teamId = dataset.teamId
    axios.get(`/api/teams/${teamId}/comments`)
      .then((response) => {
        const comments = response.data
        comments.forEach((comment) => {
          appendNewComment(comment)
        })
        const commentCount = $('.teams_comment > li').length
        appendCommentCount(commentCount)
      })
      handleCommentForm()
      $('.add-comment-button').on('click', () => {
        const content = $('#comment_content').val()
        if (!content) {
          window.alert('コメントを入力してください')
        } else {
          axios.post(`/api/teams/${teamId}/comments`, {
            comment: {content: content}
          })
            .then((response) => {
              const comment = response.data
              appendNewComment(comment)
              $('#comment_content').val('')

              const commentCount = $('.teams_comment > li').length
              $('.comment-header > p').html('')
              appendCommentCount(commentCount)
            })
        }
      })
  }
}

export {
  commentDisplayVisibility
}
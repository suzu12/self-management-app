import $ from 'jquery'
import axios from 'modules/axios'

// 「コメントを書く」を押したら、コメントフォームが出てくる処理
const handleCommentForm = () => {
  $('.show-comment-form').on('click', () => {
    $('.show-comment-form').addClass('hidden')
    $('.comment-text-area').removeClass('hidden')
  })
}

// コメントされたらコメントをコメント一覧に表示する処理
const appendNewComment = (comment) => {
  $('.comments-container').append(
    `<div class="teams_comment"><li>${comment.content}</li></div>`
  )
}

const commentDisplayVisibility = () => {
  const dataset = $('#js-team-data').data()
  const teamId = dataset.teamId
  axios.get(`/teams/${teamId}/comments`)
    .then((response) => {
      const comments = response.data
      comments.forEach((comment) => {
        appendNewComment(comment)
      })
    })
    handleCommentForm()
    $('.add-comment-button').on('click', () => {
      const content = $('#comment_content').val()
      if (!content) {
        window.alert('コメントを入力してください')
      } else {
        axios.post(`/teams/${teamId}/comments`, {
          comment: {content: content}
        })
          .then((res) => {
            const comment = res.data
            appendNewComment(comment)
            $('#comment_content').val('')
          })
      }
    })
}

export {
  commentDisplayVisibility
}
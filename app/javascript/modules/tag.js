import $ from 'jquery'
import axios from 'modules/axios'

const appendSearchResult = (tag) => {
  $('#search-result').append(
    `<div class='tag-list'>
      <p id="tag-name${tag.id}">${tag.name}</p>
    </div>`
  )
}

const selectingTag = () => {
  $('#teams_tag_name').on('keyup', () => {
    const keyword = $('#teams_tag_name').val()
    if (keyword) {
    axios.get(`/teams/search/?keyword=${keyword}`)
      .then((response) => {
        const tagName = response.data.keyword
        $('#search-result').html('')
        tagName.forEach((tag) => {
          appendSearchResult(tag)
          const clickElement = $(`#tag-name${tag.id}`)
          $(clickElement).on('click', () => {
            const clickKeyword = `${tag.name}`
            $('#teams_tag_name').val(clickKeyword)
            clickElement.remove()
          })
        })
      })
    }
  })
}

export {
  selectingTag
}
import $ from 'jquery'
import axios from 'modules/axios'

const likeCountCalculation = (likeCount) => {
  $('.star_counter > span').append(
    `${likeCount}人`
  )
}

const elementInActiveStarLikeGet = () => {
  $('.in-active-star').each(function (index, element) {
    const likeData = $(element).data()
    if (likeData) {
    const teamId = likeData.teamId
    axios.get(`/api/teams/${teamId}/like`)
      .then((response) => {
        const inActiveStatus = response.data.hasLiked
        if ( inActiveStatus === false ) {
          $(element).removeClass('hidden')
        }
        const likeCount = response.data.likeCount
        likeCountCalculation(likeCount)
      })
    }
  })
}

const elementActiveStarLikeGet = () => {
  $('.active-star').each(function (index, element) {
    const likeData = $(element).data()
    if (likeData) {
    const teamId = likeData.teamId
    axios.get(`/api/teams/${teamId}/like`)
      .then((response) => {
        const activeStatus = response.data.hasLiked
        if ( activeStatus === true) {
          $(element).removeClass('hidden')
        }
      })
    }
  })
}

const listenInActiveStarLikeEvent = () => {
  $('.in-active-star').on('click', (e) => {
    e.preventDefault()
    const dataset = $(e.currentTarget).data()
    const teamId = dataset.teamId
    axios.post(`/api/teams/${teamId}/like`)
    .then((response) => {
      if (response.data.status === 'ok') {
        $(`#in-active-star${teamId}`).addClass('hidden');
        $(`#active-star${teamId}`).removeClass('hidden');
      }
      const likeCount = response.data.likeCount
      $('.star_counter > span').html('')
      likeCountCalculation(likeCount)
    })
    .catch((e) => {
      window.alert('Error')
      console.log(e)
    })
  })
}

const listenActiveStarLikeEvent = () => {
  $('.active-star').on('click', (e) => {
    e.preventDefault();
    const dataset = $(e.currentTarget).data()
    const teamId = dataset.teamId
    axios.delete(`/api/teams/${teamId}/like`)
    .then((response) => {
      if (response.data.status === 'ok') {
        $(`#active-star${teamId}`).addClass('hidden');
        $(`#in-active-star${teamId}`).removeClass('hidden');
      }
      const likeCount = response.data.likeCount
      $('.star_counter > span').html('')
      likeCountCalculation(likeCount)
    })
    .catch((e) => {
      window.alert('Error')
      console.log(e)
    })
  })
}

export {
  elementInActiveStarLikeGet,
  elementActiveStarLikeGet,
  listenInActiveStarLikeEvent,
  listenActiveStarLikeEvent
}
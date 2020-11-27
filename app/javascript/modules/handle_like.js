import $ from 'jquery'
import axios from 'modules/axios'

const elementInActiveStarLikeGet = () => {
  $('.in-active-star').each(function (index, element) {
    let likeData = $(element).data()
    let getId = likeData.teamId
    axios.get(`/teams/${getId}/like`)
      .then((response) => {
        const inActiveStatus = response.data.hasLiked
        if ( inActiveStatus === false ) {
          $(element).removeClass('hidden')
        } 
      })
  })
}

const elementActiveStarLikeGet = () => {
  $('.active-star').each(function (index, element) {
    let likeData = $(element).data()
    let getId = likeData.teamId
    axios.get(`/teams/${getId}/like`)
      .then((response) => {
        const activeStatus = response.data.hasLiked
        if ( activeStatus === true) {
          $(element).removeClass('hidden')
        } 
      })
  })
}

const listenInActiveStarLikeEvent = () => {
  $('.in-active-star').on('click', (e) => {
    e.preventDefault()
    const dataset = $(e.currentTarget).data()
    const teamId = dataset.teamId
    axios.post(`/teams/${teamId}/like`)
    .then((response) => {
      if (response.data.status === 'ok') {
        $(`#in-active-star${teamId}`).addClass('hidden');
        $(`#active-star${teamId}`).removeClass('hidden');
      }
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
    axios.delete(`/teams/${teamId}/like`)
    .then((response) => {
      if (response.data.status === 'ok') {
        $(`#active-star${teamId}`).addClass('hidden');
        $(`#in-active-star${teamId}`).removeClass('hidden');
      }
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
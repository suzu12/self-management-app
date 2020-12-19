import $ from 'jquery'
import axios from 'modules/axios'

const handleFollowStatus = (followStatus) => {
  if ( followStatus === true ) {
    $('.followed-js').removeClass('hidden')
  } else {
    $('.following-js').removeClass('hidden')
  }
}

document.addEventListener('DOMContentLoaded', () => {
  $('.followed-js').each(function (index, account) {
    if (account) {
      const followedId = $(account).data().account
      axios.get(`/api/accounts/${followedId}/follows`)
      .then((response) => {
        const followStatus = response.data.followed
        handleFollowStatus(followStatus)
      })
    }
  })

  $('.followed-js').on('click', (e) => {
    const dataset = $(e.currentTarget).data()
    const accountId = dataset.account

    axios.post(`/api/accounts/${accountId}/unfollows`)
    .then((response) => {
      if (response.data.status === 'ok') {
        $(`#followed-js${accountId}`).addClass('hidden')
        $(`#following-js${accountId}`).removeClass('hidden')

        const followerCount = response.data.followerCount
        $('.follow-count-js').html(followerCount)
      }
    })
    .catch((e) => {
      window.alert('Error')
      console.log(e)
    })
  })

  $('.following-js').on('click', (e) => {
    const dataset = $(e.currentTarget).data()
    const accountId = dataset.account

    axios.post(`/api/accounts/${accountId}/follows`)
    .then((response) => {
      if (response.data.status === 'ok') {
        $(`#followed-js${accountId}`).removeClass('hidden')
        $(`#following-js${accountId}`).addClass('hidden')

        const followerCount = response.data.followerCount
        $('.follow-count-js').html(followerCount)
      }
    })
    .catch((e) => {
      window.alert('Error')
      console.log(e)
    })
  })
})
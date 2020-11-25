import $ from 'jquery'
import axios from 'axios'

import { csrfToken } from 'rails-ujs'

// リクエスト時にCSRFトークンを持たせる
axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

document.addEventListener('DOMContentLoaded', () => {

  // ロード時にいいねされていない星を配列で取得
  $('.in-active-star').each(function (index, element) {
    // テンプレートで記述したカスタムデータを取得
    let likeData = $(element).data()
    // カスタムデータからチームIDを取得
    let getId = likeData.teamId
    // カスタムデータを入れてGETリクエストを送る
    axios.get(`/teams/${getId}/like`)
      // リクエストを送ったらレスポンスが返ってくる
      .then((response) => {
        // responseでrenderされたlikeの状態を取得(true or false)
        const inActiveStatus = response.data.hasLiked
        // falseであればいいねされていない => 白い星を表示するために、'hidden'を取り外す
        if ( inActiveStatus === false ) {
          $(element).removeClass('hidden')
        } 
      })
  })

  // ロード時にいいねされている星を配列で取得
  $('.active-star').each(function (index, element) {
    // テンプレートで記述したカスタムデータを取得
    let likeData = $(element).data()
    // カスタムデータからチームIDを取得
    let getId = likeData.teamId
    // カスタムデータを入れてGETリクエストを送る
    axios.get(`/teams/${getId}/like`)
      // リクエストを送ったらレスポンスが返ってくる
      .then((response) => {
        // responseでrenderされたlikeの状態を取得(true or false)
        const activeStatus = response.data.hasLiked
        // trueであればいいねされている => 黄色い星を表示するために、'hidden'を取り外す
        if ( activeStatus === true) {
          $(element).removeClass('hidden')
        } 
      })
  })

  // #create いいねをつけたいときの処理
  $('.in-active-star').on('click', (e) => {
    e.preventDefault();
    let dataset = $(e.currentTarget).data()
    // クリックした要素のidを取得
    let teamId = dataset.teamId
    // teamIdを使いPOSTリクエストを送る
    axios.post(`/teams/${teamId}/like`)
    .then((response) => {
      // リクエスト成功なら処理を行う
      if (response.data.status === 'ok') {
        $(`#in-active-star${teamId}`).addClass('hidden');
        $(`#active-star${teamId}`).removeClass('hidden');
      }
    })
    // エラー時の処理
    .catch((e) => {
      window.alert('Error')
      console.log(e)
    })

  })

  // #destroy いいねを外したいときの処理
  $('.active-star').on('click', (e) => {
    e.preventDefault();
    let dataset = $(e.currentTarget).data()
    // クリックした要素のidを取得
    let teamId = dataset.teamId
    // teamIdを使いdeleteメソッドを使う
    axios.delete(`/teams/${teamId}/like`)
    .then((response) => {
      // リクエスト成功なら処理を行う
      if (response.data.status === 'ok') {
        $(`#active-star${teamId}`).addClass('hidden');
        $(`#in-active-star${teamId}`).removeClass('hidden');
      }
    })
    // エラー時の処理
    .catch((e) => {
      window.alert('Error')
      console.log(e)
    })
  })

})
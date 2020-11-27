import $ from 'jquery'
import axios from 'modules/axios'

import {
  elementInActiveStarLikeGet,
  elementActiveStarLikeGet,
  listenInActiveStarLikeEvent,
  listenActiveStarLikeEvent,
} from 'modules/handle_like'

import {
  commentDisplayVisibility
} from 'modules/comment'

import {
  headerPulldownMenu,
  teamSettingChange
} from 'modules/pulldown_menu'

document.addEventListener('DOMContentLoaded', () => {
  headerPulldownMenu()
  teamSettingChange()

  elementInActiveStarLikeGet()
  elementActiveStarLikeGet()
  listenInActiveStarLikeEvent()
  listenActiveStarLikeEvent()

  commentDisplayVisibility()
})

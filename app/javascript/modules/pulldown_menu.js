import $ from 'jquery'
import axios from 'modules/axios'

const headerPulldownMenu = () => {
  $('.pulldown').on('click', () => {
    const pulldownContent = $('.pulldown_content')
    if (pulldownContent.hasClass('hidden')) {
      $(pulldownContent).removeClass('hidden')
    } else {
      $(pulldownContent).addClass('hidden')
    }
  })
}

const teamSettingChange = () => {
  $('.team_setting').on('click', () => {
    const teamSetting = $('.team_setting_change')
    if (teamSetting.hasClass('hidden')) {
      teamSetting.removeClass('hidden')
    } else {
      teamSetting.addClass('hidden')
    }
  })
}

export {
  headerPulldownMenu,
  teamSettingChange
}
const set = ( () => {
  const set = document.getElementById('set')
  const setList = document.getElementById('set-list')
  const teamSettingChange = document.querySelectorAll('.team_setting_change')
    if ( set != null ) {
      set.addEventListener('click', () => {
        if (setList.getAttribute('style') == 'display:block;') {
          setList.removeAttribute('style', 'display:block;');
        } else {
          setList.setAttribute('style', 'display:block;');
        }
      });

      teamSettingChange.forEach(function (content) {
      });
    };
});

window.addEventListener('load', set)
const pullDown = ( () => {
  const pullDownButton = document.getElementById('pulldown')
  const pullDownList = document.getElementById('pulldown-list')
  const pullDownContent = document.querySelectorAll('.pulldown_content')
    if ( pullDownButton != null ) {
      pullDownButton.addEventListener('click', () => {
        if (pullDownList.getAttribute('style') == 'display:block;') {
          pullDownList.removeAttribute('style', 'display:block;');
        } else {
          pullDownList.setAttribute('style', 'display:block;');
        }
      });

      pullDownContent.forEach(function (content) {
      });
    };
});

window.addEventListener('load', pullDown)

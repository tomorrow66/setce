// Hide the iPhone Safari address bar
// Works on load and on device rotation
// Has no effect is the content doesn't fill the height
//
// Example: <script src="/js/hide_addressbar.js"></script>

function hideAddressBar() { window.scrollTo(0, 0); }

addEventListener('load', function() { setTimeout(hideAddressBar, 0); }, false);

window.onorientationchange = function() {
  switch(window.orientation) {
    case 0:
    case 180:
      hideAddressBar();
      break;
    case -90:
    case 90:
      hideAddressBar();
      break;
  }
}
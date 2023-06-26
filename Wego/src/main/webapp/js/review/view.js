const menuWrapper = document.querySelector('.menuWrapper');
const buttonContainer = document.querySelector('.buttonContainer');

menuWrapper.addEventListener('mouseenter', function() {
  menuWrapper.classList.add('showButtons');
});

menuWrapper.addEventListener('mouseleave', function() {
  menuWrapper.classList.remove('showButtons');
});

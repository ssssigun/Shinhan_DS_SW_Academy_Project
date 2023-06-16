$(function () {
  $(".spotDetail").click(function () {
    $(".spotModal").fadeIn();
  });

  $(".spotModalContent").click(function (e) {
    // e.preventDefault();
    e.stopPropagation();
  });

  $(".spotModal").click(function (e) {
    $(".spotModal").fadeOut();
  });

  $(".spotModalOutButton").click(function (e) {
    $(".spotModal").fadeOut();
  });
});
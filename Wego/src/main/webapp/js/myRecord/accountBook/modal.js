var scrollY = 0;

$(function () {
  $("#detail").click(function () {
  	console.log("모달");
    $(".modal").fadeIn();

    $(".modal").css("display", "flex");

    disableScroll();
  });

  $(".modalContent").click(function (e) {
    // e.preventDefault();
    e.stopPropagation();
  });

  $(".modal").click(function (e) {
    $(".modal").fadeOut();
    enableScroll();
  });

  $(".modalOutButton").click(function (e) {
    $(".modal").fadeOut();
    enableScroll();
  });
});

function disableScroll() {
  scrollY = document.documentElement.scrollTop;
  console.log(scrollY);

  document.body.style.position = "fixed";
  document.body.style.top = -scrollY + "px";
  document.body.style.overflowY = "scroll";
  document.body.style.width = "100%";
}

function enableScroll() {
  document.body.style.position = "";
  document.body.style.top = "";
  document.body.style.overflowY = "";
  document.body.style.width = "";

  window.scrollTo(0, scrollY);
}

var slideIndex = 1;
var autoIndex = 0;
autoSlides();
showSlides();

function autoSlides(){
  var i;
  var slides = document.getElementsByClassName("mySlides");
  for (i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";
  }
  autoIndex++;
  if (autoIndex > slides.length) {autoIndex = 1}
  slides[autoIndex-1].style.display = "block";
  setTimeout(autoSlides, 8000); // Change image every 2 seconds
  slideIndex=autoIndex;
}

function showSlides(n) {
  var i;
  var slides = document.getElementsByClassName("mySlides");

  if (n > slides.length) {slideIndex = 1}
  if (n < 1) {slideIndex = slides.length}
  for (i = 0; i < slides.length; i++) {
      slides[i].style.display = "none";
  }
  
  slides[slideIndex-1].style.display = "block";
  autoIndex=slideIndex;
}

//Next/previous controls
function plusSlides(n) {
  showSlides(slideIndex += n);
}
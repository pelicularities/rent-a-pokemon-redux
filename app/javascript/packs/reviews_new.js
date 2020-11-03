const reviewElement = document.getElementById('review_description');
const ratingValue = document.getElementById('review_rating');
const submitBtn = document.getElementById('submitBtn');

const requiredFields = [reviewElement, ratingValue];

const isFilled = () => {
  if ((reviewElement.value == '') || (ratingValue.value == '0')) {
    submitBtn.disabled = true;
  } else {
    submitBtn.disabled = false;
  }
};

reviewElement.addEventListener('change', () => {
  isFilled();
});

const star1 = document.getElementById('star1');
const star2 = document.getElementById('star2');
const star3 = document.getElementById('star3');
const star4 = document.getElementById('star4');
const star5 = document.getElementById('star5');

const starsArray = [star1, star2, star3, star4, star5];

const lightStars = (starsArray, starNumber) => {
  const starsArraySlice = starsArray.slice(0, starNumber);
  starsArraySlice.forEach((star) => {
    star.classList.remove('far');
    star.classList.add('fas');
  });
}

const clearStars = (starsArray) => {
  // this function takes an array of FontAwesome stars
  // and clears them so they are empty stars
  starsArray.forEach((star) => {
    if (!star.classList.contains('sticky')) {
      star.classList.remove('fas');
      star.classList.add('far');
    }
  });
}

const clickStars = (starsArray, starNumber) => {
  const starsArraySlice = starsArray.slice(0, starNumber);
  clearStars(starsArray);
  starsArray.forEach((star) => {
    star.classList.remove('sticky');
  });
  starsArraySlice.forEach((star) => {
    star.classList.remove('far');
    star.classList.add('fas');
    star.classList.add('sticky');
  });
  ratingValue.value = starNumber;
  isFilled();
}

starsArray.forEach((star, index) => {
  star.addEventListener('mouseover', () => {
    lightStars(starsArray, index + 1);
  });
});

starsArray.forEach((star) => {
  star.addEventListener('mouseout', () => {
    clearStars(starsArray);
  });
});

starsArray.forEach((star, index) => {
  star.addEventListener('click', () => {
    clickStars(starsArray, index + 1);
  });
});


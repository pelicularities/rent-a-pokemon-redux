// Modified from: https://medium.com/@sonia.montero/date-validations-and-flatpickr-setup-for-rails-24c78d6eb784
// First we define two variables that are going to grab our inputs field. You can check the ids of the inputs with the Chrome inspector.
import flatpickr from 'flatpickr';

const startDateInput = document.getElementById('rental_start_date');
const endDateInput = document.getElementById('rental_end_date');
const totalPriceElement = document.getElementById('total_price');
const submitBtn = document.getElementById('submitBtn');
const price = Number.parseInt(totalPriceElement.dataset.price, 10);

const calculateTotalPrice = (startDate, endDate, pricePerDay) => {
  // returns amount to pay for booking based on number of days between start and end date inclusive
  return pricePerDay * ((Date.parse(endDate) - Date.parse(startDate)) / 86400000 + 1)
};

const checkValidity = () => {
  const startDate = startDateInput.value;
  const endDate = endDateInput.value;
  if (Date.parse(endDate) - Date.parse(startDate) < 0) {
    endDateInput.value = "";
  }
}

const updateTotalPrice = () => {
  const startDate = startDateInput.value;
  const endDate = endDateInput.value;
  if (startDate && endDate) {
    const totalPrice = calculateTotalPrice(startDate, endDate, price);
    totalPriceElement.innerHTML = totalPrice.toLocaleString('en-SG', { style: 'currency', currency: 'SGD' });
    submitBtn.disabled = false;
  } else {
    totalPriceElement.innerHTML = '$0.00';
    submitBtn.disabled = true;
  };
};

const pokemonRentalFlatpickr = () => {
  // Check that the query selector id matches the one you put around your form.
  if (startDateInput) {
    const unavailableDates = JSON.parse(document.querySelector('#pokemon-rental-dates').dataset.unavailable)
    endDateInput.disabled = true

    flatpickr(startDateInput, {
      minDate: "today",
      disable: unavailableDates,
      dateFormat: "Y-m-d",
    });

    startDateInput.addEventListener("change", (e) => {
      if (startDateInput != "") {
        endDateInput.disabled = false
      }
      flatpickr(endDateInput, {
        minDate: e.target.value,
        disable: unavailableDates,
        dateFormat: "Y-m-d",
      });
    });
  };

  startDateInput.addEventListener("change", (e) => {
    // if start date is after end date, clear existing end date
    checkValidity();
    updateTotalPrice();

  });

  endDateInput.addEventListener("change", (e) => {
    updateTotalPrice();
  });

};

export { pokemonRentalFlatpickr };
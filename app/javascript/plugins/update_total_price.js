const totalPriceElement = document.getElementById('total-price')
const startDateElement = document.getElementById('rental_start_date')
const endDateElement = document.getElementById('rental_end_date')

const calculateTotalPrice = () => {
  const endDate = Date.parse(endDateElement.value);
  const startDate = Date.parse(startDateElement.value);
  console.log(endDate - startDate);
}

const updateTotalPrice = () => {
  startDateElement.addEventListener('change', calculateTotalPrice());
  endDateElement.addEventListener('change', calculateTotalPrice());
  console.log("hello");
}

export { updateTotalPrice };
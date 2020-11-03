// disable submitBtn unless all required fields are filled in
const nameElement = document.getElementById('pokemon_name');
const descriptionElement = document.getElementById('pokemon_description');
const priceElement = document.getElementById('pokemon_price');
const locationElement = document.getElementById('pokemon_location');
const pokemonElement = document.getElementById('pokemon_pokedex_id');
const submitBtn = document.getElementById('submitBtn');

const requiredFields = [nameElement, descriptionElement, priceElement, locationElement, pokemonElement];

const isFilled = (requiredFields) => {
  requiredFields.forEach((field) => {
    if (field.value == '') {
      return false;
    }
  });
  return true;
};

requiredFields.forEach((field) => {
  field.addEventListener('change', (e) => {
    if (isFilled(requiredFields)) {
      submitBtn.disabled = false;
    } else {
      submitBtn.disabled = true;
    }
  });
});

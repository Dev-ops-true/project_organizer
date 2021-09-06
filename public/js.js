const addRowBtn = document.getElementById("insertRow");
const labourForm = document.getElementById("labour_form");
let count = 1;

addRowBtn.addEventListener("click", () => {
  addLabourLines();
});

const addLabourLines = () => {
  const labourInputs = `<div> <input type="text" name="labour_desc_${count}" placeholder="Description" /> <input type="number" name="labour_unit_price_${count}" placeholder="unit price" /> <input type="number" name="labour_quantity_${count}" placeholder="quantity" /> <input type="number" name="labour_mark_up_${count}" placeholder="mark up" /> <input type="number" name="labour_total_${count}" placeholder="total" /></div>`;
  labourForm.insertAdjacentHTML("beforeend", labourInputs);
  count += 1;
};

let input = document.createElement("input");
let div = document.createElement("div");
div.innerHTML = input;

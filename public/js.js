const addLabourRowBtn = document.getElementById("insertLabourRow");
const addMaterialRowBtn = document.getElementById("insertMaterialRow");
const labourForm = document.getElementById("labour_form");
const materialsForm = document.getElementById("materials_form");
const expensesForm = document.getElementById("expenses_form");
const addExpenseRowBtn = document.getElementById("insertExpenseRow");

let labourCount = 1;

addLabourRowBtn.addEventListener("click", () => {
  console.log("hello");
  addLabourLines();
});

const addLabourLines = () => {
  const labourInputs = `<div> <input type="text" name="labour_desc_${labourCount}" placeholder="Description" /> <input type="number" name="labour_unit_price_${labourCount}" placeholder="unit price" /> <input type="number" name="labour_quantity_${labourCount}" placeholder="quantity" /> <input type="number" name="labour_mark_up_${labourCount}" placeholder="mark up" /> <input type="number" name="labour_total_${labourCount}" placeholder="total" /></div>`;
  labourForm.insertAdjacentHTML("beforeend", labourInputs);
  labourCount += 1;
};

let materialCount = 1;

addMaterialRowBtn.addEventListener("click", () => {
  addMaterialLines();
});

const addMaterialLines = () => {
  const materialsInputs = `<div>
      <input type="text" name="material_desc_${materialCount}" placeholder="Description" />
      <input type="number" name="material_unit_price_${materialCount}" placeholder="unit price" />
      <input type="number" name="material_quantity_${materialCount}" placeholder="quantity" />
      <input type="number" name="material_mark_up_${materialCount}" placeholder="mark up" />
      <input type="number" name="material_total_${materialCount}" placeholder="total" />
    </div>`;
  materialsForm.insertAdjacentHTML("beforeend", materialsInputs);
  materialCount += 1;
};

let expenseCount = 1;

addExpenseRowBtn.addEventListener("click", () => {
  addExpenseLine();
});

const addExpenseLine = () => {
  const expenseInputs = `<div>
      <input type="text" name="expense_desc_${expenseCount}" placeholder="Description" />
      <input type="number" name="expense_unit_price_${expenseCount}" placeholder="unit price" />
      <input type="number" name="expense_quantity_${expenseCount}" placeholder="quantity" />
      <input type="number" name="expense_mark_up_${expenseCount}" placeholder="mark up" />
      <input type="number" name="expense_total_${expenseCount}" placeholder="total" />
    </div>`;
  expensesForm.insertAdjacentHTML("beforeend", expenseInputs);
  expenseCount += 1;
};

window.onload = runThis = () => {
  const unitPrice = document.getElementById("expense_unit_price_0");
  const unitQuantity = document.getElementById("expense_quantity_0");
  const unitMarkUp = document.getElementById("expense_mark_up_0");
  const calculateBtn = document.getElementById("calucalte_total");
  const totalInput = document.getElementById("expense_total_0");

  let price = 0;
  let quantity = 0;
  let markUp = 0;

  calculateBtn.addEventListener("click", () => {
    workingOutTotal();
  });

  unitPrice.addEventListener("change", (event) => {
    price = event.target.value;
    return price;
  });

  unitQuantity.addEventListener("change", (event) => {
    quantity = event.target.value;
    return quantity;
  });

  unitMarkUp.addEventListener("change", (event) => {
    markUp = event.target.value;
    return markUp;
  });

  // const inputValue = (event) => {

  // }

  const workingOutTotal = () => {
    const total = price * quantity + (markUp / 100) * (price * quantity);
    console.log(total);
    totalInput.value = total
  };
};

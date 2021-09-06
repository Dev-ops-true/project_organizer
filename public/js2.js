const extraLabourLinesFormBtn = document.getElementById("insertMoreLines");
const formLocation = document.getElementById("extraLabourLines");

let count = 1;

extraLabourLinesFormBtn.addEventListener("click", () => {
  console.log("hrllo");
  addExtraLabourLines();
});

const addExtraLabourLines = () => {
  let extraLabourCounter = 10000;
  const extraLines = `<form action="/labour/extra" method="post">
  <h2>More Labour</h2>
  <div id="labour_form">
    <div>
      <input type='hidden' name='current_quote_id' value='<%= @quote.id %>' />
      <input type="text" name="labour_desc_0" placeholder="Description" />
      <input type="number" name="labour_unit_price_0" placeholder="unit price" />
      <input type="number" name="labour_quantity_0" placeholder="quantity" />
      <input type="number" name="labour_mark_up_0" placeholder="mark up" />
      <input type="number" name="labour_total_0" placeholder="total" />
    </div>
  </div>
  <button type="button" id="insertRow">Add row</button>    
  <input type="submit" value="Submit" />
</form>`;
  formLocation.insertAdjacentHTML("beforeend", extraLines);
  extraLabourCounter += 1;
};

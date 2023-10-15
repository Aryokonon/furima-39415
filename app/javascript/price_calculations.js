javascript_include_tag

document.addEventListener('DOMContentLoaded', () => {
  const priceInput = document.getElementById('item-price');
  const addTaxPrice = document.getElementById('add-tax-price');
  const profit = document.getElementById('profit');

  priceInput.addEventListener('input', () => {
    const inputValue = Number(priceInput.value); // Explicit conversion to Number
    
    if (inputValue >= 300 && inputValue <= 9999999) {
      const tax = Math.floor(inputValue * 0.1); // 10% fee
      const earnings = inputValue - tax; // Adjusted Profit
      addTaxPrice.textContent = tax;
      profit.textContent = earnings;
    } else {
      addTaxPrice.textContent = '---';
      profit.textContent = '---';
    }
  });
});

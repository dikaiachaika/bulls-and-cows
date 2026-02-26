document.addEventListener('DOMContentLoaded', function() {
  const guessInput = document.querySelector('input[name="guess"]');
  
  if (guessInput) {
    guessInput.addEventListener('input', function(e) {

      this.value = this.value.replace(/[^0-9]/g, '');
      

      if (this.value.length > 4) {
        this.value = this.value.slice(0, 4);
      }
      

      const value = this.value;
      const submitBtn = document.querySelector('input[type="submit"]');
      
      if (value.length === 4) {
        const uniqueDigits = new Set(value.split('')).size;
        
        if (uniqueDigits !== 4) {

          showError(this, 'Цифры не должны повторяться!');
          if (submitBtn) submitBtn.disabled = true;
        } else {

          hideError(this);
          if (submitBtn) submitBtn.disabled = false;
        }
      } else {
        hideError(this);
        if (submitBtn) submitBtn.disabled = false;
      }
    });
  }
  
  function showError(input, message) {

    hideError(input);
    

    input.style.borderColor = '#dc3545';
    

    const errorDiv = document.createElement('div');
    errorDiv.className = 'validation-error';
    errorDiv.style.color = '#dc3545';
    errorDiv.style.fontSize = '14px';
    errorDiv.style.marginTop = '5px';
    errorDiv.style.fontWeight = 'bold';
    errorDiv.textContent = message;
    
    input.parentNode.appendChild(errorDiv);
  }
  
  function hideError(input) {

    input.style.borderColor = '#ddd';
    

    const existingError = input.parentNode.querySelector('.validation-error');
    if (existingError) {
      existingError.remove();
    }
  }
});
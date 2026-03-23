document.addEventListener('DOMContentLoaded', function() {
  const guessInput = document.querySelector('input[name="guess"]');
  
  if (guessInput) {
    
    const maxLength = parseInt(guessInput.getAttribute('maxlength')) || 4;
    
    guessInput.addEventListener('input', function(e) {
    
      this.value = this.value.replace(/[^0-9]/g, '');
      
      
      if (this.value.length > maxLength) {
        this.value = this.value.slice(0, maxLength);
      }
      
      const value = this.value;
      const submitBtn = document.querySelector('input[type="submit"]');
      
      
      if (value.length === maxLength) {
        const uniqueDigits = new Set(value.split('')).size;
        
      
        if (uniqueDigits !== maxLength) {
          showError(this, `Цифры не должны повторяться! Введите ${maxLength} ${getDigitPhrase(maxLength).different} ${getDigitPhrase(maxLength).word}`);
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

    const observer = new MutationObserver(function(mutations) {
      mutations.forEach(function(mutation) {
        if (mutation.attributeName === 'maxlength') {
          const newMaxLength = parseInt(guessInput.getAttribute('maxlength')) || 4;

          console.log('maxlength updated to:', newMaxLength);
        }
      });
    });

    observer.observe(guessInput, { attributes: true });
  }

  const passwordInput = document.getElementById('password-field');
  if (passwordInput) {
    passwordInput.addEventListener('input', function () {
      const value = this.value;

      if (value.length < 6) {
        showError(this, 'Пароль должен быть минимум 6 символов');
      } else {
        hideError(this);
      }
    });
  }


  function getDigitPhrase(count) {
    let word = (count === 3 || count === 4) ? "цифры" : "цифр";
    let different = (count === 3 || count === 4) ? "разные" : "разных"; 
    return { word, different };
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

function showSection(section, element) {
  document.getElementById('games-section').style.display = 'none';
  document.getElementById('records-section').style.display = 'none';
  document.getElementById(section + '-section').style.display = 'block';
  const buttons = document.querySelectorAll('.tab-btn');
  buttons.forEach(btn => btn.classList.remove('active'));
  element.classList.add('active');
}


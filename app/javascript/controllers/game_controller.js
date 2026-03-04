import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]
  
  connect() {
    if (this.hasInputTarget) {
      this.inputTarget.addEventListener('input', this.validateInput.bind(this))
    }
  }
  
  validateInput(event) {
    const input = this.inputTarget
    const maxLength = parseInt(input.getAttribute('maxlength')) || 4
    
    input.value = input.value.replace(/[^0-9]/g, '')
    
    if (input.value.length > maxLength) {
      input.value = input.value.slice(0, maxLength)
    }
  }
}
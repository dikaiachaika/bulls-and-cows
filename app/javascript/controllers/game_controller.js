// app/javascript/controllers/game_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]
  
  connect() {
    this.inputTarget.addEventListener('input', this.validateInput.bind(this))
  }
  
  validateInput(event) {
    // Разрешаем только цифры
    this.inputTarget.value = this.inputTarget.value.replace(/[^0-9]/g, '')
    
    // Ограничиваем длину до 4 символов
    if (this.inputTarget.value.length > 4) {
      this.inputTarget.value = this.inputTarget.value.slice(0, 4)
    }
  }
}
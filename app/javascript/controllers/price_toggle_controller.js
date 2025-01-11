// app/javascript/controllers/price_toggle_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["fixedPrice", "minPrice", "maxPrice", "gridContainer", "stockQuantity"]

  connect() {
    this.toggleFields()
  }

  toggleFields() {
    const isNegotiable = this.element.querySelector('input[type="checkbox"]').checked

    if (isNegotiable) {
      this.fixedPriceTarget.style.display = 'none'
      this.minPriceTarget.style.display = 'block'
      this.maxPriceTarget.style.display = 'block'
      this.gridContainerTarget.classList.replace('md:grid-cols-3', 'md:grid-cols-4')
      this.stockQuantityTarget.classList.add('md:col-start-4')
    } else {
      this.fixedPriceTarget.style.display = 'block'
      this.minPriceTarget.style.display = 'none'
      this.maxPriceTarget.style.display = 'none'
      this.gridContainerTarget.classList.replace('md:grid-cols-4', 'md:grid-cols-3')
      this.stockQuantityTarget.classList.remove('md:col-start-4')
    }
  }
}
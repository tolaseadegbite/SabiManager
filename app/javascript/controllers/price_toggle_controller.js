import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["fixedPrice", "minPrice", "maxPrice", "gridContainer", "stockQuantity"]

  connect() {
    this.toggleFields()
  }

  toggleFields() {
    const isNegotiable = this.element.querySelector('input[type="checkbox"]').checked

    if (isNegotiable) {
      // Hide fixed_price and clear its value
      this.fixedPriceTarget.style.display = 'none'
      this.fixedPriceTarget.querySelector('input').value = ''

      // Show min_price and max_price
      this.minPriceTarget.style.display = 'block'
      this.maxPriceTarget.style.display = 'block'

      // Adjust grid layout
      this.gridContainerTarget.classList.replace('md:grid-cols-3', 'md:grid-cols-4')
      this.stockQuantityTarget.classList.add('md:col-start-4')
    } else {
      // Show fixed_price
      this.fixedPriceTarget.style.display = 'block'

      // Hide min_price and max_price and clear their values
      this.minPriceTarget.style.display = 'none'
      this.maxPriceTarget.style.display = 'none'
      this.minPriceTarget.querySelector('input').value = ''
      this.maxPriceTarget.querySelector('input').value = ''

      // Adjust grid layout
      this.gridContainerTarget.classList.replace('md:grid-cols-4', 'md:grid-cols-3')
      this.stockQuantityTarget.classList.remove('md:col-start-4')
    }
  }
}
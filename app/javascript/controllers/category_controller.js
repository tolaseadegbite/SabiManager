import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["select"]

  handleSubmit(event) {
    if (event.detail.success) {
      const [data, status] = event.detail
      if (status === 201) { // Created status
        // Get the select element
        const select = this.selectTarget
        
        // Add the new option
        const option = new Option(data.name, data.id)
        select.add(option)
        
        // Set it as selected
        select.value = data.id
        
        // Close the modal
        const closeButton = document.querySelector('.close-modal-btn')
        if (closeButton) closeButton.click()
      }
    }
  }
}
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["balance"]

  connect() {
    this.originalBalance = this.balanceTarget.value
    console.log("Account Balance controller connected")
  }

  submitForm(event) {
    if (this.balanceTarget.value !== this.originalBalance) {
      if (!confirm("This will change the balance of the account without recording a transaction. Are you sure?")) {
        event.preventDefault()
      }
    }
  }
}
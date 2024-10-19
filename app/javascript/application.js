// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// Import Hotwire for turbo-drive functionality

import "controllers"
import "@hotwired/turbo-rails"
import { Application } from "@hotwired/stimulus"
import { definitionForType } from "@hotwired/stimulus-definition"

const application = Application.start()

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Custom Stimulus controller for account balance confirmation
application.register("account-balance", class extends Controller {
  static targets = ["form", "balance"]

  connect() {
    this.originalBalance = this.balanceTarget.value
  }

  submitForm(event) {
    if (this.balanceTarget.value !== this.originalBalance) {
      if (!confirm("This will change the balance of the account without recording a transaction. Are you sure?")) {
        event.preventDefault()
      }
    }
  }
})

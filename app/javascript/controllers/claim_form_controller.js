import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["startDate", "endDate", "policy"]

  connect() {
    this.setStartDate()
  }

  setEndDate() {
    this.endDateTarget.min = this.startDateTarget.value
    this.endDateTarget.value = this.startDateTarget.value
    // set the max end date to 2 years after the start date
    var maxEndDate = new Date(this.startDateTarget.value)
    maxEndDate.setFullYear(maxEndDate.getFullYear() + 2)
    this.endDateTarget.max = maxEndDate.toISOString().split('T')[0]
  }

  setStartDate() {
    const policy = this.policyTarget.value

    if (policy === "Single Trip") {
      var maxStartDate = new Date()
      maxStartDate.setMonth(maxStartDate.getMonth() + 18)
      this.startDateTarget.max = maxStartDate.toISOString().split('T')[0]
    }
  }
}
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["startDate", "endDate", "hasCruise", "cruiseLabel", "snowDestroy"]

  connect() {
    this.setCruiseText()
  }

  setEndDate() {
    this.endDateTarget.min = this.startDateTarget.value
    this.endDateTarget.value = this.startDateTarget.value
  }

  setCruiseText() {
    if (this.hasCruiseTarget.checked) {
      this.cruiseLabelTarget.textContent = "Cruise Included"
    } else {
      this.cruiseLabelTarget.textContent = "Cruise Not Included"
    }
  }

  removeSnow() {
    this.snowDestroyTarget.value = '1'
    this.endDateTarget.value = ''
    this.startDateTarget.value = ''
  }
}
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.startY = 0
    this.endY = 0
    this.lastRefresh = 0
    
    this.bindEvents()
  }

  bindEvents() {
    this.element.addEventListener('touchstart', this.touchStart.bind(this), { passive: true })
    this.element.addEventListener('touchmove', this.touchMove.bind(this), { passive: true })
    this.element.addEventListener('touchend', this.touchEnd.bind(this), { passive: true })
  }

  touchStart(event) {
    this.startY = event.touches[0].pageY
  }

  touchMove(event) {
    this.endY = event.touches[0].pageY
  }

  touchEnd() {
    if (window.scrollY === 0 && this.endY > this.startY + 300) {
      const now = new Date().getTime()
      if (now - this.lastRefresh > 3000) {
        location.reload()
        this.lastRefresh = now
      }
    }
  }
}
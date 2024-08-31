import { Application } from "@hotwired/stimulus"
import "stylesheets/application";


const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

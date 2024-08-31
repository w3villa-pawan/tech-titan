import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static targets = ["messages"]
  static values = { ChatId: Number }

  connect() {
    console.log(`Connecting to ChatChannel with ID ${this.ChatIdValue}`)
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatChannel", id: this.ChatIdValue },
      {
        received: (data) => {
          console.log("Received data:", data);
          this.#insertMessage(data);
        }
      }
    )
  }

  afterMessageSent() {
    this.#scrollToBottom()
  }

  #insertMessage(message) {
    this.messagesTarget.insertAdjacentHTML("beforeend", data)
    this.#scrollToBottom()
  }

  #scrollToBottom() {
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }

  disconnect() {
    console.log("Unsubscribed from the Chat")
    this.channel.unsubscribe()
  }

  resetForm(event) {
    event.target.reset()
  }
}

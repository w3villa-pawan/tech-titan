import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static targets = ["messages"]
  static values = { chatId: Number }

  connect() {
    console.log(`Connecting to ChatChannel with ID ${this.chatIdValue}`)
    this.channel = consumer.subscriptions.create(
      { channel: "ChatChannel", id: this.chatIdValue },
      {
        received: (data) => {
          console.log("Received data:", data)
          this.#insertMessage(data)
        }
      }
    )
  }

  afterMessageSent() {
    this.#scrollToBottom()
  }

  #insertMessage(data) {
    if (!data) return
    // Prefer sanitized HTML provided by the server. If not present, fall back to plain text.
    if (data.html) {
      this.messagesTarget.insertAdjacentHTML("beforeend", data.html)
    } else if (data.text || data.message || data.body) {
      const text = data.text || data.message || data.body
      const paragraph = document.createElement("p")
      paragraph.textContent = String(text)
      this.messagesTarget.appendChild(paragraph)
    } else {
      return
    }
    this.#scrollToBottom()
  }

  #scrollToBottom() {
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }

  disconnect() {
    console.log("Unsubscribed from the Chat")
    if (this.channel) this.channel.unsubscribe()
  }

  resetForm(event) {
    event.target.reset()
  }
}

import { Controller } from "@hotwired/stimulus"

// Search page: asks the JSON API for the rooms with fetch and draws the cards.
export default class extends Controller {
    static targets = [ "form", "status", "results" ]

    connect() {
        this.search()
    }

    async search(event) {
        if (event) event.preventDefault()

        const params = new URLSearchParams()
        for (const [ name, value ] of new FormData(this.formTarget)) {
            if (value) params.append(name, value)
        }

        this.statusTarget.textContent = "Searching..."
        const response = await fetch(`/api/v1/listings?${params}`, { headers: { Accept: "application/json" } })
        const json = await response.json()

        if (!response.ok) {
            this.statusTarget.textContent = json.error
            this.resultsTarget.innerHTML = ""
            return
        }

        this.statusTarget.textContent = json.meta.count === 1 ? "1 room found" : `${json.meta.count} rooms found`
        this.resultsTarget.innerHTML = json.data.map((listing) => this.card(listing)).join("")
    }

    card(listing) {
        const neighborhood = escapeHtml(listing.neighborhood.name)
        const rent = new Intl.NumberFormat("es-CL").format(listing.monthly_rent)
        const date = new Date(`${listing.available_from}T00:00`).toLocaleDateString("en-US", { dateStyle: "long" })
        const photo = listing.photo_url ? `<img src="${listing.photo_url}" class="card-img-top" alt="Room in ${neighborhood}">` : ""

        return `
      <div class="col-md-4">
        <article class="card h-100">
          ${photo}
          <div class="card-body">
            <h3 class="card-title h5"><a href="${listing.url}">${neighborhood}</a></h3>
            <p class="card-text mb-1">$${rent} per month</p>
            <p class="card-text text-muted mb-0">Available from ${date}</p>
          </div>
        </article>
      </div>`
    }
}

function escapeHtml(text) {
    const div = document.createElement("div")
    div.textContent = text
    return div.innerHTML
}
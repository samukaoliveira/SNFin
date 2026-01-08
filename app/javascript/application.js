// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("change", function (e) {
  if (!e.target.classList.contains("js-pago")) return;

  fetch(e.target.dataset.url, {
    method: "PATCH",
    headers: {
      "X-CSRF-Token": e.target.dataset.csrf,
      "Content-Type": "application/json"
    },
    body: JSON.stringify({ pago: e.target.checked })
  });
});


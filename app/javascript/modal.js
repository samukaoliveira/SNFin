window.openModal = function () {
  var modal = document.getElementById("modalLancamento");
  if (modal) {
    modal.style.display = "flex";
  }
};

window.closeModal = function () {
  var modal = document.getElementById("modalLancamento");
  if (modal) {
    modal.style.display = "none";
  }
};

window.toggleMenu = function () {
  var nav = document.getElementById("navLinks");
  if (nav) {
    nav.classList.toggle("aberto");
  }
};

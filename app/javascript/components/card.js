const flipcard = () => {
  document.querySelectorAll(".flip-card").forEach((card) => {
    card.addEventListener("click", (event) => {
      console.log("hello");
      event.currentTarget.classList.toggle('active')
    });
  });
}

export { flipcard };

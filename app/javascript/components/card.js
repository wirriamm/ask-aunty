const flipcard = () => {
  document.querySelectorAll(".flip-card").forEach((flipcard) => {
    flipcard.addEventListener("click", (event) => {
      console.log("hello");
      console.log(event.currentTarget);
    });
  });
}

export { flipcard };

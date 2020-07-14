const flipcard = () => {
  document.querySelectorAll(".flip-card").forEach((card) => {
    card.addEventListener("click", (event) => {
      console.log("hello");
      event.currentTarget.classList.toggle('active')
    });
  });
}

// const prefcard = () => {
//   document.querySelectorAll(".pref-card").forEach((card) => {
//     card.addEventListener("click", (event) => {
//       console.log("hello2");
//       event.currentTarget.classList.toggle('active')
//     });
//   });
// }

export { flipcard };

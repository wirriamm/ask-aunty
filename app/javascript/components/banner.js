import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#banner-typed-text', {
    strings: ["Ask Aunty"],
    typeSpeed: 120,
    loop: false
  });
  $(".typed-cursor").hide()
}

export { loadDynamicBannerText };

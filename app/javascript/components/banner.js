import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#banner-typed-text', {
    strings: ["Ask Aunty"],
    typeSpeed: 100,
    loop: true
  });
  $(".typed-cursor").hide()
}

export { loadDynamicBannerText };

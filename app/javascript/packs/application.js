// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener('turbolinks:load', () => {
    const body = document.getElementsByTagName('body')[0];
    const menuTrigger = document.querySelector('.menu-trigger');
    const notice = document.querySelector('.notice');
    const alert = document.querySelector('.alert');

    menuTrigger.addEventListener('click', () => {
        body.classList.toggle('menu-open');
    });

    if (notice.childNodes.length || alert.childNodes.length) {
        setTimeout(() => {
            notice.classList.add('inactive');
            alert.classList.add('inactive');
        }, 3000)
    }
});
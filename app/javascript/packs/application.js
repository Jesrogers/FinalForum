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
    const menuTrigger = document.querySelectorAll('.menu-trigger');
    const notice = document.querySelector('.notice');
    const alert = document.querySelector('.alert');
    const tabs = document.querySelectorAll('[data-tab-target]');
    const tabContents = document.querySelectorAll('[data-tab-content]');

    menuTrigger.forEach(trigger => {
        trigger.addEventListener('click', () => {
            body.classList.toggle('menu-open');
        });
    });

    if (notice.childNodes.length || alert.childNodes.length) {
        setTimeout(() => {
            notice.classList.add('inactive');
            alert.classList.add('inactive');
        }, 3000)
    }

    tabs.forEach(tab => {
        tab.addEventListener('click', () => {
            const target = document.querySelector(tab.dataset.tabTarget);
            tabContents.forEach(tabContent => {
                tabContent.classList.remove('active');
            });
            tabs.forEach(tab => {
                tab.classList.remove('active');
            });
            tab.classList.add('active');
            target.classList.add('active');
        });
    });




});
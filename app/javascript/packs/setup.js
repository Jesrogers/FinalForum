import {
    body,
    notice,
    alert,
    menuTrigger,
    tabs,
    tabContents
} from './config-vars';

const SETUP = {
    init() {
        this.onTurbolinksLoad();
        this.beforeTurbolinksCache();
    },

    onTurbolinksLoad() {
        document.addEventListener('turbolinks:load', () => {
            this.mobileMenuTrigger();

            if (notice.childNodes.length || alert.childNodes.length) {
                this.flashTimeouts();
            }

            if (tabs.length) {
                this.tabEventListeners();
            }
        });
    },

    beforeTurbolinksCache() {
        document.addEventListener('turbolinks:before-cache', () => {
            if (!document.querySelector('.home')) {
                this.editorCacheCheck();
            }
        });
    },

    mobileMenuTrigger() {
        menuTrigger.forEach(trigger => {
            trigger.addEventListener('click', () => {
                body.classList.toggle('menu-open');
            });
        });
    },

    flashTimeouts() {
        setTimeout(() => {
            notice.classList.add('inactive');
            alert.classList.add('inactive');
        }, 3000)
    },

    tabEventListeners() {
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
    },

    editorCacheCheck() {
        for (const name in CKEDITOR.instances) {
            CKEDITOR.instances[name].destroy();
        }
    }
}

export default SETUP;













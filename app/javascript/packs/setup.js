const SETUP = {
    init() {
        this.onTurbolinksLoad();
        this.beforeTurbolinksCache();
    },

    onTurbolinksLoad() {
        document.addEventListener('turbolinks:load', () => {
            this.mobileMenuTrigger();
            this.tabEventListeners();
            this.flashTimeouts();
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
        const menuTrigger = document.querySelectorAll('.menu-trigger');
        const body = document.getElementsByTagName('body')[0];

        menuTrigger.forEach(trigger => {
            trigger.addEventListener('click', () => {
                body.classList.toggle('menu-open');
            });
        });
    },

    flashTimeouts() {
        const notice = document.querySelector('.notice');
        const alert = document.querySelector('.alert');

        if (notice.childNodes.length || alert.childNodes.length) {
            setTimeout(() => {
                notice.classList.add('inactive');
                alert.classList.add('inactive');
            }, 3000)
        }
    },

    tabEventListeners() {
        const tabs = document.querySelectorAll('[data-tab-target]');
        const tabContents = document.querySelectorAll('[data-tab-content]');

        if (tabs.length) {
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
        }
    },

    editorCacheCheck() {
        for (const name in CKEDITOR.instances) {
            CKEDITOR.instances[name].destroy();
        }
    }
}

export default SETUP;













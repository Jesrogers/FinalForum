class PagesController < ApplicationController
    def home
        render 'static_pages/home', layout: 'home'
    end
end

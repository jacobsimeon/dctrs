class HomeController < ApplicationController
  def index
    @suppress_navbar_search = true
  end
end

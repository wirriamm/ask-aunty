require 'cgi'

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  # def verified_request?
  #     if request.content_type == "application/json"
  #       true
  #     else
  #       super()
  #     end
  # end
end


class DatabaseController < ApplicationController
  def clearData
    User.delete_all
  end
end
